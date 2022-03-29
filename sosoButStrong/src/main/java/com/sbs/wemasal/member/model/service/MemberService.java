package com.sbs.wemasal.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.member.model.vo.Cert;
import com.sbs.wemasal.member.model.vo.Member;
import com.sbs.wemasal.member.model.vo.Seller;
import com.sbs.wemasal.member.model.vo.admin;

@Service
public interface MemberService {

	// 로그인
	Member loginMember(Member m);

	// 일반회원 회원가입
	int insertMember(Member m);

	// 아이디 중복체크
	int idCheck(String checkId);
	
	// 판매자 회원가입
	int insertSeller(Member m, Seller s);
	
	// 판매자 상호 중복체크
	int sellerNameCheck(String sellerName);

	// 일반회원 정보수정
	int updateMember(Member m);

	// 일반회원 탈퇴
	int deleteMember(String userId);

	// 아이디 찾기
	String findId(Member m);
	
	// 관리자용 회원목록
	// public List<Seller> sellerListNY();
 
	// 관리자 판매자 승인거절 리스트
	// 게시판 리스트 조회 서비스 + 페이징 처리
	// 게시글 총 갯수 조회
	int selectListCount();
	
	// 관리자 판매자 승인거절 리스트 정보 조회
	ArrayList<Seller> selectList(PageInfo pi);
		
	// 관리자 판매자 승인/거절 상세페이지
	Seller selectSeller(int userNo);
	
	// 관리자 판매자 승인/거절 상세페이지 판매자 이름 가져오기
	String sellerUserName(int userNo);
	
	// 관리자 판매자 승인버튼
	int approveSeller(String userNo);
	
	// 관리자 판매자 거절버튼
	int refuseSeller(String userNo);
	
	// 관리자 판매자관리 리스트 조회
	ArrayList<admin> memberSellerList(PageInfo pi);
	
	// 관리자 판매자 상세 조회
	admin adminSelectSeller(int no);
	
	// 관리자 판매자 탈퇴시키기
	int memberDelete(String userId);
	
	// 관리자 일반회원 리스트 조회
	ArrayList<Member> memberBuyerList(PageInfo pi);
	
	// 관리자 일반회원 상세조회
	Member adminSelectBuyer(int userNo);
	
	// 관리자 일반회원 탈퇴시키기
	int adminDeleteBuyer(String userId);
	
	
	// 이메일 인증 수정1----------------------------------
	//String sendMail(String ip);
	//int valiCheck(Cert cert);
	//int emailDuplicationCheck(String emailDupl);
	//int idDuplicationCheck(String id);
	
	// 이메일 인증 수정2---------------------------------
	//void updatePwd(String secret, String userId);

	// 이메일 인증 수정3---------------------------------
	//비밀번호 찾기 (일치하는 정보가 있을경우)
	int searchPwd(Member m);

	//임시비밀번호로 수정하기
	int updatePwd(HashMap<String, Object> map);






}
