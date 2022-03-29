package com.sbs.wemasal.report.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.common.template.Pagination;
import com.sbs.wemasal.community.model.vo.CoAttachment;
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
	
	@RequestMapping("communityReportList.re")
	public ModelAndView communityReportList(@RequestParam(value="rpage", defaultValue="1") int currentPage, ModelAndView mv) {
		
		int listCount = reportService.communityReportListCount();
		
		// pageLimit = 10, boardLimit = 9
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		
		ArrayList<Report> list = reportService.communityReportList(pi);
		
		mv.addObject("list", list).addObject("pi", pi).setViewName("admin/report/communityReportListView");;
		
		return mv;
	}
	
	@RequestMapping("replyReportList.re")
	public ModelAndView replyReportList(@RequestParam(value="rpage", defaultValue="1") int currentPage, ModelAndView mv) {
		
		int listCount = reportService.replyReportListCount();
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		
		ArrayList<Report> list = reportService.replyReportList(pi);
		
		mv.addObject("list", list).addObject("pi", pi).setViewName("admin/report/replyReportListView");
		
		return mv;
	}
	
	@RequestMapping("communityReportDetail.re")
	public ModelAndView communityReportDetail(Report re, ModelAndView mv) {
		
		CoAttachment coA = reportService.communityReportDetail(re);
		
		mv.addObject("coA", coA).setViewName("admin/report/communityReportDetailView");
		
		return mv;
	}
	
	
	@RequestMapping("replyReportDetail.re")
	public ModelAndView replyReportDetail(Report re, ModelAndView mv) {
		
		CoAttachment coA = reportService.replyCommunityReportDetail(re);
		
		Report reR = reportService.replyReportDetail(re);
		
		mv.addObject("coA", coA).addObject("reR", reR).setViewName("admin/report/replyReportDetailView");
		
		return mv;
	}
	
	@RequestMapping("deleteCommunityReport.re")
	public String deleteCommunityReport(Report re, HttpSession session) {
		
		int result = reportService.deleteCommunityReport(re);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "신고되었습니다.");
			return "redirect:communityReportList.re";
		}else {
			session.setAttribute("alertMsg", "실패하였습니다.");
			return "redirect:communityReportList.re";
		}
	}
	
	@RequestMapping("rejectCommunityReport.re")
	public String rejectCommunityReport(Report re, HttpSession session) {
		
		System.out.println("반려");
		System.out.println(re);
		
		int result = reportService.rejectCommunityReport(re);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "반려되었습니다.");
			return "redirect:communityReportList.re";
		}else {
			session.setAttribute("alertMsg", "실패하였습니다.");
			return "redirect:communityReportList.re";
		}
	}
	
	@RequestMapping("deleteReplyReport.re")
	public String deleteReplyReport(Report re, HttpSession session) {
		
		int result = reportService.deleteReplyReport(re);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "삭제되었습니다.");
			return "redirect:replyReportList.re";
		}else {
			session.setAttribute("alertMsg", "실패하였습니다.");
			return "redirect:replyReportList.re";
		}
	}
	
	@RequestMapping("rejectReplyReport.re")
	public String rejectReplyReport(Report re, HttpSession session) {
		
		int result = reportService.rejectReplyReport(re);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "반려되었습니다.");
			return "redirect:replyReportList.re";
		}else {
			session.setAttribute("alertMsg", "실패하였습니다.");
			return "redirect:replyReportList.re";
		}
	}
	
}
