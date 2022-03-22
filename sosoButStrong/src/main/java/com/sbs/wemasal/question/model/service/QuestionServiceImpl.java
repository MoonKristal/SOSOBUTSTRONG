package com.sbs.wemasal.question.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.order.model.vo.Order;
import com.sbs.wemasal.question.model.dao.QuestionDao;
import com.sbs.wemasal.question.model.vo.Question;

@Service
public class QuestionServiceImpl implements QuestionService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private QuestionDao questionDao;

	// 2022.3.22(화) 16h
	@Override
	public int selectBuyerOrderListCount(int userNo) {
		return questionDao.selectBuyerOrderListCount(sqlSession, userNo);
	}

	// 2022.3.22(화) 18h55
	@Override
	public ArrayList<Order> selectBuyerOrderList(PageInfo pi, int userNo) {
		return questionDao.selectBuyerOrderList(sqlSession, pi, userNo);
	}

	// 2022.3.23(수) 1h50
	@Override
	public int countOrderNo(Question q) {
		return questionDao.countOrderNo(sqlSession, q);
	}

}
