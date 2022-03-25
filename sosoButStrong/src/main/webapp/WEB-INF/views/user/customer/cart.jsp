<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니/카트</title>
<link rel="stylesheet" href="resources/css/user/customer/cart.css">
</head>
<body>
    
    <jsp:include page="/WEB-INF/views/user/common/header.jsp"/>
	<jsp:include page="/WEB-INF/views/user/common/buyerMyPageMenuBar.jsp"/>

    <br><br>
    <h2 style="font-weight: bolder; margin-left: 330px;" >&nbsp;&nbsp;장바구니</h2>
    <div class="outer" align="center" style="height: 1000px;">
    
        <hr class="divider"> <!-- 구분선 -->

        <!-- 장바구니 리스트 -->
        <c:forEach var="c" items="${list}">
            <div class="review">
                <table align="center" class="detailList">
                    <thead>
                        <tr style="width: 1200px;">
                            <td><input type="hidden" value="${c.userNo}"></td>
                            <td><input type="hidden" value="${c.cartNo}"></td>
                            <td><input type="hidden" value="${c.productNo}"></td>
                            <td align="center"  width="18%" style="padding-top:0px; border-left-style: solid; border-bottom-style: solid;"><img style="width: 130px; height: 110px;" src="${c.sellerImage}"></td>
                            <td style="border-right-style: solid; border-right-color:#ccc; border-bottom-style: solid;"><b>[${c.sellerName}]</b><br><br>
                                ${c.option}<br><br>
                                <label>${c.quantity}개 / ${c.price} 원</label>                    
                            </td>                                      
                        </tr>

                    </thead>
                  </table>
              </div>
        </c:forEach>


        <hr class="divider"> <!-- 구분선 -->
    
        <div align="center">
            <a href="saladListView.cmm" class="btn btn-dark">쇼핑계속하기</a>
            <a href="#" class="btn btn-primary">주문하기</a>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>	
</body>
</html>