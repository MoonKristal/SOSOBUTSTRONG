<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 상세보기</title>
<!-- ajax, 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- style -->
<link rel="stylesheet" href="resources/css/user/seller/orderDetailManageForm.css">
</head>
<body>

    <div class="detail_outer">

        <h2 style="margin: 10px;">주문 상세보기</h2>			
		<hr style="margin-bottom: 10px;">

        <h4><b>주문날짜</b>&nbsp; <span style="font-weight:400;">${order.orderDate}</span> &nbsp;&nbsp;&nbsp; <b>주문번호</b>&nbsp;<span style="font-weight:400;">${order.orderNo}</span></h4>

        

        <table class="detail_tb" style="margin-top: 10px; margin-bottom: 10px;">
            <tr class="status_tr">
                <c:choose>
                    <c:when test="${order.status eq '배송완료'}">
                        <td colspan="2" style="font-size: 20px;"><b style="color: blue;" class="status">${order.status} &nbsp;</b>${order.deliveryNo}</td>
                    </c:when>
                    <c:when test="${order.status eq '결제취소'}">
                        <td colspan="2" style="font-size: 20px;"><b style="color: red;" class="status">${order.status} </b></td>
                    </c:when>
                    <c:otherwise>
                        <td colspan="2" style="font-size: 20px;"><b class="status">${order.status} </b> ${order.deliveryNo}</td>
                    </c:otherwise>
                </c:choose>
            </tr>
            <tr>
                <td align="center" width="20px">
                    <img src="${order.sellerImage}" style="width: 100px; height: 90px;">
                </td>
                <td >
                    <b>[${order.sellerName}]</b>&nbsp;<span style="font-size: 14px;">${order.productName}</span> <br>
                    <span style="font-size: 12px; display: inline-block; margin-top: 10px;">${order.orderItem}</span> <br><br>
                    <span style="margin-left: 280px; font-size: 14px;"><b>${order.quantity}</b> 개 / <b style="color: red;"><fmt:formatNumber value="${order.orderPrice * order.quantity}"/></b>원</span>
                </td>
            </tr>
        </table>

        <br>

        <h3 style="color: rgb(255, 163, 63);">받는 사람 정보</h3>
			<hr class="line">

           
				<table class="dv_tb" style="margin-bottom: 10px;">
					<tr>
						<th width="23%">이름</th>
						<td name="" id="dvName" height="30">${order.deliveryName}</td>
					</tr>
					<tr>
						<th>배송주소</th>
						<td name="" id="dvAddress" height="30">${order.deliveryAddress}</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td name="" id="dvPhone" height="30">${order.deilveryPhone}</td>
					</tr>
                    <tr>
						<th>배송 요청사항</th>
						<td name="" id="dvPhone" height="30">${order.deliveryMessage}</td>
					</tr>
				</table>
			


            <br>


            <h3 style="color: rgb(255, 163, 63);">결제 정보</h3>
			<hr class="line" style="margin-bottom: 0;">

            
				<table class="pay_tb">
					<tr>
						<td width="55%" style="font-weight: bold;">결제수단</td>
						<td height="25" style="background: #ccc;">총 상품가격</td>
                        <td align="right" style="background: #ccc; font-weight: bold;"><fmt:formatNumber value="${order.orderPrice * quantity}"/> 원</td>
					</tr>
					<tr>
						<td class="bottom" style="border-bottom-style: solid;">${order.payMethod}</td>
						<td class="bottom" height="25" style="background: #ccc;">사용 포인트</td>
                        <td class="bottom" align="right" style="background:#ccc; font-weight: bold;">${order.usePoint}</td>
					</tr>
					<tr>
						<td></td>  
                        <td style="background: #ccc;"></td>
                        <c:choose>                  
                            <c:when test="${order.payMethod eq 'phone'}">
                                <td align="right" height="25" style="background: #ccc; font-weight: bold;">휴대폰 결제</td>
                            </c:when>
                            <c:otherwise>
                                <td align="right" height="25" style="background: #ccc; font-weight: bold;">카드 결제</td>
                            </c:otherwise>
                        </c:choose>
					</tr>
                    <tr>
						<td style="border-bottom-style: solid; border-bottom-color: #ccc;"></td>
						<td height="25" style="font-weight: bold; background: #ccc;">총 결제금액</td>
                        <td align="right" style="background: #ccc;font-weight: bold; color: red; border-bottom-style: solid; border-bottom-color: #ccc;"><fmt:formatNumber value="${order.orderPrice * order.quantity}"/> 원</td>
					</tr>
				</table>
			


    </div>

    
	

</body>
</html>