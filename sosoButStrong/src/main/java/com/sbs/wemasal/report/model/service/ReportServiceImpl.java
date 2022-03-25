package com.sbs.wemasal.report.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.community.model.vo.CoAttachment;
import com.sbs.wemasal.report.model.dao.ReportDao;
import com.sbs.wemasal.report.model.vo.Report;

@Service
public class ReportServiceImpl implements ReportService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private ReportDao reportDao;
	
	@Override
	public int insertReportCommunity(Report re) {
		return reportDao.insertReportCommunity(sqlSession, re);
	}

	@Override
	public int selectReportCommunity(Report re) {
		return reportDao.selectReportCommunity(sqlSession, re);
	}

	@Override
	public int selectReportReply(Report re) {
		return reportDao.selectReportReply(sqlSession, re);
	}

	@Override
	public int insertReportReply(Report re) {
		return reportDao.insertReportReply(sqlSession, re);
	}

	@Override
	public int communityReportListCount() {
		return reportDao.communityReportListCount(sqlSession);
	}

	@Override
	public ArrayList<Report> communityReportList(PageInfo pi) {
		return reportDao.communityReportList(sqlSession, pi);
	}

	@Override
	public int replyReportListCount() {
		return reportDao.replyReportListCount(sqlSession);
	}

	@Override
	public ArrayList<Report> replyReportList(PageInfo pi) {
		return reportDao.replyReportList(sqlSession, pi);
	}

	@Override
	public CoAttachment communityReportDetail(Report re) {
		return reportDao.communityReportDetail(sqlSession, re);
	}
	
	@Override
	public CoAttachment replyCommunityReportDetail(Report re) {
		return reportDao.replyCommunityReportDetail(sqlSession, re);
	}

	@Override
	public Report replyReportDetail(Report re) {
		return reportDao.replyReportDetail(sqlSession, re);
	}

	@Override
	public int deleteCommunityReport(Report re) {
		return reportDao.deleteCommunityReport(sqlSession, re);
	}

	@Override
	public int rejectCommunityReport(Report re) {
		return reportDao.rejectCommunityReport(sqlSession, re);
	}

	@Override
	public int deleteReplyReport(Report re) {
		return reportDao.deleteReplyReport(sqlSession, re);
	}

	@Override
	public int rejectReplyReport(Report re) {
		return reportDao.rejectReplyReport(sqlSession, re);
	}

	



}
