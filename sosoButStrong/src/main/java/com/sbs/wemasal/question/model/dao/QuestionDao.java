package com.sbs.wemasal.question.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.order.model.vo.Order;
import com.sbs.wemasal.question.model.vo.Question;

@Repository
public class QuestionDao {

	// 2022.3.22(화) 16h5
	public int selectBuyerOrderListCount(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("questionMapper.selectBuyerOrderListCount", userNo);
	}
	
	// 2022.3.22(화) 18h55
	public ArrayList<Order> selectBuyerOrderList(SqlSessionTemplate sqlSession, PageInfo pi, int userNo) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("questionMapper.selectBuyerOrderList", userNo, rowBounds);
	}

	// 2022.3.23(수) 1h55
	public int countOrderNo(SqlSessionTemplate sqlSession, Question q) {
		return sqlSession.selectOne("questionMapper.countOrderNo", q);
	}

}
