package com.sbs.wemasal.like.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.wemasal.like.model.service.LikeService;
import com.sbs.wemasal.like.model.vo.Like;
import com.sbs.wemasal.member.model.vo.Member;

@Controller
public class LikeController {
	
	@Autowired
	private LikeService likeService;
	
	@RequestMapping(value = "like.he")
	public void like(Like l, String isLike, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		l.setUserNo(((Member)request.getSession().getAttribute("loginUser")).getUserNo());
		
		System.out.println(isLike);
		System.out.println(l);
		
		int result = 0;
		
		if(isLike.equals("Y")) {
			result = likeService.deleteLike(l);
		} else {
			result = likeService.insertLike(l);
		}
		
		response.setContentType("text/html; charset=utf-8");
		response.getWriter().print(result);
	}
	
	
}
