package com.sbs.wemasal.order.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.sbs.wemasal.cart.model.vo.Cart;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.member.model.vo.Member;
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

	public Order selectOrderCancel(SqlSessionTemplate sqlSession, Order order) {
		return sqlSession.selectOne("orderMapper.selectOrderCancel", order);
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

	public int orderManageListCount(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("orderMapper.orderManageListCount", userNo);
	}

	public ArrayList<Order> orderManageList(SqlSessionTemplate sqlSession, PageInfo pi, int userNo) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("orderMapper.orderManageList", userNo, rowBounds);
	}

	public int searchOrderManageCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {		
		return sqlSession.selectOne("orderMapper.searchOrderManageCount", map);
	}
	
	public ArrayList<Order> searchOrderManageList(SqlSessionTemplate sqlSession, PageInfo pi,
			HashMap<String, String> map) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit; 
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("orderMapper.searchOrderManageList", map, rowBounds);
	}

	public int updateStatus(SqlSessionTemplate sqlSession, Order order) {
		return sqlSession.update("orderMapper.updateStatus", order);
	}

	public Order selectOrderManageDtail(SqlSessionTemplate sqlSession, Order order) {
		return sqlSession.selectOne("orderMapper.selectOrderManageDtail", order);
	}

	public int updatePoint(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("orderMapper.updatePoint", m);
	}

	public int cancelUserPoint(SqlSessionTemplate sqlSession, Order order) {
		return sqlSession.update("orderMapper.cancelUserPoint", order);
	}
	

}
