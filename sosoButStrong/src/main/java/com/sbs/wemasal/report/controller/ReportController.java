package com.sbs.wemasal.report.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sbs.wemasal.report.model.service.ReportService;
import com.sbs.wemasal.report.model.vo.Report;

@Controller
public class ReportController {
	
	@Autowired
	private ReportService reportService;
	
	/*
	@ResponseBody
	@RequestMapping(value = "reportCommunity.re")
	public String ajaxInsertReportCommunity(Report re, HttpSession session) {
		
		int reportResult = reportService.selectReportCommunity(re);
		
		if(reportResult > 0) {
			
			return "exist";
			
		} else {
			
			reportService.insertReportCommunity(re);
			
			return "success";
		}
	}
	*/
	
	@RequestMapping(value = "reportCommunity.re")
	public String insertReportCommunity(Report re, HttpSession session) {
		
		int reportResult = reportService.selectReportCommunity(re);
		
		if(reportResult > 0) {
			
			session.setAttribute("alertMsg", "이미 신고하신 게시글입니다.");
			return "redirect:communityList.co";
			
		} else {
			
			reportService.insertReportCommunity(re);
			
			session.setAttribute("alertMsg", "신고되었습니다.");
			
			return "redirect:communityList.co";
		}
	}
	
	@RequestMapping(value = "reportReply.re")
	public String insertReportReply(Report re, HttpSession session, HttpServletRequest request) {
		
		int reportResult = reportService.selectReportReply(re);
		
		if(reportResult > 0) {
			
			session.setAttribute("alertMsg", "이미 신고하신 댓글입니다.");
			
			String referer = request.getHeader("Referer"); // 헤더에서 이전 페이지를 읽는다.
			// http통신중 헤더 안에 있는 referer(전달자)를 읽어온다?
			// referer안에 요청(request)이 어느 url에서 왔는지의 정보를 담고있다(어디서 왔는지 -> 이전 url주소)
			
			return "redirect:" + referer; // 이전 페이지로 리다이렉트
			
		} else {
			
			int result = reportService.insertReportReply(re);
			
			session.setAttribute("alertMsg", "신고되었습니다.");
			
			String referer = request.getHeader("Referer");
			
			return "redirect:" + referer;
		}
	}
	
	
}
