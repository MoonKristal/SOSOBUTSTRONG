package com.sbs.wemasal.order.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.wemasal.cart.model.vo.Cart;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.common.template.Pagination;
import com.sbs.wemasal.member.model.vo.Member;
import com.sbs.wemasal.order.model.service.OrderService;
import com.sbs.wemasal.order.model.vo.Order;

import net.sf.json.JSONArray;

@Controller
public class OrderController {
	
	@Autowired
	private OrderService orderService;

	// 주문페이지
	@RequestMapping("orderForm.od")
	public String OrderForm(HttpSession session, Model model) {		
		
		int userNo = ((Member)session.getAttribute("loginUser")).getUserNo(); // 로그인한 구매자의 고유식별번호 추출
		
		ArrayList<Cart> list = orderService.selectCart(userNo); //회원 고유식별번호
		
		model.addAttribute("list", list);
		
		return "user/order/orderForm";
	}
	
	// 주소검색창 페이지
	@RequestMapping("address.od")
	public String addressForm() {
		return "user/order/addressForm";
	}
	
	
	// 주문하기 컨트롤러
		@ResponseBody
		@RequestMapping(value="insertOrder.od", produces="text/html; charset=utf-8")
		public String AjaxinsertOrder(@RequestParam String data) throws IOException {			
					
			List<Map<String, Object>> orderList = JSONArray.fromObject(data); //자바스크립트 객체를 자바 List로 객체화시키기
			
			int usePoint = Integer.valueOf((String) orderList.get(0).get("usePoint")); //로그인유저의 사용포인트 꺼내기
			int userNo = Integer.valueOf((String)orderList.get(0).get("orderer")); // 구매자의 식별번호
			String orderNo = Long.toString((Long) orderList.get(0).get("orderNo"));	// 결제 고유 주문번호(나중에 환불도 이 고유번호로 해야함)		
			
			Member m = new Member();
			m.setUserNo(userNo);
			m.setPoint(usePoint);
			
			if(usePoint > 0) { //만약 사용포인트 0이상이라면 사용자 포인트 사업데이트
				orderService.updatePoint(m); 
			}			
			
			//주문번호 추가 
			int result = orderService.insertOrderNo(orderNo);
			
			//주문번호 추가에 성공했다면
			if(result > 0) {
				orderService.deleteCart(userNo); //사용자 카트 비우기(사용자고유넘버필요)
				
				for(Map<String, Object> map: orderList) { // 가지고온 주문서만큼 for문 돌려서 insert 해주기
					orderService.insertOrder(map); //주문서 추가하기
				}
				
				return "success"; //주문서추가 성공메세지
			}
			
			return "fail"; // 주문 실패			
			
		}	
	
	
	// 결제 성공 컨트롤러
	@RequestMapping("paySuccess.od")
	public String paySuccess(@RequestParam(value="totalPay") int totalPay, 
								@RequestParam(value="price") int price,
								@RequestParam(value="point") int point,
								@RequestParam(value="name") String name,	
								@RequestParam(value="address") String address,	
								@RequestParam(value="message") String message,	
								HttpSession session,
								Model model) {			
		
		int userNo = ((Member)session.getAttribute("loginUser")).getUserNo(); // 로그인한 구매자의 고유식별번호 추출
		String orderNo = orderService.selectOrderNo(userNo); //회원번호로 방금 주문한 주분번호 불러오기
		
		model.addAttribute("orderNo", orderNo);
		model.addAttribute("totalPay", totalPay); // 총결제 금액	
		model.addAttribute("price", price);
		model.addAttribute("point", point);
		model.addAttribute("name", name);
		model.addAttribute("address", address);
		model.addAttribute("message", message);			
		
		return "user/order/paySuccessForm";
	}
	
		
	// 주문/배송 목록 페이지
	@RequestMapping("orderList.od")
	public String orderList(@RequestParam(value="cpage", defaultValue="1") int currentPage, HttpSession session, Model model, String alertMsg) {
		
		int userNo = ((Member)session.getAttribute("loginUser")).getUserNo(); //회원 고유번호
		
		int listCount = orderService.selectOrderListCount(userNo); //회원 고유 번호로 회원이 주문한 주문서별 갯수 구하기	
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 3); //페이징바:5, 보드리밋:3
		
		ArrayList<Order> list = orderService.selectOrderList(pi, userNo);//회원번호와 페이징처림 넘기기		
		
		model.addAttribute("pi", pi); //페이징바
		model.addAttribute("list", list); //주문서 리스트		
		model.addAttribute("alertMsg", alertMsg); //결제취소시 전달될 메세지
		
		return "user/order/orderListForm";
	}
	
	
	// 주문 상세 페이지
	@RequestMapping("orderDetail.od")
	public String orderDetail(String orderNo, String alertMsg, Model model) {
		
		ArrayList<Order> list = orderService.selectOrderDetail(orderNo); //주문번호
		
		model.addAttribute("list", list);
		model.addAttribute("alertMsg", alertMsg);
		
		return "user/order/orderDetailForm";
	}
	
	
	// 주문취소창 페이지
	@RequestMapping("orderCancelForm.od")
	public String orderCancelForm(String orderNo, Model model, HttpSession session) {		
			
		String userNo = String.valueOf(((Member)session.getAttribute("loginUser")).getUserNo()); //회원 고유번호
		Order order = new Order();
		order.setOrderer(userNo);
		order.setOrderNo(orderNo);
		
		Order o = orderService.selectOrderCancel(order); //주문번호와 회원식별번호로 조회
			
		model.addAttribute("order", o);
		return "user/order/orderCancelForm";
	}
	
	
	// 주문 취소하기
	@ResponseBody
	@RequestMapping(value="orderCancel.od", produces="text/html; charshet=utf-8")
	public String orderCancel(Order order, HttpSession session) {
		
		int result = orderService.orderCancel(order);
		
		if(result > 0) { // 결제취소로 상태가 바뀌었다면
			
			if(order.getUsePoint() > 0) { //사용포인트가 0이상이었다면
				String userNo = String.valueOf(((Member)session.getAttribute("loginUser")).getUserNo());
				order.setOrderer(userNo);
				orderService.cancelUserPoint(order);	//환불시 구매자 사용포인트 다시 반환		
			}
			 
			return "success";
		}		
		return "fail";		
	}
	
	
	// 주문목록에서 주문필터검색하기
	@RequestMapping("search.od")
	public String searchOrder(@RequestParam(value="cpage", defaultValue="1") int currentPage, 										
										String keyword, 
										String year,
										String month,
										Model model, 
										HttpSession session) {
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userNo", String.valueOf(((Member)session.getAttribute("loginUser")).getUserNo())); 
		map.put("keyword", keyword);
		map.put("year", year);
		map.put("month", month);
		
		int searchCount = orderService.selectSearchCount(map); //회원식별번호와 사용자 검색어 해시맵으로 담아 주문 갯수 구하기				
		
		PageInfo pi = Pagination.getPageInfo(searchCount, currentPage, 5, 3); // 페이징바
		
		ArrayList<Order> list = orderService.selectSearchList(map, pi);	
				
		model.addAttribute("keyword", keyword); //검색 키워드
		model.addAttribute("year", year); // 조회한 연도수
		model.addAttribute("month", month); // 조회한 6개월 기간
		model.addAttribute("list", list); //조회한 주문리스트
		model.addAttribute("pi", pi); //페이징처리바		
		
		return "user/order/orderListForm";
	}
	
	
	
	
	
}
