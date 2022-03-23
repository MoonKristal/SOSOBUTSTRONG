package com.sbs.wemasal.report.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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

}
