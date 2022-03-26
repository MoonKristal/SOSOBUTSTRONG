package com.sbs.wemasal.seller.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.wemasal.seller.model.dao.SettlementDao;

// 2022.3.25(금) 15h15
@Service
public class SettlementServiceImpl implements SettlementService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private SettlementDao settlementDao;

}
