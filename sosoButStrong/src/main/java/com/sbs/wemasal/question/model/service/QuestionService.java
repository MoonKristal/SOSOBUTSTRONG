package com.sbs.wemasal.question.model.service;

import java.util.ArrayList;

import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.order.model.vo.Order;
import com.sbs.wemasal.question.model.vo.Question;

public interface QuestionService {
	
	// 구매자가 1:1문의 내역/list 조회 + paging 처리
	
	// 2022.3.22(화) 15h35
	int selectBuyerOrderListCount(int userNo);

	// 2022.3.22(화) 18h55
	ArrayList<Order> selectBuyerOrderList(PageInfo pi, int userNo);

	// 2022.3.23(수) 1h40
//	int countOrderNo(String orderNo, int seller);
	int countOrderNo(Question q);
	
	
}
