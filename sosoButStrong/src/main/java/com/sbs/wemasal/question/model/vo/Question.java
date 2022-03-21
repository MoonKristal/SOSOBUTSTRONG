package com.sbs.wemasal.question.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// 2022.3.7(월) 16h5 은영
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Question {
	
	private int questionNo; // QUESTION_NO	NUMBER	No		1	문의글 구별을 위한 고유 식별값
	private int questionWriter; // QUESTION_WRITER	NUMBER	No		2	문의글 작성 회원(구매자) 번호
	private int questionSeller; // QUESTION_SELLER	NUMBER	No		3	해당 문의글을 받을 판매자 번호
	private String category; // CATEGORY	VARCHAR2(30 BYTE)	No		4	문의글 주제 카테고리; 배송지연, 주문/결제문의, 상품정보문의, 기타문의
	private int orderNo; // ORDER_NO	NUMBER	Yes		5	특정 주문 관련 문의일 경우, 관련 주문 번호
	private String questionTitle; // QUESTION_TITLE	VARCHAR2(500 BYTE)	No		6	문의글 제목
	private String questionContent; // QUESTION_CONTENT	VARCHAR2(4000 BYTE)	No		7	문의글 내용
	private String createDate; // CREATE_DATE	DATE	No	"SYSDATE	"	8	문의글 작성 날짜(및 시간)
	private String answer; // ANSWER	VARCHAR2(1 BYTE)	No	"'N'	"	9	판매자가 문의 답변/처리한 경우 Y vs 미처리 시 N
	private String status; // STATUS	VARCHAR2(1 BYTE)	No	"'Y'	"	10	문의글 상태; 작성 시 Y vs 작성자가 삭제 시 N

}
