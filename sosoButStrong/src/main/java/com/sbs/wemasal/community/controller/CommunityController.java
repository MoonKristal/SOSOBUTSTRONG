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

@Controller
public class CommunityController {
	
	@Autowired
	private CommunityService communityService;
	
	@RequestMapping("communityList.co")
	public ModelAndView communityList(@RequestParam(value="cpage", defaultValue="1") int currentPage,ModelAndView mv) {
		
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
	public String insertCommunity(Community co, Attachment at, MultipartFile upfile, HttpSession session) {
		
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
	public ModelAndView communityDetail(ModelAndView mv, int cno) {
		
		CoAttachment coA = communityService.selectCommunity(cno);
		
		if(coA != null) {
			
			mv.addObject("coA", coA).setViewName("user/community/communityDetailView");
		
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
	
	
	
	
}
