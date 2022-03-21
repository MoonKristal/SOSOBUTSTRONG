package com.sbs.wemasal.community.model.vo;

import com.sbs.wemasal.common.model.vo.Attachment;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Community {
	
	private int comNo;
	private int userNo;
	private String comTitle;
	private String saladName;
	private String saladMaterial;
	private String saladSauce;
	private String saladComment;
	private String report;
	private String createDate;
	private String modifyDate;
	
//	private Attachment coAttachment; // sql쿼리로 join할 vo

}
