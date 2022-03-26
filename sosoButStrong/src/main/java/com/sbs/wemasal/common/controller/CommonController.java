package com.sbs.wemasal.common.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sbs.wemasal.member.model.vo.Member;

@Controller
public class CommonController {
	
	/**
	 * 로그인 한 사용자가 마이페이지로 이동 요청시 로그인된 사용자에 따라 각기 다른(관리자/구매자/판매자) 메뉴의 마이페이지로 이동시키기
	 * @return
	 */
	@RequestMapping("myPage.cmm")
	public String letMeGoToMyPage(HttpServletRequest request) {
		
		int memType = ((Member)request.getSession().getAttribute("loginUser")).getUserType(); // 로그인된 회원의 유저타입 가져와서 변수에 담기
		
		String where = ""; // 이동할 페이지 위치 값 담을 빈 문자열 변수 선언
		
		switch(memType) { // 유저타입에 따라 각기 다른 마이페이지로 이동 시키기 위한 조건문
			case 1 : where = "redirect:orderList.od"; break; // 일반회원(구매자)
			case 2 : where = "redirect:sellerProductList.se"; // 판매자
		}
		return where;
	}

}
