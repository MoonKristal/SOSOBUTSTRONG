<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니/카트</title>
<link rel="stylesheet" href="resources/css/user/customer/cart.css">
<style>
    .cBtn a:hover{color: rgb(255, 163, 63);}
    .cBtn a{color: black;}
</style>
</head>
<body>
    
    <jsp:include page="/WEB-INF/views/user/common/header.jsp"/>
    
    <br><br>
    
    <div class="outer" align="center">
        <jsp:include page="/WEB-INF/views/user/common/buyerMyPageMenuBar.jsp"/>
        
        <h2 style="font-weight: bolder; margin-left: 0;" >&nbsp;&nbsp;
            <img src="resources/images/cartImage.png" alt="카트이미지" style="width: 45px; height: 45px;">&nbsp;장바구니</h2>
    
        <hr class="divider"> <!-- 구분선 -->

        <!-- 장바구니 리스트 -->
        <c:choose>
            <c:when test="${ !empty list }">
                <c:forEach var="c" items="${list}">
                    <div class="" style="width: 1200px; margin-top: 30px; padding-left: 200px;">
                        <table align="center" class="detailList" style="width: 100%;">
                            <thead>
                                <tr>
                                    <td><input type="hidden" value="${c.userNo}"></td>
                                    <td><input type="hidden" value="${c.cartNo}"></td>
                                    <td><input type="hidden" value="${c.productNo}"></td>
                                    <td align="center"  width="18%" style="padding-top:0px;"><img style="width: 150px; height: 150px;" src="${c.changeName}"></td>
                                    <td style=""><i style="color: gray;">[${c.sellerName}]</i><br><br><b style="font-size: larger;">${c.productName}</b><br>
                                        <br><p style="width: 400px;">${c.option}</p>
                                        <td style="width: 200px; font-weight: bold; color:green;">${c.quantity}개 / ${c.price} 원</td>                    
                                    </td>
                                    <td class="cBtn"><a href="deleteCart.cs?cno=${c.cartNo}" style="font-weight:bolder; font-size:larger;">X</a></td>                                   
                                </tr>
                            </thead>
                          </table>
                      </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan='9' style='pointer-events: none; width:600px; text-align: center; color: black;'>장바구니에 담은 상품이 없습니다.</td>
                </tr>
            </c:otherwise>
        </c:choose>

        <hr class="divider"> <!-- 구분선 -->
    
        <div align="center" style="margin-bottom: 50px; margin-right: 20px;">
            <a href="saladListView.cmm" class="btn btn-dark">쇼핑계속하기</a>
            <a href="orderForm.od" class="btn btn-primary">주문하기</a>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>	
</body>
</html>