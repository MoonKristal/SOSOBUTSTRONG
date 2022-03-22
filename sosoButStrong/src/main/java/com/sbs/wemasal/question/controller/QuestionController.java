package com.sbs.wemasal.question.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.common.template.Pagination;
import com.sbs.wemasal.order.model.vo.Order;
import com.sbs.wemasal.question.model.service.QuestionService;
import com.sbs.wemasal.question.model.vo.Question;

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
	
	// 2022.3.18(금) 13h55
	@ResponseBody
	@RequestMapping(value="buyerOrderList.qu")
	public Object ajaxSelectBuyerOrderList(int userNo, @RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv) {
		PageInfo pi = Pagination.getPageInfo(questionService.selectBuyerOrderListCount(userNo), currentPage, 4, 5);
		// pageLimit = 페이지 하단에 보여질/표시되는 paging bar/buttons의 최대 개수 -> 4로 임의 지정
		// boardLimit = 한 페이지에 보여질 게시글의 최대 개수 -> 5로 임의 지정
//		System.out.println(pi);
		// 2022.3.23(수) 0h55 주문 내역 있는 경우 테스트 = PageInfo(listCount=2, currentPage=1, pageLimit=4, boardLimit=5, maxPage=1, startPage=1, endPage=1)
		// 2022.3.23(수) 1h15 주문 내역 없는 경우 테스트 = PageInfo(listCount=0, currentPage=1, pageLimit=4, boardLimit=5, maxPage=0, startPage=1, endPage=0)
		
		// 2022.3.22(화) 18h55
		ArrayList<Order> list = questionService.selectBuyerOrderList(pi, userNo);
		// 요청보낸 구매자 번호의 주문번호 ORDER_NO, 주문일자 ORDER_DATE, 판매자 번호 SELLER, 판매자 SELLER_NAME, 주문상품 ORDER_ITEM, 수량 QUANTITY, 주문금액 ORDER_PRICE 받아와야 함
		
		// 반환 방법1) AJAX 통신 응답 시 ModelAndView 객체(request 객체 같은 것) 사용할 수 있는 것인지 모르겠음
//		mv.addObject("pi", pi).addObject("list", list);
//		return mv;
		
		// 반환 방법2)
//		return new Gson().toJson(list); // 19h10 나의 질문 = pi는 왜 응답해줘야 하지? view단에서 paging 처리해야 하니까 + pi와 list 둘 다 AJAX 응답해주려면 어떻게 해야 하지?
		
		// 2022.3.22(화) 22h35 반환 방법3) RequestMapping 속성 produces="application/json; charset=UTF-8" 추가 -> AJAX 통신 실패로 뜸
		/*
		JSONObject jObj = new JSONObject();
		
		jObj.put("pi", pi);
		jObj.put("list", list);
		
		return jObj.toJSONString();
		*/
		
		// 2022.3.22(화) 23h 반환 방법4)
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("pi", pi);
		result.put("list", list);
		
		return result;
	}
	
	// 2022.3.17(목) 17h15 -> 2022.3.23(수) 1h40 기능 구현
	@ResponseBody
	@RequestMapping("confirmOrderNo.qu")
	public String ajaxConfirmOrderNo(Question q) {
		System.out.println(q);
		int result = questionService.countOrderNo(Question.builder()
													.questionWriter(q.getQuestionWriter())
													.questionSeller(q.getQuestionSeller())
													.orderNo(q.getOrderNo())
													.build());
		
		return result > 0? "Y" : "N"; // 기존 문의 내역이 있으면 Y vs 없으면 N 반환 
	}
	
	// 2022.3.23(수) 3h35
	@ResponseBody
	@RequestMapping(value="searchSeller.qu", produces="application/json; charset=utf-8")
	public String ajaxSearchSeller(String sellerKeyword) {
		return new Gson().toJson(questionService.searchSeller(sellerKeyword));
	}
	
	// 2022.3.17(목) 18h25
	@RequestMapping("buyerInsert.qu")
	public String insertBuyerQuestion() {
		return "redirect:buyerList.qu";
	}
	

}
