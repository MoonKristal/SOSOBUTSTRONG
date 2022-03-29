package com.sbs.wemasal.seller.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.order.model.vo.Order;
import com.sbs.wemasal.seller.model.dao.SettlementDao;
import com.sbs.wemasal.seller.model.vo.DailySales;

// 2022.3.25(금) 15h15
@Service
public class SettlementServiceImpl implements SettlementService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private SettlementDao settlementDao;

	// 2022.3.28(월) 16h
	@Override
	public DailySales selectSalesOverview(int sellerNo) {
		return settlementDao.selectSalesOverview(sqlSession, sellerNo);
	}

	// 2022.3.28(월) 21h15
	@Override
	public DailySales selectSalesGraph(HashMap<String, String> map) {
		return settlementDao.selectSalesGraph(sqlSession, map);
	}

	// 2022.3.29(화) 1h
	@Override
	public int selectSettlementDetailListCount(int sellerNo) {
		return settlementDao.selectSettlementDetailListCount(sqlSession, sellerNo);
	}

	@Override
	public ArrayList<Order> selectSettlementDetailList(PageInfo pi, int sellerNo) {
		return settlementDao.selectSettlementDetailList(sqlSession, pi, sellerNo);
	}
	
	// 2022.3.29(화) 3h 엑셀 다운로드용 메소드 오버로딩 
	@Override
	public ArrayList<Order> selectSettlementDetailList(int sellerNo) {
		return settlementDao.selectSettlementDetailList(sqlSession, sellerNo);
	}

	// 2022.3.29(화) 2h25
	@Override
	public Order selectSettlementSummary(int sellerNo) {
		return settlementDao.selectSettlementSummary(sqlSession, sellerNo);
	}

	

}
