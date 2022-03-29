package com.sbs.wemasal.member.model.service;


import java.text.DecimalFormat;
import java.text.Format;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.member.model.dao.MemberDao;
import com.sbs.wemasal.member.model.vo.Cert;
import com.sbs.wemasal.member.model.vo.Member;
import com.sbs.wemasal.member.model.vo.Seller;
import com.sbs.wemasal.member.model.vo.admin;

@Service
public class MemberServicePl implements MemberService {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 로그인
	@Override
	public Member loginMember(Member m) {
		return memberDao.loginMember(sqlSession, m);
	}
	
	// 일반회원 회원가입
	@Override
	public int insertMember(Member m) {
		return memberDao.insertMember(sqlSession, m);
	}
	
	// 아이디 중복체크
	@Override
	public int idCheck(String checkId) {
		return memberDao.idCheck(sqlSession, checkId);
	}
	
	// 판매자 회원가입
	@Override
	public int insertSeller(Member m, Seller s) {
		return memberDao.insertSeller(sqlSession, m, s);
	}

	// 판매자 상호 중복체크
	@Override
	public int sellerNameCheck(String sellerName) {
		return memberDao.sellerNameCheck(sqlSession, sellerName);
	}

	// 일반회원 정보수정
	@Override
	public int updateMember(Member m) {
		return memberDao.updateMember(sqlSession, m);
	}
	
	// 일반회원 탈퇴
	@Override
	public int deleteMember(String userId) {
		return memberDao.deleteMember(sqlSession, userId);
	}
	
	// 아이디 찾기
	@Override
	public String findId(Member m) {
		return memberDao.findId(sqlSession, m);
	}

	// 관리자 판매자 승인거절 리스트
	// 게시판 리스트 조회 서비스 + 페이징 처리
	// 게시글 총 갯수 조회
	@Override
	public int selectListCount() {
		return memberDao.selectListCount(sqlSession);
	}

	// 관리자 판매자 승인거절 리스트
	@Override
	public ArrayList<Seller> selectList(PageInfo pi) {
		return memberDao.selectList(sqlSession, pi);
	}
	
	// 관리자 판매자 승인/거절 상세페이지
	@Override
	public Seller selectSeller(int userNo) {
		return memberDao.selectSeller(sqlSession, userNo) ;
	}
	// 관리자 판매자 승인/거절 상세페이지 판매자이름 가져오기
	@Override
	public String sellerUserName(int userNo) {
		
		return memberDao.sellerUserName(sqlSession, userNo);
	}
	// 관리자페이지 판매자 승인버튼
	@Override
	public int approveSeller(String userNo) {
		return memberDao.approveSeller(sqlSession, userNo);
	}
	
	// 관리자페이지 판매자 거절버튼
	@Override
	public int refuseSeller(String userNo) {
		return memberDao.refuseSeller(sqlSession, userNo);
	}
	
	// 관리자 판매자관리 리스트
	@Override
	public ArrayList<admin> memberSellerList(PageInfo pi) {
		return memberDao.memberSellerList(sqlSession, pi);	
	}

	// 관리자 판매자 상세조회
	@Override
	public admin adminSelectSeller(int no) {
		return memberDao.adminSelectSeller(sqlSession, no);
	}

	// 관리자 판매자 탈퇴시키기
	@Override
	public int memberDelete(String userId) {
		return memberDao.memberDelete(sqlSession, userId);
	}
	
	// 관리자 일반회원관리 리스트
	@Override
	public ArrayList<Member> memberBuyerList(PageInfo pi) {
		return memberDao.memberBuyerList(sqlSession, pi);	
	}
	
	// 관리자 일반회원 상세조회
	@Override
	public Member adminSelectBuyer(int userNo) {
		return memberDao.adminSelectBuyer(sqlSession, userNo);
	}
	
	// 관리자 일반회원 탈퇴시키기
	@Override
	public int adminDeleteBuyer(String userId) {
		return memberDao.adminDeleteBuyer(sqlSession, userId);
	}
	
	//이메일 인증 수정1-----------------------------------------------------------------------------------------------------
	//랜덤값 생성
//	public String generateVeriCode() {
//		Random r = new Random();
//		int n = r.nextInt(100000);
//		Format f = new DecimalFormat("000000");
//		String VeriCode = f.format(n);
//
//		return VeriCode;
//
//	}
//	@Override
//	public String sendMail(String ip) {
//		String veriCode = this.generateVeriCode();
//		Cert certVo = Cert.builder().ipInfo(ip).veriCode(veriCode).build();
//		memberDao.insertVeriCode(sqlSession, certVo);
//		return veriCode;
//	}
//
//	@Override
//	public int valiCheck(Cert cert) {
//
//		return memberDao.valiCheck(sqlSession, cert);
//	}
//
//	@Override
//	public int emailDuplicationCheck(String emailDupl) {
//
//		return memberDao.emailDuplicationCheck(sqlSession, emailDupl);
//	}
//
//	@Override
//	public int idDuplicationCheck(String id) {
//
//		return memberDao.idDuplicationCheck(sqlSession, id);
//	}
	// 이메일 인증 수정2-----------------------------------------------------------------------------------------------------	
//	@Override
//	public void updatePwd(String secret,String userId) {
//		 memberDao.updatePwd(sqlSession,secret,userId);
//	}

	// 이메일 인증 수정 3--------------------------------------------------------------------------------------------------------
	//인증번호 만들기 
	public String generateSecret() {
		Random r = new Random();
		int n = r.nextInt(100000);
		Format f = new DecimalFormat("000000"); //자리수가 비워져있어도 자동으로 채워지는 메소드 
		String secret = f.format(n); //랜덤수를 데시마 포맷에 넣어주기
		
		return secret;
	}

	// 비밀번호 찾기 (일치하는 정보가 있을경우)
	@Override
	public int searchPwd(Member m) {
		return memberDao.searchPwd(sqlSession, m);
	}

	// 임시비밀번호로 수정하기
	@Override
	public int updatePwd(HashMap<String, Object> map) {
		return memberDao.updatePwd(sqlSession, map);
	}


	








	
	
	
	//판매자 승인목록
//	@Override
	//public List<Seller> sellerListNY() {
		//List<Seller> sellerListYN = memberDao.sellerListNY();
		//return sellerListYN;
	//	return memberDao.sellerListNY(sqlSession);
//	}

	

	
	
	
	
	
	
	//이메일인증 ------------------------------------
	
//	public String generateVeriCode() {
//	      Random r = new Random();
//	      int n = r.nextInt(100000);
//	      Format f = new DecimalFormat("000000");
//	      String VeriCode = f.format(n);
//
//	      return VeriCode;
//
//	   }
//
//	   @Override
//	   public String sendMail(String ip) {
//	      String veriCode = this.generateVeriCode();
//	      Cert certVo = Cert.builder().ipInfo(ip).veriCode(veriCode).build();
//	      memberDao.insertVeriCode(sqlSession, certVo);
//	      return veriCode;
//	   }
//
//	   @Override
//	   public int valiCheck(Cert cert) {
//
//	      return memberDao.valiCheck(sqlSession, cert);
//	   }
//
//	   @Override
//	   public int emailDuplicationCheck(String emailDupl) {
//
//	      return memberDao.emailDuplicationCheck(sqlSession, emailDupl);
//	   }
//
//	   @Override
//	   public int idDuplicationCheck(String id) {
//
//	      return memberDao.idDuplicationCheck(sqlSession, id);
//	   }
}
