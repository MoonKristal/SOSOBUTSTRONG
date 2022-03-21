package com.sbs.wemasal.order.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.wemasal.cart.model.vo.Cart;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.order.model.dao.OrderDao;
import com.sbs.wemasal.order.model.vo.Order;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDao orderDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;// 기존의 mybatis의 sqlSession
	
	@Override
	public ArrayList<Cart> selectCart(int userNo) {
		return orderDao.selectCart(sqlSession, userNo);
	}	

	@Override
	public int insertOrderNo(String orderNo) {
		return orderDao.insertOrderNo(sqlSession, orderNo);
	}
	
	@Override
	public int insertOrder(Map<String, Object> map) {
		return orderDao.insertOrder(sqlSession, map);
	}

	@Override
	public int deleteCart(int userNo) {
		return orderDao.deleteCart(sqlSession, userNo);
	}

	@Override
	public String selectOrderNo(int userNo) {
		return orderDao.selectOrderNo(sqlSession, userNo);
	}

	// 특정 주문번호의 주문내역 조회
	@Override
	public ArrayList<Order> selectOrderDetail(String orderNo) {
		return orderDao.selectOrderDetail(sqlSession, orderNo);
	}

	// 회원의 주문목록 전부다 조회
	@Override
	public ArrayList<Order> selectOrderList(PageInfo pi, int userNo) {
		return orderDao.selectOrderList(sqlSession, pi, userNo);
	}

	// 회원이 주문한 모든 주문서 갯수 조회
	@Override
	public int selectOrderListCount(int userNo) {
		return orderDao.selectOrderListCount(sqlSession, userNo);
	}

	// 결제취소하는 주문서 불러들여오기
	@Override
	public Order selectOrderCancel(String orderNo) {
		return orderDao.selectOrderCancel(sqlSession, orderNo);
	}

	// 주문 취소하기
	@Override
	public int orderCancel(Order order) {
		return orderDao.orderCancel(sqlSession, order);
	}

	// 주문목록 주문필터로 조회된 행의 갯수
	@Override
	public int selectSearchCount(HashMap<String, String> map) {
		return orderDao.selectSearchCount(sqlSession, map);
	}

	// 주문목록에서 주문필터로 검색하기
	@Override
	public ArrayList<Order> selectSearchList(HashMap<String, String> map, PageInfo pi) {
		return orderDao.selectSearchList(sqlSession, map, pi);
	}





	
	

}
