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
	private String orderer; //ORDERER	NUMBER
	private int seller; //판매자 번호
	private String sellerName; // 판매자 상호명
	private String sellerImage; // 판매자 프로필 이미지
	private String deliveryNo;// 운송장번호
	private int sellerCount;// 사용자가 주문한 가게의 수
}
