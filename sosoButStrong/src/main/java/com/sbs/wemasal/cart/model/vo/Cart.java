package com.sbs.wemasal.cart.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Cart {
	
	private int cartNo; //CART_NO	NUMBER
	private int productNo; //PRODUCT_NO	NUMBER
	private int userNo; //USER_NO	NUMBER
	private String productName; //PRODUCT_NAME	VARCHAR2(500 BYTE)
	private String option; //OPTION	VARCHAR2(4000 BYTE)
	private int price; //PRICE	NUMBER
	private int quantity; //QUANTITY	NUMBER
	private String sellerName; //
	private String sellerImage; //
	private int seller; 
	private String changeName; // 상품이미지
	
	private String calculateAmount; // 정산금액
}
