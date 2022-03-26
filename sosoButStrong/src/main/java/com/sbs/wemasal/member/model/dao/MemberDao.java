package com.sbs.wemasal.member.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.member.model.vo.Cert;
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
	
	// 아이디 찾기
	public String findId(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.findId", m);
	}
	
	//public List<Seller> sellerListNY(SqlSessionTemplate sqlSession) {
	//	return sqlSession.selectList("memberMapper.sellerList");
	//}
		
	public int selectListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("memberMapper.selectListCount");
	}
	
	public ArrayList<Seller> selectList(SqlSessionTemplate sqlSession, PageInfo pi){
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectList", null, rowBounds);
	}	
	
	//이메일 인증 --------------------------
	public int valiCheck(SqlSessionTemplate sqlSession, Cert cert) {
	      
	      int result = sqlSession.selectOne("memberMapper.emailValidate", cert);
	      
	      if(result>0) {
	         sqlSession.delete("memberMapper.emailValidateRemove", cert);
	      }
	      return result;
	}

	public int emailDuplicationCheck(SqlSessionTemplate sqlSession, String emailDupl) {
	      
	      return sqlSession.selectOne("memberMapper.emailDuplicationCheck", emailDupl);
	}
	
	public void insertVeriCode(SqlSessionTemplate sqlSession, Cert cert) {
	      sqlSession.insert("memberMapper.regist", cert);
	   }
	
	public int idDuplicationCheck(SqlSessionTemplate sqlSession, String id) {
	      return sqlSession.selectOne("memberMapper.idDuplicationCheck", id);
	   }


	
}
