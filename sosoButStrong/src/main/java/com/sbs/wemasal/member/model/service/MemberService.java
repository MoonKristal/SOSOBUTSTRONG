package com.sbs.wemasal.member.model.service;

import org.springframework.stereotype.Service;

import com.sbs.wemasal.member.model.vo.Member;

@Service
public interface MemberService {

	Member loginMember(Member m);

	int insertMember(Member m);

	int idCheck(String checkId);



}
