package com.sbs.wemasal.order.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Order {
	
	private String orderNo; //ORDER_NO	NUMBER
	private String orderItem; //ORDER_ITEM	VARCHAR2(200 BYTE)
	private int orderPrice; //ORDER_PRICE	NUMBER	
	private int usePoint;
	private String payMethod; //PAY_METHOD	VARCHAR2(50 BYTE)
	private String deliveryName; //DELIVERY_NAME	VARCHAR2(30 BYTE)
	private String deliveryAddress; //DELIVERY_ADDRESS	VARCHAR2(100 BYTE)
	private String deilveryPhone; //DELIVERY_PHONE	VARCHAR2(13 BYTE)
	private String deliveryMessage; //DELIVERY_MESSAGE	VARCHAR2(50 BYTE)
	private String orderDate; //ORDER_DATE	DATE
	private String status; //STATUS	VARCHAR2(20 BYTE)	
	private int quantity; //QUANTITY	NUMBER
	private String orderer;  // view로부터 정산 목록의 '구매자 id'를 담아올 필드
	private int seller; //판매자 번호
	private String sellerName; // 판매자 상호명
	private String sellerImage; // 판매자 프로필 이미지
	private String deliveryNo;// 운송장번호
	private int sellerCount;// 사용자가 주문한 가게의 수	
	private String productName; //주문한 상품명
	private int productNo; //주문항 상품 번호
	

	// 2022.3.28(월) 10h35'정산 관리' 기능 구현 시, 은영 추가
	private String orderCancelDate;
	private String deliveryCompleteDate;
	private String settlementExpectedDate; // SETTLEMENT_EXPECTED_DATE
	private String settlementStatus;
	
	private int fee; // view로부터 정산 목록의 '매출 연동 수수료'를 담아올 필드
	private int settlementAmount;

}
