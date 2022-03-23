package com.sbs.wemasal.report.model.service;

import com.sbs.wemasal.report.model.vo.Report;

public interface ReportService {

	// 커뮤니티 게시글 신고
	int insertReportCommunity(Report re);

	// 커뮤니티 게시글 신고 중복 확인
	int selectReportCommunity(Report re);

	// 커뮤니티 댓글 신고 중복 확인
	int selectReportReply(Report re);

	// 커뮤니티 댓글 신고
	int insertReportReply(Report re);

}
