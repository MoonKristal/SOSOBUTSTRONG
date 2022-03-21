package com.sbs.wemasal.community.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.community.model.vo.CoAttachment;
import com.sbs.wemasal.community.model.vo.Community;

@Repository
public class CommunityDao {

	public int selectCommunityCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("communityMapper.selectCommunityCount");
	}

	public ArrayList<Community> communityList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);

		return (ArrayList)sqlSession.selectList("communityMapper.selectCommunityList", null, rowBounds);
	}

	public int insertPic(SqlSessionTemplate sqlSession, Attachment at) {
		return sqlSession.insert("communityMapper.insertPic", at);
	}

	public int insertCommunity(SqlSessionTemplate sqlSession, Community co) {
		return sqlSession.insert("communityMapper.insertCommunity", co);
	}

	public CoAttachment selectCommunity(SqlSessionTemplate sqlSession, int cno) {
		return sqlSession.selectOne("communityMapper.selectCommunity", cno);
	}




}
