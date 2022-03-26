package com.sbs.wemasal.community.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reply {
	
	private int replyNo;
	private int userNo;
	private String userId;
	private int refComNo;
	private String replyContent;
	private String report;
	private String createDate;
	private String modifyDate;
	private String status;
	
}
