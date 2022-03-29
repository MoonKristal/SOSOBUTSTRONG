package com.sbs.wemasal.seller.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.order.model.vo.Order;
import com.sbs.wemasal.seller.model.vo.DailySales;

// 2022.3.25(금) 15h15
public interface SettlementService {

	// 2022.3.28(월) 16h
	DailySales selectSalesOverview(int sellerNo);

	// 2022.3.28(월) 18h25
//	ArrayList<DailySales> selectDailyNewOrders(int sellerNo);

	// 2022.3.28(월) 21h15
	DailySales selectSalesGraph(HashMap<String, String> map);

	// 2022.3.29(화) 1h
	int selectSettlementDetailListCount(int sellerNo);

	ArrayList<Order> selectSettlementDetailList(PageInfo pi, int sellerNo);
	// 2022.3.29(화) 3h 엑셀 다운로드용 메소드 오버로딩 
	ArrayList<Order> selectSettlementDetailList(int sellerNo);

	// 2022.3.29(화) 2h25
	Order selectSettlementSummary(int sellerNo);

	

}
