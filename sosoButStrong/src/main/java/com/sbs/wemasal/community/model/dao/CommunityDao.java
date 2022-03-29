package com.sbs.wemasal.community.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.community.model.vo.CoAttachment;
import com.sbs.wemasal.community.model.vo.Community;
import com.sbs.wemasal.community.model.vo.Reply;
import com.sbs.wemasal.like.model.vo.Like;
import com.sbs.wemasal.report.model.vo.Report;

@Repository
public class CommunityDao {
	
	public ArrayList<Integer> selectTop3ComNo(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("communityMapper.selectTop3ComNo");
	}

	public ArrayList<Community> selectTop3List(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("communityMapper.selectTop3List");
	}

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

	public int insertReply(SqlSessionTemplate sqlSession, Reply re) {
		return sqlSession.insert("communityMapper.insertReply", re);
	}

	public ArrayList<Reply> selectReplyList(SqlSessionTemplate sqlSession, int refComNo) {
		return (ArrayList)sqlSession.selectList("communityMapper.selectReplyList", refComNo);
	}

	public String selectIsLike(SqlSessionTemplate sqlSession, Like like) {
		return sqlSession.selectOne("communityMapper.selectIsLike", like);
	}

	public int selectLikeCount(SqlSessionTemplate sqlSession, int cno) {
		return sqlSession.selectOne("communityMapper.selectLikeCount", cno);
	}

	public Like selectLike(SqlSessionTemplate sqlSession, Like l) {
		return sqlSession.selectOne("communityMapper.selectLike", l);
	}

	public ArrayList<Community> selectMyList(SqlSessionTemplate sqlSession, PageInfo pi, int userNo) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("communityMapper.selectMyList", userNo, rowBounds);
	}

	public int deleteAttachment(SqlSessionTemplate sqlSession, Attachment at) {
		return sqlSession.delete("communityMapper.deleteAttachment", at);
	}

	public int updateCommunity(SqlSessionTemplate sqlSession, Community co) {
		return sqlSession.update("communityMapper.updateCommunity", co);
	}

	public int insertAttachment(SqlSessionTemplate sqlSession, CoAttachment coA) {
		return sqlSession.insert("communityMapper.insertAttachment", coA);
	}

	public int deleteCommunity(SqlSessionTemplate sqlSession, int cno) {
		return sqlSession.delete("communityMapper.deleteCommunity", cno);
	}



	
	




}
