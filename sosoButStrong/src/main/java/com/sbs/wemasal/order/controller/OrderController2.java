package com.sbs.wemasal.order.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.wemasal.member.model.service.MemberService;
import com.sbs.wemasal.member.model.vo.Member;
import com.sbs.wemasal.order.model.service.OrderService;

import net.sf.json.JSONArray;

// 2022.3.31(목) 17h40 소영님 수정_주문하기 controller 보다 더 효율적으로 고치심
@Controller
public class OrderController2 {
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	MemberService memberService;

	// 주문하기 컨트롤러
	@ResponseBody
	@RequestMapping(value = "insertOrder2.od", produces = "text/html; charset=utf-8")
	public String AjaxinsertOrder(@RequestParam String data, HttpSession session) throws IOException {

		List<Map<String, Object>> orderList = JSONArray.fromObject(data); // 자바스크립트 객체를 자바 List로 객체화시키기

		int usePoint = Integer.valueOf((String) orderList.get(0).get("usePoint")); // 로그인유저의 사용포인트 꺼내기
		int userNo = Integer.valueOf((String) orderList.get(0).get("orderer")); // 구매자의 식별번호
		String orderNo = Long.toString((Long) orderList.get(0).get("orderNo")); // 결제 고유 주문번호(나중에 환불도 이 고유번호로 해야함)

		Member m = new Member();
		m.setUserNo(userNo); // 사용자번호 setter
		m.setPoint(usePoint); // 사용적립금 setter

		// 주문번호 추가
		int result = orderService.insertOrderNo(orderNo);

		int result2 = 0; // 사용자 주문 INSERT 성공여부결과
		// 주문번호 추가에 성공했다면
		if (result > 0) {

			for (Map<String, Object> map : orderList) { // 가지고온 주문서만큼 for문 돌려서 insert 해주기
				result2 = orderService.insertOrder(map); // 주문서 추가하기
			}

			if (result2 > 0) { // 만약 주문을 성공했다면
				orderService.deleteCart(userNo); // 사용자 카트 비우기(사용자고유넘버필요)

				if (usePoint > 0) { // 만약 사용포인트 0이상이라면 사용자 적립금 업데이트
					orderService.updatePoint(m);
					String userId = ((Member) session.getAttribute("loginUser")).getUserId(); // 다시 재로그인을 위해 아이디 추출
					session.removeAttribute("loginUser"); // 포인트에 변동이 생겼기때문에 새로 DB에 저장된 적립금을 불러와야해서 지움
					Member m1 = new Member();// 객체 생성
					m1.setUserId(userId);
					Member loginUser = memberService.loginMember(m1); // 다시 재로그인해서 업데이트된 적립금 정보받아옴
					session.setAttribute("loginUser", loginUser); // 다시 세션에 로그인한 회원정보 setting
				}
				return "success"; // 주문서추가 성공메세지
			}

		}

		return "fail"; // 주문 실패

	}

}
