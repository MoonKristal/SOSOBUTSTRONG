package com.sbs.wemasal.question.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.member.model.vo.Seller;
import com.sbs.wemasal.order.model.vo.Order;
import com.sbs.wemasal.question.model.vo.Answer;
import com.sbs.wemasal.question.model.vo.Question;

@Repository
public class QuestionDao {
	
	// 2022.3.24(목) myBatis에 페이징 처리 정보 넘기기 위한 공통 메소드
	public RowBounds createRowBounds(PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		return new RowBounds(offset, limit);
	}

	// 2022.3.22(화) 16h5
	public int selectBuyerOrderListCount(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("questionMapper.selectBuyerOrderListCount", userNo);
	}
	
	// 2022.3.22(화) 18h55
	public ArrayList<Order> selectBuyerOrderList(SqlSessionTemplate sqlSession, PageInfo pi, int userNo) {
		return (ArrayList)sqlSession.selectList("questionMapper.selectBuyerOrderList", userNo, createRowBounds(pi));
	}

	// 2022.3.23(수) 1h55
	public int countOrderNo(SqlSessionTemplate sqlSession, Question q) {
		return sqlSession.selectOne("questionMapper.countOrderNo", q);
	}

	// 2022.3.23(수) 3h45
	public ArrayList<Seller> searchSeller(SqlSessionTemplate sqlSession, String sellerKeyword) {
		return (ArrayList)sqlSession.selectList("questionMapper.searchSeller", sellerKeyword);
	}

	// 2022.3.23(수) 18h35
	public int insertBuyerQuestion(SqlSessionTemplate sqlSession, Question q) {
		return sqlSession.insert("questionMapper.insertBuyerQuestion", q);
	}

	// 2022.3.24(목) 13h50
	public int insertQuestionAttachment(SqlSessionTemplate sqlSession, Attachment at) {
		return sqlSession.insert("questionMapper.insertQuestionAttachment", at);
	}

	// 2022.3.24(목) 15h10
	public int selectBuyerQuestionListCount(SqlSessionTemplate sqlSession, int buyerNo) {
		return sqlSession.selectOne("questionMapper.selectBuyerQuestionListCount", buyerNo);
	}

	// 2022.3.24(목) 15h25
	public ArrayList<Question> selectBuyerQuestionList(SqlSessionTemplate sqlSession, PageInfo pi, int buyerNo) {
		return (ArrayList)sqlSession.selectList("questionMapper.selectBuyerQuestionList", buyerNo, createRowBounds(pi));
	}

	// 2022.3.25(금) 1h5
	public Question selectBuyerQuestion(SqlSessionTemplate sqlSession, int qno) {
		return sqlSession.selectOne("questionMapper.selectBuyerQuestion", qno);
	}

	// 2022.3.25(금) 1h35 -> 13h40 기능 구현
	public Answer selectAnswer(SqlSessionTemplate sqlSession, int qno) {
		return sqlSession.selectOne("questionMapper.selectAnswer", qno);
	}

	// 2022.3.25(금) 3h40
	public int selectBuyerQuestionSearchListCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("questionMapper.selectBuyerQuestionSearchListCount", map);
	}

	// 2022.3.25(금) 4h40
	public ArrayList<Question> selectBuyerQuestionSearchList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String> map) {
		return (ArrayList)sqlSession.selectList("questionMapper.selectBuyerQuestionSearchList", map, createRowBounds(pi));
	}

	// 2022.3.25(금) 9h30
	public int selectSellerQuestionListCount(SqlSessionTemplate sqlSession, int sellerNo) {
		return sqlSession.selectOne("questionMapper.selectSellerQuestionListCount", sellerNo);
	}

	public ArrayList<Question> selectSellerQuestionList(SqlSessionTemplate sqlSession, PageInfo pi, int sellerNo) {
		return (ArrayList)sqlSession.selectList("questionMapper.selectSellerQuestionList", sellerNo, createRowBounds(pi));
	}

	// 2022.3.25(금) 10h25
	public Question selectSellerQuestion(SqlSessionTemplate sqlSession, int qno) {
		return sqlSession.selectOne("questionMapper.selectSellerQuestion", qno);
	}

	// 2022.3.25(금) 12h15
	public int insertSellerAnswer(SqlSessionTemplate sqlSession, Answer a) {
		return sqlSession.insert("questionMapper.insertSellerAnswer", a);
	}

	// 2022.3.25(금) 12h20
	public int insertAnswerAttachment(SqlSessionTemplate sqlSession, Attachment at) {
		return sqlSession.insert("questionMapper.insertAnswerAttachment", at);
	}

	// 2022.3.25(금) 12h55
	public int updateAnswer(SqlSessionTemplate sqlSession, int qno) {
		return sqlSession.update("questionMapper.updateAnswer", qno);
	}
	
	// 2022.3.25(금) 14h50
	public int updateScore(SqlSessionTemplate sqlSession, Answer a) {
		return sqlSession.update("questionMapper.updateScore", a);
	}

}
