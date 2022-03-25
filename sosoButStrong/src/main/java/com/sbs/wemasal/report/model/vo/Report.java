package com.sbs.wemasal.report.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Report {
	
	private int userNo;
	private int reportCom;
	private int reportRep;
	private String reason;
	private String status;
	private String createDate;
	private String completion;
	private String comTitle;
	private String replyContent;
	private String userId;
	
	private String reportUserNo;
	
}
