package com.sbs.wemasal.notice.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
		System.out.println(n);
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
		Notice n = noticeService.selectNotice(nno);
		
		mv.addObject("n", n).setViewName("user/notice/noticeDetailView");
		
		return mv;
	}

}
