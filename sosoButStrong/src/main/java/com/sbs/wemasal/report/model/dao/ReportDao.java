package com.sbs.wemasal.report.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.community.model.vo.CoAttachment;
import com.sbs.wemasal.report.model.vo.Report;

@Repository
public class ReportDao {

	public int insertReportCommunity(SqlSessionTemplate sqlSession, Report re) {
		return sqlSession.insert("reportMapper.insertReportCommunity", re);
	}

	public int selectReportCommunity(SqlSessionTemplate sqlSession, Report re) {
		return sqlSession.selectOne("reportMapper.selectReportCommunity", re);
	}

	public int selectReportReply(SqlSessionTemplate sqlSession, Report re) {
		return sqlSession.selectOne("reportMapper.selectReportReply", re);
	}

	public int insertReportReply(SqlSessionTemplate sqlSession, Report re) {
		return sqlSession.insert("reportMapper.insertReportReply", re);
	}
	
	public int communityReportListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("reportMapper.communityReportListCount");
	}

	public ArrayList<Report> communityReportList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("reportMapper.communityReportList", null, rowBounds);
	}

	public int replyReportListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("reportMapper.replyReportListCount");
	}

	public ArrayList<Report> replyReportList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("reportMapper.replyReportList", null, rowBounds);
	}

	public CoAttachment communityReportDetail(SqlSessionTemplate sqlSession, Report re) {
		return sqlSession.selectOne("communityMapper.communityReportDetail", re);
	}
	
	public CoAttachment replyCommunityReportDetail(SqlSessionTemplate sqlSession, Report re) {
		return sqlSession.selectOne("communityMapper.replyCommunityReportDetail", re);
	}

	public Report replyReportDetail(SqlSessionTemplate sqlSession, Report re) {
		return sqlSession.selectOne("reportMapper.replyReportDetail", re);
	}

	public int deleteCommunityReport(SqlSessionTemplate sqlSession, Report re) {
		return sqlSession.update("reportMapper.deleteCommunityReport", re);
	}

	public int rejectCommunityReport(SqlSessionTemplate sqlSession, Report re) {
		return sqlSession.update("reportMapper.rejectCommunityReport", re);
	}

	public int deleteReplyReport(SqlSessionTemplate sqlSession, Report re) {
		return sqlSession.update("reportMapper.deleteReplyReport", re);
	}

	public int rejectReplyReport(SqlSessionTemplate sqlSession, Report re) {
		return sqlSession.update("reportMapper.rejectReplyReport", re);
	}

	


	

}
