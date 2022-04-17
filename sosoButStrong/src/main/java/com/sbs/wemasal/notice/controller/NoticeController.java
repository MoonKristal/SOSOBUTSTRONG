package com.sbs.wemasal.notice.controller;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.common.template.Pagination;
import com.sbs.wemasal.common.template.SaveFile;
import com.sbs.wemasal.notice.model.service.NoticeService;
import com.sbs.wemasal.notice.model.vo.Notice;

// 2022.3.29(화) 3h55
@Controller
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping("managerList.no")
	public ModelAndView selectManagerNoticeList(@RequestParam(value="cpage", defaultValue="1") int currentPage, HttpServletRequest request, ModelAndView mv) {
		PageInfo pi = Pagination.getPageInfo(noticeService.selectNoticeListCount(), currentPage, 4, 10);
		
		ArrayList<Notice> list = noticeService.selectManagerNoticeList(pi);
		
		mv.addObject("pi", pi).addObject("list", list).setViewName("admin/notice/managerNoticeListView");
		
		return mv;
	}
	
	// 2022.3.29(화) 5h45
	@RequestMapping("enrollForm.no")
	public String noticeEnrollForm() {
		return "admin/notice/noticeEnrollForm";
	}
	
	// 2022.3.29(화) 6h20
	@RequestMapping("insert.no")
	public String insertNotice(Notice n, MultipartFile upfile, HttpSession session, Model model) {
//		System.out.println(n);
		int result1 = noticeService.insertNotice(n);
		
		int result2 = 1;
		
		if (!upfile.getOriginalFilename().equals("")) {
			Attachment at = new Attachment();
			
			String changeName = SaveFile.saveFile(upfile, session);
			
			at.setOriginName(upfile.getOriginalFilename());
			at.setChangeName("resources/uploadFiles/" + changeName);
			
			result2 = noticeService.insertNoticeAttachment(at);
		}
		
		if (result1 * result2 > 0) {
			session.setAttribute("alertMsg", "공지사항 등록이 완료되었습니다.");
			return "redirect:managerList.no";
		} else {
			model.addAttribute("errorMsg", "1:1문의 글 등록에 실패했습니다.");
			return "user/common/errorPage";
		}
	}
	
	// 2022.3.29(화) 8h
	@RequestMapping("managerDetail.no")
	public ModelAndView selectManagerNotice(ModelAndView mv, int nno) {
		Notice n = noticeService.selectManagerNotice(nno);
		
		mv.addObject("n", n).setViewName("admin/notice/managerNoticeDetailView");
		
		return mv;
	}
	
	// 2022.3.29(화) 8h40
	@RequestMapping("list.no")
	public ModelAndView selectNoticeList(@RequestParam(value="cpage", defaultValue="1") int currentPage, HttpServletRequest request, ModelAndView mv) {
		PageInfo pi = Pagination.getPageInfo(noticeService.selectNoticeListCount(), currentPage, 4, 10);
		
		ArrayList<Notice> list = noticeService.selectNoticeList(pi);
		
		mv.addObject("pi", pi).addObject("list", list).setViewName("user/notice/noticeListView");
		
		return mv;
	}
	
	@RequestMapping("detail.no")
	public ModelAndView selectNotice(ModelAndView mv, int nno) {
		// 2022.4.3(일) 16h55 공지사항 상세 조회 시, 조회 수 추가
		int result = noticeService.increaseCount(nno);
//		System.out.println("increaseCount 결과 = " + result); // 2022.4.3(일) 19h15 null 값 처리 쿼리문 수정 후 테스트 = 'increaseCount 결과 = 1' + db상 조회 수 값도 변경됨
		
		if (result > 0) {
			mv.addObject("n", noticeService.selectNotice(nno)).setViewName("user/notice/noticeDetailView");
		} else {
			mv.addObject("errorMsg", "공지사항 상세 조회에 실패했습니다.").setViewName("user/common/errorPage");
		}
		
		return mv;
	}
	
	// 2022.4.2(토) 18h5
	@RequestMapping("updateForm.no")
	public String updateForm(int nno, Model model) {
		model.addAttribute("n", noticeService.selectManagerNotice(nno));
		return "admin/notice/noticeUpdateForm";
	}
	
	// 2022.4.2(토) 19h40
	@ResponseBody
	@RequestMapping("deleteUpfile.no")
	public String ajaxDeleteUpfile(Notice n, HttpSession session) {
		int result = noticeService.deleteNoticeAttachment(n.getNoticeNo()); // ATTACHMENT 테이블에서 이 noticeNo을 참조하는 파일 행 삭제
		
		if (result > 0) { // ATTACHMENT 테이블에서 행 삭제 성공하면
			new File(session.getServletContext().getRealPath(n.getChangeName())).delete(); // 서버에 물리적으로 저장되어 있는 파일 삭제
			return "success";
			
//			Notice n2 = noticeService.selectManagerNotice(n1.getNoticeNo());
//			return new Gson().toJson(n2);
		} else {
			return "fail";
		}
	}
	
	// 2022.4.2(토) 20h5
	@RequestMapping("update.no")
	public String updateNotice(Notice n, MultipartFile reUpfile, Attachment at, HttpSession session, Model model) {
		int result1 = noticeService.updateNotice(n);
		
		int result2 = 1; // 첨부 파일 관련 db 처리 결과(처리된 행의 개수)를 담을 int형 변수
		
		// 2022.4.3(일) 13h20 로직 정리
		if (!reUpfile.getOriginalFilename().equals("")) { // 공지사항 수정 시, 새로 올리는 첨부 파일이 있는 경우
			String changeName = SaveFile.saveFile(reUpfile, session); // 새로 올리는 첨부 파일의 이름 변경 및 서버에 저장
			
			at.setOriginName(reUpfile.getOriginalFilename()); // 첨부 파일 객체의 '원본 파일명' 필드 값 설정
			at.setChangeName("resources/uploadFiles/" + changeName); // 첨부 파일 객체의 '변경 파일명' 필드 값 설정
			at.setRefNno(n.getNoticeNo()); // 첨부 파일 객체의 '참조 공지사항 번호' 필드 값 설정
			
			if (n.getOriginName() != null) { // 기존 첨부 파일이 있었을 경우
				new File(session.getServletContext().getRealPath(n.getChangeName())).delete(); // 서버에 물리적으로 저장되어 있는 기존 첨부 파일 삭제
				
				result2 = noticeService.updateNoticeAttachment(at); // 위와 같이 값 세팅된 첨부 파일 객체를 dao로 가져가서, ATTACHMENT 테이블에 정보 update
			} else { // 기존 첨부 파일은 없었을 경우 ou 기존 첨부 파일이 있었는데 AJAX "deleteUpfile.no"요청으로 기존 파일 삭제한 경우
				result2 = noticeService.insertNewNoticeAttachment(at);
			}
		}
		
		if (result1 * result2 > 0) {
			session.setAttribute("alertMsg", "성공적으로 공지사항이 수정되었습니다.");
			return "redirect:managerDetail.no?nno=" + n.getNoticeNo();
		} else {
			model.addAttribute("errorMsg", "공지사항 수정에 실패했습니다.");
			return "user/common/errorPage";
		}
		
	}
	
	// 2022.4.2(토) 18h10
	@RequestMapping("delete.no")
	public String deleteNotice(int nno, String filePath, HttpSession session, Model model) {
		int result = noticeService.deleteNotice(nno);
		
		if (result > 0) { // 해당 번호의 공지사항의 상태(status)를 N으로 변경하는 것을 성공한 경우 
			if (!filePath.equals("")) { // 해당 번호의 공지사항에 첨부파일이 있었을 경우
				new File(session.getServletContext().getRealPath(filePath)).delete(); // 서버에 물리적으로 저장되어 있는 파일 삭제
			}
			
			session.setAttribute("alertMsg", "성공적으로 공지사항이 삭제되었습니다.");
			return "redirect:managerList.no";
		} else {
			 model.addAttribute("errorMsg","공지사항 삭제에 실패했습니다.");
			 return "user/common/errorPage";
		}
	}

}
