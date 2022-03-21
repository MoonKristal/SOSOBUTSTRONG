package com.sbs.wemasal.main.controller;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
import com.sbs.wemasal.main.model.service.MainService;

@Controller
public class MainController {
	
	@Autowired
	private MainService mainService;
	
	@ResponseBody
	@RequestMapping(value="picList.main", produces="application/json; charset=utf-8")
	public String ajaxSelectMain() {
		
		return new Gson().toJson(mainService.ajaxSelectMain());
	}
	
	@ResponseBody
	@RequestMapping(value="picListCount.main", produces="application/json; charset=utf-8")
	public String ajaxSelectMainCount() {
		return new Gson().toJson(mainService.selectMainCount());
	}

	@RequestMapping("picListAd.main")
	public ModelAndView selectList(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv) {
		
		int listCount = mainService.selectMainCount();
		
		// pageLimit = 10, boardLimit = 5
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		
		ArrayList<Attachment> list = mainService.selectMain(pi);
		
		mv.addObject("list", list).addObject("pi", pi).setViewName("admin/main/mainListView");
		
		return mv;
	}
	
	@RequestMapping("insertPicForm.main")
	public String insertPicForm() {
		return "admin/main/mainInsertForm";
	}
	
	@RequestMapping("insertPic.main")
	public String insertPic(Attachment at, MultipartFile upfile, HttpSession session, Model model) {
		
		SaveFile saveFiles = new SaveFile();
		
		String changeName = saveFiles.saveFile(upfile, session);
		
		at.setOriginName(upfile.getOriginalFilename());
		at.setChangeName("resources/uploadFiles/" + changeName);
		
		int result = mainService.insertPic(at);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "사진 등록 성공 =D");
			return "redirect:picListAd.main";
		} else {
			model.addAttribute("errorMsg", "사진 등록 실패 TOT");
			return "redirect:picListAd.main";
		}
			
	}
	
	@RequestMapping("picDeleteAd.main")
	public String deletePic(String filePath, HttpSession session) {
		
		String[] filePaths = filePath.split(",");
		
		System.out.println(filePath);
		
		int result = 0;
		// 서버에서 사진삭제
		for(int i = 0; i < filePaths.length; i++) {
			System.out.println("filePath : " + filePaths[i]);
			new File(session.getServletContext().getRealPath(filePaths[i])).delete();
			result += mainService.deletePic(filePaths[i]);
		}
		
		if(result == filePaths.length) {
			
			session.setAttribute("alertMsg", "사진 삭제 성공 =D");
			return "redirect:picListAd.main";
			
		} else {
			
			session.setAttribute("alertMsg", "사진 삭제 실패");
			return "redirect:picListAd.main";
		}
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
