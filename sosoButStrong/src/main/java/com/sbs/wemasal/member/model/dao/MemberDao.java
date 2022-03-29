package com.sbs.wemasal.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.member.model.vo.Cert;
import com.sbs.wemasal.member.model.vo.Member;
import com.sbs.wemasal.member.model.vo.Seller;
import com.sbs.wemasal.member.model.vo.admin;

@Repository
public class MemberDao {

	// 로그인
	public Member loginMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.loginMember", m);
	}
	
	// 일반회원 회원가입
	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("memberMapper.insertMember", m);
	}
	
	// 아이디 중복체크
	public int idCheck(SqlSessionTemplate sqlSession, String checkId) {
		return sqlSession.selectOne("memberMapper.idCheck", checkId);
	}
	
	// 판매자 회원가입
	@Transactional
	public int insertSeller (SqlSessionTemplate sqlSession, Member m, Seller s) {
		int result = sqlSession.insert("memberMapper.insertSeller1", m);
		
		if (result > 0) {
		return sqlSession.insert("memberMapper.insertSeller2", s);
		}
		
		return result;
	}
	
	// 판매자 상호 중복체크
	public int sellerNameCheck(SqlSessionTemplate sqlSession, String sellerName) {
		return sqlSession.selectOne("memberMapper.checkName", sellerName);
	}

	// 일반회원 정보수정
	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.updateMember", m);
	}
	
	// 일반회원 탈퇴
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
	
	// 관리자 판매자 승인거절 리스트
	// 게시판 리스트 조회 서비스 + 페이징 처리
	// 게시글 총 갯수 조회
	public int selectListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("memberMapper.selectListCount");
	}
	
	// 관리자 판매자 승인거절 리스트 정보 조회
	public ArrayList<Seller> selectList(SqlSessionTemplate sqlSession, PageInfo pi){
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectList", null, rowBounds);
	}	
	
	// 관리자 판매자 승인거절 상세페이지
	public Seller selectSeller(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("memberMapper.selectSeller", userNo);
	}
	
	// 관리자 판매자 승인/거절 상세페이지 판매자 이름 가져오기
	public String sellerUserName(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("memberMapper.sellerUserName", userNo);
	}

	// 관리자 판매자 승인 버튼
	public int approveSeller(SqlSessionTemplate sqlSession, String userNo) {
		return sqlSession.update("memberMapper.approveSeller", userNo);
		}
	
	// 관리자 판매자 거절 버튼
	public int refuseSeller(SqlSessionTemplate sqlSession, String userNo) {
		return sqlSession.update("memberMapper.refuseSeller", userNo);
	}
	
	// 관리자 판매자관리 리스트 조회
	public ArrayList<admin> memberSellerList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("memberMapper.memberSellerList", null, rowBounds);
	}

	// 관리자 판매자 상세조회
	public admin adminSelectSeller(SqlSessionTemplate sqlSession, int userNo) {
		 return sqlSession.selectOne("memberMapper.adminSelectSeller", userNo);
	}

	// 관리자 판매자 탈퇴시키기
	public int memberDelete(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.update("memberMapper.adminMemberDelete", userId);
	}
	
	// 관리자 일반회원 리스트 조회
	public ArrayList<Member> memberBuyerList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("memberMapper.memberBuyerList", null, rowBounds);
	}
	
	// 관리자 일반회원 관리 상세조회
	public Member adminSelectBuyer(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("memberMapper.adminSelectBuyer", userNo);
	}
	
	// 관리자 일반회원 탈퇴시키기
	public int adminDeleteBuyer(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.update("memberMapper.adminDeleteBuyer", userId);
	}


	
	//이메일 인증 수정1-------------------------------------------------------------------------------
//	public int valiCheck(SqlSessionTemplate sqlSession, Cert cert) {
//	      
//	      int result = sqlSession.selectOne("memberMapper.emailValidate", cert);
//	      
//	      if(result>0) {
//	         sqlSession.delete("memberMapper.emailValidateRemove", cert);
//	      }
//	      return result;
//	}
//
//	public int emailDuplicationCheck(SqlSessionTemplate sqlSession, String emailDupl) {
//	      
//	      return sqlSession.selectOne("memberMapper.emailDuplicationCheck", emailDupl);
//	}
//	
//	public void insertVeriCode(SqlSessionTemplate sqlSession, Cert cert) {
//	      sqlSession.insert("memberMapper.regist", cert);
//	   }
//	
//	public int idDuplicationCheck(SqlSessionTemplate sqlSession, String id) {
//		return sqlSession.selectOne("memberMapper.idDuplicationCheck", id);
//	}
	
	
	// 이메일 인증 수정2------------------------------------------------------------------------------
//	public void updatePwd(SqlSessionTemplate sqlSession, String secret, String userId) {
//		HashMap<String, Object> map = new HashMap<String,Object>();
//		map.put("secret",secret);
//		map.put("userId", userId);
//		sqlSession.update("memberMapper.updatePwd",map);
//	}

	// 이메일 인증 수정3------------------------------------------------------------------------------
	// 비밀번호찾기(일치하는 정보 찾기)
	public int searchPwd(SqlSessionTemplate sqlSession,Member m) {
		
		return sqlSession.selectOne("memberMapper.searchPwd",m);
	}
	// 임시비밀번호로 수정하기
	public int updatePwd(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.update("memberMapper.updatePwd",map);
	}

	
	



	






	
}
