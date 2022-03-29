package com.sbs.wemasal.seller.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.common.template.Pagination;
import com.sbs.wemasal.order.model.vo.Order;
import com.sbs.wemasal.seller.model.vo.DailySales;

// 2022.3.25(금) 15h15
@Repository
public class SettlementDao {

	// 2022.3.28(월) 16h
	public DailySales selectSalesOverview(SqlSessionTemplate sqlSession, int sellerNo) {
		return sqlSession.selectOne("settlementMapper.selectSalesOverview", sellerNo);
	}

	// 2022.3.28(월) 21h15
	public DailySales selectSalesGraph(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("settlementMapper.selectSalesGraph", map);
	}

	// 2022.3.29(화) 1h5
	public int selectSettlementDetailListCount(SqlSessionTemplate sqlSession, int sellerNo) {
		return sqlSession.selectOne("settlementMapper.selectSettlementDetailListCount", sellerNo);
	}

	public ArrayList<Order> selectSettlementDetailList(SqlSessionTemplate sqlSession, PageInfo pi, int sellerNo) {
		RowBounds rowBounds = Pagination.createRowBounds(pi);
		return (ArrayList)sqlSession.selectList("settlementMapper.selectSettlementDetailList", sellerNo, rowBounds);
	}
	
	// 2022.3.29(화) 3h 엑셀 다운로드용 메소드 오버로딩 
	public ArrayList<Order> selectSettlementDetailList(SqlSessionTemplate sqlSession, int sellerNo) {
		return (ArrayList)sqlSession.selectList("settlementMapper.selectSettlementDetailList", sellerNo);
	}

	// 2022.3.29(화) 2h25
	public Order selectSettlementSummary(SqlSessionTemplate sqlSession, int sellerNo) {
		return sqlSession.selectOne("settlementMapper.selectSettlementSummary", sellerNo);
	}

	

}
