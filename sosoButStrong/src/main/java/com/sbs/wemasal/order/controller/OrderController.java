package com.sbs.wemasal.order.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sbs.wemasal.cart.model.vo.Cart;
import com.sbs.wemasal.order.model.service.OrderService;

import net.sf.json.JSONArray;

@Controller
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	// 주문페이지
	@RequestMapping("orderForm.od")
	public String OrderForm(HttpSession session, Model model) {		
		//int userNo = ((Member)session.getAttribute("loginUser")).getUserNo();// 회원정보 받아왔다 치고
		
		ArrayList<Cart> list = orderService.selectCart(2); //회원 고유식별번호
				
		model.addAttribute("list", list);
		
		return "user/order/orderForm";
	}
	
	// 주소검색 페이지
	@RequestMapping("address")
	public String addressForm() {
		return "user/order/addressForm";
	}
	
	
	// 주문하기 컨트롤러
		@ResponseBody
		@RequestMapping(value="insertOrder.od", produces="text/html; charset=utf-8")
		public String AjaxinsertOrder(@RequestParam String data) throws IOException {		
					
			List<Map<String, Object>> orderList = JSONArray.fromObject(data); //자바스크립트 객체를 자바 List로 객체화시키기
			
			int usePoint = Integer.valueOf(((String) orderList.get(0).get("usePoint"))); //로그인유저의 사용포인트 꺼내기
					
			if(usePoint > 0) { //만약 사용포인트 0이상이라면 사용자 포인트 사업데이트
				//orderService.updatePoint(usePoint); 
			}
			
			//orderService.deleteCart(); //사용자 카트 비우기
			
			for(Map<String, Object> map: orderList) { // 가지고온 주문서만큼 for문 돌려서 insert 해주기
				orderService.insertOrder(map); //주문서 추가하기
			}
			
			return "success"; //주문서추가 성공메세지
			
		}	
	
	
	// 결제 성공 컨트롤러
	@RequestMapping("paySuccess.od")
	public String paySuccess(@RequestParam(value="totalPay") int totalPay, /*
								@RequestParam(value="price") int price,
								@RequestParam(value="point") int point,
								@RequestParam(value="name") String name,	
								@RequestParam(value="address") String address,	
								@RequestParam(value="message") String message,	*/								
								Model model) {			
		
		model.addAttribute("totalPay", totalPay); // 총결제 금액
		/*
		model.addAttribute("price", 9900);
		model.addAttribute("point", 5000);
		model.addAttribute("name", "안쪼롱");
		model.addAttribute("address", "경기도 남양주시 와부읍 덕소로 118-27, 102동 2009호");
		model.addAttribute("message", "부재시 현관문 앞에 두고 가주세요.");
		*/
		return "user/order/paySuccessForm";
	}
	
	// 결제 실패 컨트롤러
	@RequestMapping("payFail.od")
	public ModelAndView payFail(ModelAndView mv) {
		
		return mv;
	}
	
	
	
}
