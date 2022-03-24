package com.sbs.wemasal.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.sbs.wemasal.member.model.vo.Member;
import com.sbs.wemasal.member.model.vo.Seller;

@Repository
public class MemberDao {

	public Member loginMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.loginMember", m);
	}
	
	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.insert("memberMapper.insertMember", m);
	}
	
	public int idCheck(SqlSessionTemplate sqlSession, String checkId) {
		return sqlSession.selectOne("memberMapper.idCheck", checkId);
	}
	
	@Transactional
	public int insertSeller (SqlSessionTemplate sqlSession, Member m, Seller s) {
		int result = sqlSession.insert("memberMapper.insertSeller1", m);
		
		if (result > 0) {
		return sqlSession.insert("memberMapper.insertSeller2", s);
		}
		
		return result;
	}
	
	public int sellerNameCheck(SqlSessionTemplate sqlSession, String checkName) {
		return sqlSession.selectOne("memberMapper.checkName", checkName);
	}

	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.updateMember", m);
	}
	
	public int deleteMember(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.update("memberMapper.deleteMember", userId);
	}
	
	
	
	
	
	
}
