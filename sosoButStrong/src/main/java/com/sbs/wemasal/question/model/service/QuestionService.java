package com.sbs.wemasal.question.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.google.gson.JsonElement;
import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.member.model.vo.Seller;
import com.sbs.wemasal.order.model.vo.Order;
import com.sbs.wemasal.question.model.vo.Answer;
import com.sbs.wemasal.question.model.vo.Question;

public interface QuestionService {
	
	// 구매자의 1:1문의 글 작성 양식 관련
	// 2022.3.22(화) 15h35
	int selectBuyerOrderListCount(int userNo);

	// 2022.3.22(화) 18h55
	ArrayList<Order> selectBuyerOrderList(PageInfo pi, int userNo);

	// 2022.3.23(수) 1h40
//	int countOrderNo(String orderNo, int seller);
	int countOrderNo(Question q);

	// 2022.3.23(수) 3h40
//	JsonElement searchSeller(String sellerKeyword); // controller에서 자동 완성시켜서 만든 메소드
	ArrayList<Seller> searchSellerName(String sellerKeyword);

	// 구매자가 1:1문의 글 작성 관련
	// 2022.3.23(수) 18h35
	int insertBuyerQuestion(Question q);

	// 2022.3.24(목) 13h50
	int insertQuestionAttachment(Attachment at);
	
	// 구매자가 1:1문의 내역/list 조회 + paging 처리
	// 2022.3.24(목) 15h
	int selectBuyerQuestionListCount(int buyerNo);
	// 2022.3.24(목) 15h25
	ArrayList<Question> selectBuyerQuestionList(PageInfo pi, int buyerNo);

	// 2022.3.25(금) 1h
	Question selectBuyerQuestion(int qno);
	
	// 2022.3.25(금) 1h35 -> 13h40 기능 구현
	Answer selectAnswer(int qno);

	// 2022.3.25(금) 3h40
	int selectBuyerQuestionSearchListCount(HashMap<String, String> map);

	// 2022.3.25(금) 4h40
	ArrayList<Question> selectBuyerQuestionSearchList(PageInfo pi, HashMap<String, String> map);

	// 2022.3.25(금) 9h30
	int selectSellerQuestionListCount(int sellerNo);
	ArrayList<Question> selectSellerQuestionList(PageInfo pi, int sellerNo);

	// 2022.3.25(금) 10h20
	Question selectSellerQuestion(int qno);

	// 2022.3.25(금) 12h15
	int insertSellerAnswer(Answer a);

	// 2022.3.25(금) 12h20
	int insertAnswerAttachment(Attachment at);

	// 2022.3.25(금) 12h55
	int updateAnswer(int qno);
	
	// 2022.3.25(금) 14h50
	int updateScore(Answer a);
	
}
