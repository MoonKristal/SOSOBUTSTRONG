package com.sbs.wemasal.question.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.member.model.vo.Seller;
import com.sbs.wemasal.order.model.vo.Order;
import com.sbs.wemasal.question.model.dao.QuestionDao;
import com.sbs.wemasal.question.model.vo.Answer;
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

	// 2022.3.23(수) 3h40
	@Override
	public ArrayList<Seller> searchSellerName(String sellerNameKeyword) {
		return questionDao.searchSeller(sqlSession, sellerNameKeyword);
	}

	// 2022.3.23(수) 18h35
	@Override
	public int insertBuyerQuestion(Question q) {
		return questionDao.insertBuyerQuestion(sqlSession, q);
	}

	// 2022.3.24(목) 13h50
	@Override
	public int insertQuestionAttachment(Attachment at) {
		return questionDao.insertQuestionAttachment(sqlSession, at);
	}
	
	// 2022.3.24(목) 15h10
	@Override
	public int selectBuyerQuestionListCount(int buyerNo) {
		return questionDao.selectBuyerQuestionListCount(sqlSession, buyerNo);
	}

	// 2022.3.24(목) 15h25
	@Override
	public ArrayList<Question> selectBuyerQuestionList(PageInfo pi, int buyerNo) {
		return questionDao.selectBuyerQuestionList(sqlSession, pi, buyerNo);
	}

	// 2022.3.25(금) 1h
	@Override
	public Question selectBuyerQuestion(int qno) {
		return questionDao.selectBuyerQuestion(sqlSession, qno);
	}

	// 2022.3.25(금) 1h35 -> 13h40 기능 구현
	@Override
	public Answer selectAnswer(int qno) {
		return questionDao.selectAnswer(sqlSession, qno);
	}

	// 2022.3.25(금) 3h40
	@Override
	public int selectBuyerQuestionSearchListCount(HashMap<String, String> map) {
		return questionDao.selectBuyerQuestionSearchListCount(sqlSession, map);
	}

	// 2022.3.25(금) 4h40
	@Override
	public ArrayList<Question> selectBuyerQuestionSearchList(PageInfo pi, HashMap<String, String> map) {
		return questionDao.selectBuyerQuestionSearchList(sqlSession, pi, map);
	}
	
	// 2022.3.25(금) 9h30
	@Override
	public int selectSellerQuestionListCount(int sellerNo) {
		return questionDao.selectSellerQuestionListCount(sqlSession, sellerNo);
	}

	@Override
	public ArrayList<Question> selectSellerQuestionList(PageInfo pi, int sellerNo) {
		return questionDao.selectSellerQuestionList(sqlSession, pi, sellerNo);
	}

	// 2022.3.25(금) 10h25
	@Override
	public Question selectSellerQuestion(int qno) {
		return questionDao.selectSellerQuestion(sqlSession, qno);
	}

	// 2022.3.25(금) 12h15
	@Override
	public int insertSellerAnswer(Answer a) {
		return questionDao.insertSellerAnswer(sqlSession, a);
	}

	// 2022.3.25(금) 12h15
	@Override
	public int insertAnswerAttachment(Attachment at) {
		return questionDao.insertAnswerAttachment(sqlSession, at);
	}

	// 2022.3.25(금) 12h55
	@Override
	public int updateAnswer(int qno) {
		return questionDao.updateAnswer(sqlSession, qno);
	}
	
	// 2022.3.25(금) 14h50
	@Override
	public int updateScore(Answer a) {
		return questionDao.updateScore(sqlSession, a);
	}

}
