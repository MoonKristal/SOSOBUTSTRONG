package com.sbs.wemasal.report.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

}
