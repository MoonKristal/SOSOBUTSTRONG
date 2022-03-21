package com.sbs.wemasal.order.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.sbs.wemasal.cart.model.vo.Cart;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.order.model.vo.Order;

@Repository
public class OrderDao {

	public ArrayList<Cart> selectCart(SqlSessionTemplate sqlSession, int userNo) {
		return (ArrayList)sqlSession.selectList("orderMapper.selectCart", userNo);
	}

	public int insertOrderNo(SqlSessionTemplate sqlSession, String orderNo) {
		return sqlSession.insert("orderMapper.insertOrderNo", orderNo);
	}
	
	public int insertOrder(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.insert("orderMapper.insertOrder", map);
	}

	public int deleteCart(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.delete("orderMapper.deleteCart", userNo);
	}

	public String selectOrderNo(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("orderMapper.selectOrderNo", userNo);
	}

	public ArrayList<Order> selectOrderDetail(SqlSessionTemplate sqlSession, String orderNo) {
		return (ArrayList)sqlSession.selectList("orderMapper.selectOrderDetail", orderNo);
	}

	public ArrayList<Order> selectOrderList(SqlSessionTemplate sqlSession, PageInfo pi, int userNo) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);		
		
		return (ArrayList)sqlSession.selectList("orderMapper.selectOrderList", userNo, rowBounds);
	}

	public int selectOrderListCount(SqlSessionTemplate sqlSession, int userNo) {		
		return sqlSession.selectOne("orderMapper.selectOrderListCount", userNo);
	}

	public Order selectOrderCancel(SqlSessionTemplate sqlSession, String orderNo) {
		return sqlSession.selectOne("orderMapper.selectOrderCancel", orderNo);
	}

	public int orderCancel(SqlSessionTemplate sqlSession, Order order) {
		return sqlSession.update("orderMapper.orderCancel", order);
	}

	public int selectSearchCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("orderMapper.selectSearchCount", map);
	}

	public ArrayList<Order> selectSearchList(SqlSessionTemplate sqlSession, HashMap<String, String> map,
			PageInfo pi) {
		
		int limit = pi.getBoardLimit(); // 1페이지당 가져올 주문목록 갯수
		int offset = (pi.getCurrentPage() - 1) * limit;
				
		RowBounds rowBounds = new RowBounds(offset, limit);		
		
		return (ArrayList)sqlSession.selectList("orderMapper.selectSearchList", map, rowBounds);
	}


	

}
