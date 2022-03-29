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
import com.sbs.wemasal.member.model.vo.Seller;

@Controller
public class CommunityController {
	
	@Autowired
	private CommunityService communityService;
	
	@RequestMapping("communityList.co")
	public ModelAndView communityList(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv) {
		
		// ----- 베스트레시피 LIST -----
		ArrayList<Community> bestRecipe = communityService.selectTop3List();
		
		// ----- 신규레시피 LIST -----
		
		int listCount = communityService.selectCommunityCount();
		
		// pageLimit = 10, boardLimit = 9
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 9);

		ArrayList<Community> list = communityService.communityList(pi);

		mv.addObject("list", list).addObject("pi", pi).addObject("bestRecipe", bestRecipe).setViewName("user/community/communityListView");
		
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
	public ModelAndView communityDetail(ModelAndView mv, int cno, Like like, HttpServletRequest request) {
		
		// 게시글 정보 조회
		CoAttachment coA = communityService.selectCommunity(cno);
		
		// 기본값으로 0값 대입
		// 비로그인 회원일 경우 null이 아닌 0
		like.setUserNo(0);
		
		// 로그인이 된 회원 정보
		Member mem = (Member)request.getSession().getAttribute("loginUser");
		
		// 로그인이 되어있으면 userNo을 로그인된 회원의 userNo값 대입
		if(mem != null) {
			like.setUserNo(((Member)request.getSession().getAttribute("loginUser")).getUserNo());
		}
		
		like.setComNo(cno); // 조회할 게시글의 번호를 Like객체에 대입
		 
		// 조회한 사람이 해당 게시글을 "좋아요" 했는지 조회와 동시에 대입
		like.setMyLike(communityService.selectIsLike(like));
		
		// "좋아요"를 누르지 않으면 null값이 오는데 "N"값으로 변경해주기
		if(like.getMyLike() == null) {
			like.setMyLike("N");
		}
		
		// 해당 게시글의 "좋아요"수 조회와 동시에 대입
		like.setLikeCount(communityService.selectLikeCount(cno));
		
		System.out.println(like);
		
		if(coA != null) {
			
			mv.addObject("coA", coA).addObject("like", like).setViewName("user/community/communityDetailView");
		
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
