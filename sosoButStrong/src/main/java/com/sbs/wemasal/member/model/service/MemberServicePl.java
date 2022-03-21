package com.sbs.wemasal.member.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.wemasal.member.model.dao.MemberDao;
import com.sbs.wemasal.member.model.vo.Member;
import com.sbs.wemasal.member.model.vo.Seller;

@Service
public class MemberServicePl implements MemberService {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public Member loginMember(Member m) {
		return memberDao.loginMember(sqlSession, m);
	}
	
	@Override
	public int insertMember(Member m) {
		return memberDao.insertMember(sqlSession, m);
	}
	
	@Override
	public int idCheck(String checkId) {
		return memberDao.idCheck(sqlSession, checkId);
	}
	
	
	
	
	
	
	@Override
	public int insertSeller(Member m, Seller s) {
		return memberDao.insertSeller(sqlSession, m, s);
	}

	@Override
	public int sellerNameCheck(String checkName) {
		return memberDao.sellerNameCheck(sqlSession, checkName);
	}
}
