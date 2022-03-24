package com.sbs.wemasal.member.model.service;

import org.springframework.stereotype.Service;

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

}
