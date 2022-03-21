package com.sbs.wemasal.order.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.wemasal.cart.model.vo.Cart;
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
	public int insertOrder(Map<String, Object> map) {
		return orderDao.insertOrder(sqlSession, map);
	}



	
	

}
