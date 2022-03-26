<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문취소</title>
<!-- ajax, 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- style -->
<link rel="stylesheet" href="resources/css/user/order/orderCancelForm.css">
<!--아임포트 환불-->
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script><!-- jQuery CDN --->
</head>
<body>
	
	<div class="cancel_outer">
		<h2 align="center" style="margin: 10px;">주문 취소</h2>			
		<hr style="margin-bottom: 10px;">
		
		<div class="orderCancel">
			<div align="right" style="display: block; margin-bottom: 10px; font-weight: bold;">${order.orderDate} 주문</div> 
			
			<table>
				<tr>
					<td id="orderNo" colspan="2" height="40" data-orderNo="${order.orderNo}" style="font-weight: bold;"><b style="color: white; background: rgb(255, 163, 63);">주문번호</b> ${order.orderNo}</td>
				</tr>
				<tr>
					<td align="center" width="30%" rowspan="2">
						<img src="${order.sellerImage}" alt="판매자 프로필">
					</td>
				</tr>
				<tr>
					<td>
						<b>${order.sellerName} 외 ${order.sellerCount - 1}개 </b><br>
						<label style="font-size: 13px;">${order.quantity}개 / <fmt:formatNumber value="${order.orderPrice}"/> 원</label> 
					</td>				
				</tr>			
			</table>			
		</div>

		<hr style="margin-bottom: 10px; border-style: solid; border-color: rgb(255, 163, 63);">

		<div class="cancel_info">
			<h3 style="margin: 5px;">※ 환불 정보를 확인해주세요!</h3>
			
			
			<table style="margin-top: 20px;">
				<tr>
					<td style="font-weight: bold;">결제 금액</td>
					<td align="right"><fmt:formatNumber value="${order.orderPrice}"/> 원</td>
				</tr>
				<tr>
					<td style="font-weight: bold;">사용 포인트</td>
					<td id="usePoint" align="right" data-usePoint="${order.usePoint}">${order.usePoint} 원</td>
				</tr>
				<tr>
					<td style="color: red; font-weight: bold;">환불 예상금액</td>
					<td align="right" style="color: red; font-weight: bold;">(${order.payMethod}) <fmt:formatNumber value="${order.orderPrice - order.usePoint}"/> 원</td>
				</tr>
			</table>

			<br>

			<input type="button" value="주문 취소하기" id="btn_orderCancel" style="background:rgb(182, 238, 86);" onclick="cancelPay()">
		</div>
		
	</div>

	

	<script>
	
		$(function(){
			$('#btn_orderCancel').click(function(){				
				if(confirm('주문을 취소하시겠습니까?')){
					$.ajax({
						url:"orderCancel.od",
						data:{							
							orderNo : $('#orderNo').attr('data-orderNo'),
							usePoint : $('#usePoint').attr('data-usePoint')													
						},
						success : function(result){
							if(result == 'success'){
								
								// 창 닫기
								self.close();
								//부모창에서 결제취소된 주문상세 페이지로 이동
								opener.parent.location = "orderDetail.od?alertMsg=주문취소가 완료되었습니다.&orderNo=" + $('#orderNo').attr('data-orderNo'); 				
							}
						},
						error : function(){
							console.log("주문취소 서버 에러");
						}
					})
				}
				else{					
					// 창 닫기
					self.close();					
					opener.parent.location = "orderList.od?alertMsg=주문취소를 완료하지 못했습니다.";
				}

			})		
		})

		/*
		function cancelPay() {
		  $.ajax({
			"url": "POST https://api.iamport.kr/payments/cancel", // 예: http://www.myservice.com/payments/cancel
			"type": "POST",
			"contentType": "application/json",
			"data": JSON.stringify({
			  "merchant_uid": "1647540699241", // 예: ORD20180131-0000011
			  "amount": 4900, // 환불금액
			  "reason": "결제 환불" // 환불사유			  
			}),
			"dataType": "json"			
		  }).done(function(result) { // 환불 성공시 로직 
			alert("환불 완료");
		  }).fail(function(error) { // 환불 실패시 로직
			alert("환불 실패");
		  });
		}
		*/	 


	  </script>
	


</body>
</html>