<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문완료</title>
<!--style-->
<link rel="stylesheet" href="resources/css/user/order/paySuccessForm.css">
</head>
<body>

	<jsp:include page="../common/header.jsp"/>

	<br><br>

	<div class="paySuccess_outer">

		<br><br>

		<h1 align="center" style="margin: 30px; font-weight: bold; color: rgb(255, 163, 63);">주문 완료</h1>

		<h5 align="center" style="font-weight: bold;">주문이 정상적으로 완료 되었습니다.</h5>

		<br><br>
		<div align="center">			
			<a id="btn_orderNo"><input type="button" class="order-btn detail" value="주문 상세보기"></a>
			<a href="<c:url value='/'/>"> <input type="button" class="order-btn continue" value="쇼핑 계속하기"></a>
				<!-- contextroot -->
		</div>

		<br><br>

		<hr>
			<div align="center">
				<table>
					<tr height="60" style="font-size: 25px; color:rgb(255, 163, 63); font-weight: bold;">
						<td colspan="2" width="50%" style="border-right-style: solid; border-right-color: #ccc;">배송정보</td>
						<td colspan="2">결제정보</td>
					</tr>
					<tr>
						<th height="40">받는사람</th>
						<td style="border-right-style: solid; border-right-color: #ccc; font-size: 13px;">${name}</td>	
						<th height="40"  align="right">주문금액</th>
						<td align="right">${price}</td>	
					</tr>								
					<tr>
						<th height="40">배송주소</th>
						<td style="border-right-style: solid; border-right-color: #ccc; font-size: 13px;">${address}</td>
						<th height="40"  align="right">사용 포인트</th>
						<td align="right">${point}</td>
					</tr>					
					<tr>
						<th height="40">배송시 요청사항</th>
						<td style="border-right-style: solid; border-right-color: #ccc; font-size: 13px;">${message}</td>
						<th height="40" style="color:rgb(255, 163, 63); font-size: 18px;">총 결제 금액</th>
						<td align="right" style="color: red; font-size: 19px; font-weight: bold;"><fmt:formatNumber value="${totalPay}"/> 원</td>
					</tr>
				</table>
			</div>
		<hr>



	</div>	

	<script>
		$(function(){
			$('#btn_orderNo').attr('href', 'orderDetail.od?orderNo=' + '${orderNo}');
		})

	</script>

	<br>
	<jsp:include page="../common/footer.jsp"/>
	
	<br><br><br>

</body>
</html>