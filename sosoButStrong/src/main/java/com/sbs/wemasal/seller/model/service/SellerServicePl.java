package com.sbs.wemasal.seller.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.wemasal.member.model.vo.Member;
import com.sbs.wemasal.seller.model.dao.SellerDao;
import com.sbs.wemasal.seller.model.vo.Seller;

@Service
public class SellerServicePl implements SellerService {

	@Autowired
	private SellerDao sellerDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertSeller(Member m, Seller s) {
		return sellerDao.insertSeller(sqlSession, m, s);
	}

	@Override
	public int sellerNameCheck(String checkName) {
		return sellerDao.sellerNameCheck(sqlSession, checkName);
	}

}
