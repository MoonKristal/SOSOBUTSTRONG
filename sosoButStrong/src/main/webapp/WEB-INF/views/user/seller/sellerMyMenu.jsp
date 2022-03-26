<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자 마이메뉴(사이드바)</title>
<link rel="stylesheet" href="resources/css/user/seller/sellerMyMenu.css">
</head>
<body>
	<div id="sellerMyMenu-area" style="height: 1000px;">
	
		<h2>판매자 My Menu</h2>

		<ul>
			<li><a href="sellerProductList.se">상품조회/수정</a></li>
			<li><a href="productEnrollForm.se">상품등록</a></li>
			<li><a id="orderManage" href="orderManage.se">주문/배송관리</a></li>
			<li><a href="#">정산관리</a></li>
			<li><a href="#">1:1 문의관리</a></li>
			<li><a href="#">회원정보수정</a></li>
			<li><a href="#">회원탈퇴</a></li>
		</ul>
	</div>
</body>
</html>