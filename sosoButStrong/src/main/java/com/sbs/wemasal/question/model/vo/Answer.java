package com.sbs.wemasal.question.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// 2022.3.7(월) 16h20
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Answer {
	
	private int answerNo; // ANSWER_NO	NUMBER	No		1	답변글 구별을 위한 고유 식별값
	private int questionNo; // QUESTION_NO	NUMBER	No		2	문의글 구별을 위한 고유 식별값 = QUESTION 테이블로부터 foreign key
	private int answerWriter; // ANSWER_WRITER	NUMBER	No		3	답변글 작성 회원(판매자) 번호
	private String answerContent; // ANSWER_CONTENT	VARCHAR2(4000 BYTE)	No		4	답변글 내용
	private String createDate; // CREATE_DATE	DATE	No	"SYSDATE	"	5	답변글 작성 날짜(및 시간)
	private int score; // SCORE	NUMBER	Yes		6	구매자가 답변에 대해 평가한 만족도(0~10 정수 + 미평가/자료없는 경우 999)
	
	private String originName;
	private String changeName;
	
	private String answerMode; // 2022.3.25(금) 13h10 추가
}
