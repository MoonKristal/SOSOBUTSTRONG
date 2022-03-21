package com.sbs.wemasal.question.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sbs.wemasal.question.model.service.QuestionService;

@Controller
public class QuestionController {
	
	@Autowired
	private QuestionService questionService;
	
	@RequestMapping("buyerList.qu")
	public String selectBuyerQuestionList() {
		return "user/question/buyerQuestionListView";
	}
	
	

}
