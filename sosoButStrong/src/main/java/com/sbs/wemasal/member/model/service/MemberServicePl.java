package com.sbs.wemasal.member.model.service;


import java.text.DecimalFormat;
import java.text.Format;
import java.util.ArrayList;
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
	public int sellerNameCheck(String checkName) {
		return memberDao.sellerNameCheck(sqlSession, checkName);
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
	
	// 관리자 판매자관리 리스트
	@Override
	public ArrayList<Seller> memberSellerList(PageInfo pi) {
		return memberDao.memberSellerList(sqlSession, pi);	
	}
	
	
	
	
	
	
	//랜덤값 생성
	public String generateVeriCode() {
		Random r = new Random();
		int n = r.nextInt(100000);
		Format f = new DecimalFormat("000000");
		String VeriCode = f.format(n);

		return VeriCode;

	}
	@Override
	public String sendMail(String ip) {
		String veriCode = this.generateVeriCode();
		Cert certVo = Cert.builder().ipInfo(ip).veriCode(veriCode).build();
		memberDao.insertVeriCode(sqlSession, certVo);
		return veriCode;
	}

	@Override
	public int valiCheck(Cert cert) {

		return memberDao.valiCheck(sqlSession, cert);
	}

	@Override
	public int emailDuplicationCheck(String emailDupl) {

		return memberDao.emailDuplicationCheck(sqlSession, emailDupl);
	}

	@Override
	public int idDuplicationCheck(String id) {

		return memberDao.idDuplicationCheck(sqlSession, id);
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
