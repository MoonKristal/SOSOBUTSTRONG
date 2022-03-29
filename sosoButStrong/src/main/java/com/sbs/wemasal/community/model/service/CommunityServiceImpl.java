package com.sbs.wemasal.community.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.community.model.dao.CommunityDao;
import com.sbs.wemasal.community.model.vo.CoAttachment;
import com.sbs.wemasal.community.model.vo.Community;
import com.sbs.wemasal.community.model.vo.Reply;
import com.sbs.wemasal.like.model.vo.Like;
import com.sbs.wemasal.report.model.vo.Report;

@Service
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private CommunityDao communityDao;
	
	@Override
	public ArrayList<Integer> selectTop3ComNo() {
		return communityDao.selectTop3ComNo(sqlSession);
	}
	
	@Override
	public ArrayList<Community> selectTop3List() {
		return communityDao.selectTop3List(sqlSession);
	}
	
	@Override
	public int selectCommunityCount() {
		return communityDao.selectCommunityCount(sqlSession);
	}

	@Override
	public ArrayList<Community> communityList(PageInfo pi) {
		return communityDao.communityList(sqlSession, pi);
	}

	@Override
	public int insertPic(Attachment at) {
		return communityDao.insertPic(sqlSession, at);
	}

	@Override
	public int insertCommunity(Community co) {
		return communityDao.insertCommunity(sqlSession, co);
	}

	@Override
	public CoAttachment selectCommunity(int cno) {
		return communityDao.selectCommunity(sqlSession, cno);
	}

	@Override
	public int insertReply(Reply re) {
		return communityDao.insertReply(sqlSession, re);
	}

	@Override
	public ArrayList<Reply> selectReplyList(int refComNo) {
		return communityDao.selectReplyList(sqlSession, refComNo);
	}

	@Override
	public String selectIsLike(Like like) {
		return communityDao.selectIsLike(sqlSession, like);
	}

	@Override
	public int selectLikeCount(int cno) {
		return communityDao.selectLikeCount(sqlSession, cno);
	}

	@Override
	public Like selectLike(Like l) {
		return communityDao.selectLike(sqlSession, l);
	}

	@Override
	public Like selectIsLike2(Like l) {
		return communityDao.selectLike(sqlSession, l);
	}

	@Override
	public ArrayList<Community> selectMyList(PageInfo pi, int userNo) {
		return communityDao.selectMyList(sqlSession, pi, userNo);
	}

	@Override
	public int deleteAttachment(Attachment at) {
		return communityDao.deleteAttachment(sqlSession, at);
	}

	@Override
	public int updateCommunity(Community co) {
		return communityDao.updateCommunity(sqlSession, co);
	}

	@Override
	public int insertAttachment(CoAttachment coA) {
		return communityDao.insertAttachment(sqlSession, coA);
	}

	@Override
	public int deleteCommunity(int cno) {
		return communityDao.deleteCommunity(sqlSession, cno);
	}


	




	

}
