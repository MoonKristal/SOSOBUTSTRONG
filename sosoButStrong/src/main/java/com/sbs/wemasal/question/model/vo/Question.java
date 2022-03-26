package com.sbs.wemasal.question.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
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
	private String orderNo; // ORDER_NO	NUMBER	Yes		5	특정 주문 관련 문의일 경우, 관련 주문 번호
	private String answerMode; // 2022.3.16(수) 16h50 은영 '답변 수신 방법' 컬럼 추가; ANSWER_MODE	VARCHAR2(10 BYTE)	Yes		6	답변 수신을 이메일 또는 문자메시지로 받겠다고 선택 가능
	private String questionTitle; // QUESTION_TITLE	VARCHAR2(500 BYTE)	No		6	문의글 제목
	private String questionContent; // QUESTION_CONTENT	VARCHAR2(4000 BYTE)	No		7	문의글 내용
	private String createDate; // CREATE_DATE	DATE	No	"SYSDATE	"	8	문의글 작성 날짜(및 시간) -> db에는 DATE 자료형으로 저장
	private String answer; // ANSWER	VARCHAR2(1 BYTE)	No	"'N'	"	9	판매자가 문의 답변/처리한 경우 Y vs 미처리 시 N
	private String status; // STATUS	VARCHAR2(1 BYTE)	No	"'Y'	"	10	문의글 상태; 작성 시 Y vs 작성자가 삭제 시 N
	
	private String sellerName; // 2022.3.24(목) 16h30 구매자의 1:1문의 list 조회해오며 추가
	
	// 2022.3.25(금) 1h30 문의내역 상세 조회해오며 추가
	private String sellerPhone;
	private String originName;
	private String changeName;
	
	// 2022.3.25(금) 3h30 문의내역 검색 요청 받아오며 추가 -> 5h55 요청 받은 값들 request 객체를 통해 뺄 수 있는 바, 필요 없을 듯
	/*
	private String startDate;
	private String endDate;
	private String condition;
	private String keyword;
	*/
	
	// 2022.3.25(금) 10h 구매자 문의 관리 list 조회해오며 추가
	private String userId;
	private String userName;
	private String answerDate;
	private int score; // 구매자가 답변에 대해 평가한 만족도(0~10 정수 + 미평가/자료없는 경우 999)
}
