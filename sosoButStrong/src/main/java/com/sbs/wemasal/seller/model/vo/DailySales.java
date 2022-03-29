package com.sbs.wemasal.seller.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// 2022.3.28(월) 11h15 은영
@Data
@NoArgsConstructor
@AllArgsConstructor
public class DailySales {
	
	/* 주문 1건의 [status]
	 * option1) [결제완료] -> 구매자의 '결제 취소' 버튼 클릭 -> [결제취소]
	 * option2) [결제완료] -> 판매자의 '주문 확인' 버튼 클릭 -> [상품준비중] -> 판매자의 '송장번호 등록' 버튼 클릭 -> [배송중] -> 판매자의 '배송 완료' 버튼 클릭 -> [배송완료]
	 */
	// 매출 현황 관련
	private int newOrdersCount; // 신규 주문 건수 = 주문 날짜가 오늘 + status가 [결제취소]가 아닌 주문들의 개수
	// 매출 통계 관련
	private String currentDate;
	private String newOrdersAmount; // 신규 주문 금액 합계 = 주문 날짜가 오늘 + status가 [결제취소]가 아닌 주문들의 결제 금액 합계
		
	private int toBeDispatched; // [상품준비중]인 주문 건수
	private int onDelivery; // [배송중]인 주문 건수
	private int deliveryComplete; // [배송완료] 주문 건수 = '배송완료 일자'가 오늘인 주문 건수
	private int canceled; // 취소 주문 건수 = '결제취소 일자'가 오늘인 주문 건수
	
	private String settleToday; // 오늘 정산된 건들 = '정산 예정일'이 오늘인 주문들의 결제 금액 합계
	private String settleTmr; // 정산 예정 건들 = '정산기준일 = 배송완료 일자'가 오늘인 주문들의 결제 금액 합계

}
