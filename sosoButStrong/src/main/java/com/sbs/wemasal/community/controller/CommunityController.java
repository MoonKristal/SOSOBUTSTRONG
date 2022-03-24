package com.sbs.wemasal.community.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.common.template.Pagination;
import com.sbs.wemasal.common.template.SaveFile;
import com.sbs.wemasal.community.model.service.CommunityService;
import com.sbs.wemasal.community.model.vo.CoAttachment;
import com.sbs.wemasal.community.model.vo.Community;
import com.sbs.wemasal.community.model.vo.Reply;
import com.sbs.wemasal.community.model.vo.SmarteditorVO;
import com.sbs.wemasal.like.model.vo.Like;
import com.sbs.wemasal.member.model.vo.Member;

@Controller
public class CommunityController {
	
	@Autowired
	private CommunityService communityService;
	
	@RequestMapping("communityList.co")
	public ModelAndView communityList(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv) {
		
		int listCount = communityService.selectCommunityCount();
		
		// pageLimit = 10, boardLimit = 9
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 9);

		ArrayList<Community> list = communityService.communityList(pi);

		mv.addObject("list", list).addObject("pi", pi).setViewName("user/community/communityListView");
		
		return mv;
	}
	
	@RequestMapping("communityInsertForm.co")
	public String communityInsertForm() {
		return "user/community/communityInsertForm";
	}
	
	@RequestMapping("communityInsert.co")
	public String insertCommunity(Community co, Attachment at, MultipartFile upfile, HttpSession session, HttpServletRequest request) {
		
		co.setUserNo(((Member)request.getSession().getAttribute("loginUser")).getUserNo());
		
		int result1 = communityService.insertCommunity(co);
		
		if(!upfile.getOriginalFilename().equals("")) {
			
			SaveFile saveFile = new SaveFile();
			
			String changeName = saveFile.saveFile(upfile, session);
			
			at.setOriginName(upfile.getOriginalFilename());
			at.setChangeName("resources/uploadFiles/" + changeName);
			
			int result2 = communityService.insertPic(at);
			
		}
		
		session.setAttribute("alertMsg", "레시피 작성 성공 =)");
		return "redirect:communityList.co"; // 상세페이지 기능 완료 후 상세페이지경로로 변경
	}
	
	@RequestMapping("communityDetail.co")
	public ModelAndView communityDetail(ModelAndView mv, int cno, Like l, HttpServletRequest request) {
		
		CoAttachment coA = communityService.selectCommunity(cno);
		
		int memberNo = 0;
		
		Member mem = (Member)request.getSession().getAttribute("loginUser");
		
		if(mem != null) {
			 l.setUserNo(((Member)request.getSession().getAttribute("loginUser")).getUserNo());
		}
		l.setComNo(cno);
		 
		//Like like = communityService.selectLike(l);
		
		
		l.setMyLike(communityService.selectIsLike(l));
		//Like like = communityService.selectIsLike2(l);
		//System.out.println(like);
		String isLike = l.getMyLike();
		
		//int likeCount = communityService.selectLikeCount(cno); // 에러
		//System.out.println(likeCount);
		
		
		if(coA != null) {
			
			mv.addObject("coA", coA).addObject("isLike", isLike).setViewName("user/community/communityDetailView");
		
		} else {
			
			mv.addObject("errorMsg", "상세조회실패").setViewName("user/common/errorPage");
			
		}
		return mv;
			
		
	}
	
	
	/**
	 * 스마트에디터에서 사진등록시킬때 필요한 컨트롤러
	 * @param request
	 * @param smarteditorVO
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping("fileUpload.co")
	public String simpleImageUploader(HttpServletRequest request, SmarteditorVO smarteditorVO) throws UnsupportedEncodingException{
		
		String callback = smarteditorVO.getCallback();
		String callback_func = smarteditorVO.getCallback_func();
		String file_result = "";
		String result = "";
		MultipartFile multiFile = smarteditorVO.getFiledata();
		
		try {
			if(multiFile != null && multiFile.getSize() > 0 && StringUtils.isNotBlank(multiFile.getName())) {
				String originName = multiFile.getName();
				
				//파일 확장자
		        String fileName_ext = originName.substring(originName.lastIndexOf(".")+1);
	
		        //확장자를소문자로 변경
		        fileName_ext = fileName_ext.toLowerCase();
				
		        String filePath = request.getSession().getServletContext().getRealPath("/resources/uploadFiles/");

		        File file = new File(filePath);
		        
				if(!file.exists()) {
					file.mkdirs();
				}
				
				String fileName = UUID.randomUUID().toString() + fileName_ext;
				
				smarteditorVO.getFiledata().transferTo(new File(filePath + fileName));
				
				file_result += "&bNewLine=true&sFileName=" + originName + "&sFileURL=http://localhost:8765/wemasal/resources/uploadFiles/" + fileName;
			
			} else {
				file_result += "&errstr= error";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		result = "redirect:" + callback + "?callback_func=" + URLEncoder.encode(callback_func,"UTF-8") + file_result;
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("replyInsert.co")
	public String ajaxInsertReply(Reply re) {
		
		System.out.println(re.getRefComNo());
		
		return communityService.insertReply(re) > 0 ? "success" : "fail";
	}
	
	@ResponseBody
	@RequestMapping(value = "replyList.co", produces="application/json; charset=utf-8")
	public String ajaxReplyList(int refComNo) {
		
		return new Gson().toJson(communityService.selectReplyList(refComNo));
	}
	
	@RequestMapping("myRecipeListView.co")
	public ModelAndView myRecipeListView(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv, HttpServletRequest request) {
		
		int userNo = ((Member)request.getSession().getAttribute("loginUser")).getUserNo();
		
		int listCount = communityService.selectCommunityCount();
		
		// pageLimit = 10, boardLimit = 9
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 9);

		ArrayList<Community> myList = communityService.selectMyList(pi, userNo);
		
		System.out.println(myList);
		
		mv.addObject("myList", myList).addObject("pi", pi).setViewName("user/community/communityMyRecipeListView");
		
		return mv;
	}
	
	@RequestMapping("recipeUpdateForm.co")
	public ModelAndView updateCommunityForm(ModelAndView mv, int cno) {
		
		CoAttachment coA = communityService.selectCommunity(cno);
		
		mv.addObject("coA", coA).setViewName("user/community/communityUpdateForm");
		
		return mv;
	}
	
	@RequestMapping("recipeUpdate.co")
	public String updateCommunity(Community co, Attachment at, CoAttachment coA, MultipartFile reupfile, HttpSession session, HttpServletRequest request) {
		
		System.out.println(coA);
		
		// 새로운 첨부파일이 넘어온 경우
		if(!reupfile.getOriginalFilename().equals("")) {
			// 기존 첨부파일이 있었을 경우 => 기존 첨부파일 삭제
			if(at.getOriginName() != null) {
				// 서버에서 삭제
				new File(session.getServletContext().getRealPath(at.getChangeName())).delete();
				// DB에서 삭제
				int result1 = communityService.deleteAttachment(at);
			}
			
			// 새로 넘어온 첨부파일 서버 업로드 시키기
			SaveFile saveFile = new SaveFile();
			String changeName = saveFile.saveFile(reupfile, session);
			
			// Attachment객체에 새로운 정보 담기
			coA.setOriginName(reupfile.getOriginalFilename());
			coA.setChangeName("resources/uploadFiles/" + changeName);
			
			// 새로 넘어온 첨부파일 DB 등록
			int result2 = communityService.insertAttachment(coA);
			
		}
		
		int result = communityService.updateCommunity(co);
		
		if(result > 0) {
			
			session.setAttribute("alertMsg", "게시글이 수정되었습니다.");
			
			String referer = request.getHeader("Referer"); // 헤더에서 이전 페이지를 읽는다.
			// http통신중 헤더 안에 있는 referer(전달자)를 읽어온다?
			// referer안에 요청(request)이 어느 url에서 왔는지의 정보를 담고있다(어디서 왔는지 -> 이전 url주소)
			
			return "redirect:myRecipeListView.co"; // 이전 페이지로 리다이렉트
			
		} else {
			session.setAttribute("errorMsg", "게시글이 수정되지 않았습니다.");
			return "common/errorPage";
			
		}
		
	}
	
	@RequestMapping("recipeDelete.co")
	public String deleteCommunity(int cno, String filePath, HttpSession session) {
		
		int result = communityService.deleteCommunity(cno);
		
		if(result > 0) {
			
			// 만약에 첨부파일이 있었을 경우 삭제하기
			if(!filePath.equals("")) {
				// 기존에 존재하는 첨부파일 삭제
				// "resources/xxxx/xxxx.jpg" 를 찾으려면 물리적인 경로가 필요하다
				new File(session.getServletContext().getRealPath(filePath)).delete();
			}
			session.setAttribute("alertMsg", "게시글이 삭제되었습니다.");
			return "redirect:/communityList.co";
			
		} else {
			
			session.setAttribute("alertMsg", "게시글이 삭제되지 않았습니다.");
			return "redirect:/communityList.co";
			
		}
		
		
	}
	
	
	
	
	
}
