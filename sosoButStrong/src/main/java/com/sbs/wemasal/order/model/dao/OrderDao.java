package com.sbs.wemasal.order.model.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.sbs.wemasal.cart.model.vo.Cart;

@Repository
public class OrderDao {

	public ArrayList<Cart> selectCart(SqlSessionTemplate sqlSession, int userNo) {
		return (ArrayList)sqlSession.selectList("orderMapper.selectCart", userNo);
	}

	
	public int insertOrder(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.insert("orderMapper.insertOrder", map);
	}
	

}
