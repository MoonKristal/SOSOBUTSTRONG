package com.sbs.wemasal.community.model.service;

import java.util.ArrayList;

import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.community.model.vo.CoAttachment;
import com.sbs.wemasal.community.model.vo.Community;
import com.sbs.wemasal.community.model.vo.Reply;
import com.sbs.wemasal.like.model.vo.Like;
import com.sbs.wemasal.report.model.vo.Report;

public interface CommunityService {
	
	// 베스트 커뮤니티 리스트
	// top3 comNo
	ArrayList<Integer> selectTop3ComNo();
	
	// top3 리스트
	ArrayList<Community> selectTop3List();
	
	// 신규 등록된 커뮤니티 리스트
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
	
	// 커뮤니티 상세조회 조회시 로그인 유저에 따른 좋아요 정보
	String selectIsLike(Like like);

	// 커뮤니티 상세조회시 해당 게시글 좋아요 수
	int selectLikeCount(int cno);

	// 좋아요 정보 + 좋아요 수
	Like selectLike(Like l);

	Like selectIsLike2(Like l);

	// 로그인유저가 등록한 게시글 조회
	ArrayList<Community> selectMyList(PageInfo pi, int userNo);

	// 첨부파일 삭제
	int deleteAttachment(Attachment at);
	
	// 새로운 첨부파일 등록
	int insertAttachment(CoAttachment coA);

	// 커뮤니티 수정
	int updateCommunity(Community co);

	// 레시피 게시글 삭제
	int deleteCommunity(int cno);




	

	

	




}
