package com.sbs.wemasal.report.model.service;

import java.util.ArrayList;

import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.community.model.vo.CoAttachment;
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

	// 신고된 레시피 개수
	int communityReportListCount();

	// 신고된 레시피 리스트
	ArrayList<Report> communityReportList(PageInfo pi);

	// 신고된 댓글 개수
	int replyReportListCount();

	// 신고된 댓글 리스트
	ArrayList<Report> replyReportList(PageInfo pi);

	// 게시글 신고 디테일(게시글)
	CoAttachment communityReportDetail(Report re);
	// 게시글 신고 디테일(댓글)
	CoAttachment replyCommunityReportDetail(Report re);

	// 신고된 댓글 디테일
	Report replyReportDetail(Report re);

	// 신고된 게시글 삭제
	int deleteCommunityReport(Report re);

	// 신고된 게시글 반려
	int rejectCommunityReport(Report re);

	// 신고된 댓글 삭제
	int deleteReplyReport(Report re);

	// 신고된 댓글 반려
	int rejectReplyReport(Report re);

	
	
}
