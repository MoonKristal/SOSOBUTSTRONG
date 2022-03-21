package com.sbs.wemasal.question.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.common.template.Pagination;
import com.sbs.wemasal.question.model.service.QuestionService;

@Controller
public class QuestionController {
	
	@Autowired
	private QuestionService questionService;
	
	// 2022.3.17(목) 14h30 구매자 마이페이지 메인으로 forwarding
	@RequestMapping("buyerMyPage.me")
	public String buyerMyPageMain() {
		return "user/common/buyerMyPage";
	}
	
	// 2022.3.7(월) 14h
	@RequestMapping("buyerList.qu")
	public String selectBuyerQuestionList() {
		return "user/question/buyerQuestionListView";
	}
	
	// 2022.3.14(월) 9h30
	@RequestMapping("enrollForm.qu")
	public String questionEnrollForm() {
		return "user/question/buyerQuestionEnrollForm";
	}
	/*
	// 2022.3.18(금) 13h55
	@RequestMapping("buyerOrderList.qu")
	public ModelAndView ajaxSelectBuyerOrderList(int userNo, @RequestParam(value="cpage", defaultValue="1") int currentPage) {
		PageInfo pi = Pagination.getPageInfo(questionService.selectBuyerOrderListCount(), currentPage, 4, 5);
		
	}
	
	// 2022.3.17(목) 17h15
	@ResponseBody
	@RequestMapping("confirmOrderNo.qu")
	public String ajaxConfirmOrderNo(int orderNo) {
		return questionService.countOrderNo();
	}
	*/
	// 2022.3.17(목) 18h25
	@RequestMapping("buyerInsert.qu")
	public String insertBuyerQuestion() {
		return "redirect:buyerList.qu";
	}
	

}
