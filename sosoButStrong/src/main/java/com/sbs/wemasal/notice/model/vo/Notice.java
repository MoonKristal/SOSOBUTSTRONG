package com.sbs.wemasal.notice.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// 2022.3.29(화) 4h25
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Notice {
	
	private int noticeNo; // NOTICE_NO	NUMBER	No		1	공지글 구별을 위한 고유 식별값
	private int noticeWriter; // NOTICE_WRITER	NUMBER	No		2	관리자(admin)가 작성 가능 -> default는 관리자의 회원 번호
	private String category;  // CATEGORY	VARCHAR2(30 BYTE)	No		3	공지글 주제 카테고리; 공통, 구매자관련, 판매자관련, 이벤트
	private String title; // TITLE	VARCHAR2(500 BYTE)	No		4	
	private String content; // CONTENT	VARCHAR2(4000 BYTE)	No		5	
	private String createDate; // CREATE_DATE	DATE	No	"SYSDATE	"	6	공지글 작성 날짜(및 시간)
	private String show; // SHOW	VARCHAR2(1 BYTE)	No	"'Y'	"	7	공지사항 관리에서 게시 종료 클릭 시, N
	private String top; // TOP	VARCHAR2(1 BYTE)	No	"'N'	"	8	공지사항 작성/수정 시 중요 여부 체크박스
	private int count; // COUNT	NUMBER	No		9	
	private String status; // STATUS	VARCHAR2(1 BYTE)	No	"'Y'	"	10	공지글 상태; 공지글 삭제 시 N
	
	private String originName;
	private String changeName;

}
