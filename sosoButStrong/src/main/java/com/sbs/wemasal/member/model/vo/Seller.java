package com.sbs.wemasal.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Seller {
	private String userNo; //	USER_NO	NUMBER
	private String userId; //	USER_NO	NUMBER
	private String sellerName;   // 상호	SELLER_NAME	VARCHAR2(100 BYTE)
	private String sellerBRN;    // 사업자등록번호  SELLER_BRN	VARCHAR2(50 BYTE) // corporate registration number
	private String sellerPhone;  //	업체 연락처 SELLER_PHONE	VARCHAR2(13 BYTE)
	private String sellerLocation; // 사업장 소재지	SELLER_LOCATION	VARCHAR2(200 BYTE)
	private String sellerIntro; //	소개글 SELLER_INTRO	VARCHAR2(1000 BYTE)
	private String sellerImage; //	업체 대표이미지 SELLER_IMAGE	VARCHAR2(200 BYTE)
	private String sellerImagePath; 
	private String sellerStatus ; //	판매 승인 여부STATUS	 VARCHAR2(1 BYTE)
}
