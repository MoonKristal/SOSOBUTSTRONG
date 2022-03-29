package com.sbs.wemasal.sellerordermanage.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.common.template.Pagination;
import com.sbs.wemasal.member.model.vo.Member;
import com.sbs.wemasal.order.model.service.OrderService;
import com.sbs.wemasal.order.model.vo.Order;


@Controller
public class SellerOrderManageController {
	
	@Autowired
	OrderService orderService;
	
	// 판매자의 주문배송 관리 페이지
	@RequestMapping("orderManage.se")
	public String orderListManageForm(@RequestParam(value="cpage", defaultValue="1")int currentPage,										
										String alertMsg,
										Model model,	
										HttpSession session) {
		int userNo = ((Member)session.getAttribute("loginUser")).getUserNo(); //판매자 식별번호 추출하기
		
		int listCount = orderService.orderManageListCount(userNo); //회원 고유 번호로 회원이 주문한 주문서별 갯수 구하기	
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 3, 15); //페이징바:3, 보드리밋:15  
		
		ArrayList<Order> list = orderService.selectOrderManageList(pi, userNo);//회원번호와 페이징처리 넘기기				
		
		session.setAttribute("alertMsg", alertMsg);
		model.addAttribute("pi", pi); //페이징바
		model.addAttribute("list", list); //주문서 리스트		
		
		return "user/seller/orderManageForm";
	}
	
	// 판매자의 주문배송관리 검색필터
	@RequestMapping("searchManage.se")
	public String searchOrderManage(@RequestParam(value="cpage", defaultValue="1") int currentPage, 										
									String keyword, 
									String year,
									String month,
									String alertMsg,
									String status,
									Model model, 
									HttpSession session) {		
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userNo", String.valueOf(((Member)session.getAttribute("loginUser")).getUserNo())); 
		map.put("keyword", keyword);
		map.put("year", year);
		map.put("month", month);
		map.put("status", status);		
		
		int searchCount = orderService.searchOrderManageCount(map); //회원식별번호와 사용자 검색어 해시맵으로 담아 주문 갯수 구하기				
		
		PageInfo pi = Pagination.getPageInfo(searchCount, currentPage, 3, 15); // 페이징바
		
		ArrayList<Order> list = orderService.searchOrderManageList(pi, map);		
				
		session.setAttribute("alertMsg", alertMsg);
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		model.addAttribute("keyword", keyword);		
		model.addAttribute("year", year);
		model.addAttribute("month", month);	
		model.addAttribute("status", status);
		
		return "user/seller/orderManageForm";
	}	
	
	// 운송장번호 등록 팝업창 페이지
	@RequestMapping("insertDeliveryNoFrom.se")
	public String insertDeliveryNoForm(@RequestParam(value="cpage", defaultValue="1") int currentPage, 										
										String keyword, 
										String year,
										String month,
										String status,
										Model model) {
		
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("keyword", keyword);		
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("status", status);
		
		return "user/seller/insertDeliveryNoForm";
	}
	
	// 판매자 주문상품 상태 변경하기 || 운송장번호 등록하기
	@ResponseBody
	@RequestMapping(value="updateStatus.od", produces="text/html; charset=utf-8")
	public String  updateStatus(Order order) {	
		
		System.out.println(order);
							
		int result = orderService.updateStatus(order);		
		
		if(result > 0) {			
			return "success";			
		}
		return "fail";			
	}	
	
	
	//판매자 마이페이지에서 주문상세보기
	@RequestMapping("orderDetailManage.se")
	public String orderDetailManageForm(String orderNo, Model model, HttpSession session) {
		
		int seller = ((Member)session.getAttribute("loginUser")).getUserNo();
		
		Order order = new Order();
		order.setOrderNo(orderNo); // 주문번호
		order.setSeller(seller); // 판매자 식별번호	
		
		Order detailOrder = orderService.selectOrderManageDtail(order);
		
		model.addAttribute("order", detailOrder);
		
		return "user/seller/orderDetailManageForm";
	}
	
	
	
}
