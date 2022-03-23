package com.sbs.wemasal.community.model.service;

import java.util.ArrayList;

import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.community.model.vo.CoAttachment;
import com.sbs.wemasal.community.model.vo.Community;
import com.sbs.wemasal.community.model.vo.Reply;

public interface CommunityService {
	
	// 커뮤니티 리스트 (select)
	ArrayList<Community> communityList(PageInfo pi);
	
	// 커뮤니티 게시글 등록 (insert)(샐러드 이미지 + 상세 게시글)
	int insertPic(Attachment at);
	int insertCommunity(Community co);

	// 페이징을 위한 게시글 개수 조회
	int selectCommunityCount();

	// 게시글 정보 조회
	CoAttachment selectCommunity(int cno);

	// 댓글작성
	int insertReply(Reply re);

	// 댓글조회
	ArrayList<Reply> selectReplyList(int refComNo);



}
