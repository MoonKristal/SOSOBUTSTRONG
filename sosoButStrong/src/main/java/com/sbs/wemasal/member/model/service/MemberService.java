package com.sbs.wemasal.member.model.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.member.model.vo.Cert;
import com.sbs.wemasal.member.model.vo.Member;
import com.sbs.wemasal.member.model.vo.Seller;

@Service
public interface MemberService {

	Member loginMember(Member m);

	int insertMember(Member m);

	int idCheck(String checkId);
	
	int insertSeller(Member m, Seller s);
	
	int sellerNameCheck(String checkName);

	int updateMember(Member m);

	int deleteMember(String userId);

	String findId(Member m);
	
	//관리자용 회원목록
	//public List<Seller> sellerListNY();
 
	// 게시판 리스트 조회 서비스 + 페이징 처리
	// 게시글 총 갯수 조회
	int selectListCount();
	// 게시글 리스트 조회
	ArrayList<Seller> selectList(PageInfo pi);
		
	// 이메일 인증
	
	String sendMail(String ip);
	   
	int valiCheck(Cert cert);
	   
	int emailDuplicationCheck(String emailDupl);
	   
	int idDuplicationCheck(String id);
}
