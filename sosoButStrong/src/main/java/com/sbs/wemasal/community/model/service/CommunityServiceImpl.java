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

@Service
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private CommunityDao communityDao;
	

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



	

}
