package com.sbs.wemasal.community.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CoAttachment {
	
	// community
	private int comNo;
	private int userNo;
	private String userId;
	private String comTitle;
	private String saladName;
	private String saladMaterial;
	private String saladSauce;
	private String saladComment;
	private String report;
	private String createDate;
	private String modifyDate; 
	
	// attachment
	private int fileNo; // 첨부파일 번호
	private String originName; // 원본 파일명
	private String changeName; // 수정 파일명
	private String uploadDate; // 업로드 날짜
	private int refCno; // 커뮤니티 글 번호
	
	private String reportUserNo;
	private int like_count;
	
}