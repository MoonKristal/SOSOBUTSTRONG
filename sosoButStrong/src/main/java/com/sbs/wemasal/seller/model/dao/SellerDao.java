package com.sbs.wemasal.seller.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.sbs.wemasal.member.model.vo.Member;
import com.sbs.wemasal.seller.model.vo.Seller;

@Repository
public class SellerDao {

	@Transactional
	public int insertSeller (SqlSessionTemplate sqlSession, Member m, Seller s) {
		int result = sqlSession.insert("sellerMapper.insertSeller1", m);
		
		if (result > 0) {
		return sqlSession.insert("sellerMapper.insertSeller2", s);
		}
		
		return result;
	}
	
	
	public int sellerNameCheck(SqlSessionTemplate sqlSession, String checkName) {
		return sqlSession.selectOne("sellerMapper.checkName", checkName);
	}

}
