package com.sbs.wemasal.order.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.sbs.wemasal.cart.model.vo.Cart;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.order.model.vo.Order;

public interface OrderService {	

	ArrayList<Cart> selectCart(int userNo);

	int insertOrder(Map<String, Object> map);

	int insertOrderNo(String orderNo);

	// 장바구니 지우기
	int deleteCart(int userNo);
	
	// 주문번호 조회
	String selectOrderNo(int userNo);

	// 특정 주문번호의 주문내역 조회해오기
	ArrayList<Order> selectOrderDetail(String orderNo);

	// 회원의 주문목록 전부다 조회해오기
	ArrayList<Order> selectOrderList(PageInfo pi, int userNo);

	// 회원이 주문한 모든 주문서 갯수 조회
	int selectOrderListCount(int userNo);

	// 취소한 주문목록 조회하기
	Order selectOrderCancel(String orderNo);

	// 주문 결제 취소하기
	int orderCancel(Order order);

	// 주문목록에서 주문필터로 조회된 행의 갯수
	int selectSearchCount(HashMap<String, String> map);

	// 주문목록에서 주문필터로 검색하기
	ArrayList<Order> selectSearchList(HashMap<String, String> map, PageInfo pi);

	

}
