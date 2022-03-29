<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자 My 메뉴 (사이드바)</title>
<link rel="stylesheet" href="resources/css/user/seller/sellerMyMenu.css">
</head>
<body>
	<div class="menu_bar" style="height: 100%;">
		<div class="profile">
			<div class="profile_photo">
				<img src="resources/images/defaultUserProfilePhoto.png" alt="로그인 회원 프로필 사진" width="90px" height="90px">
			</div>
			<div class="profile_name">${loginUser.userId}님의 My Menu</div>
		</div>

		<div class="menu">
			<div class="menu_group">
				<div class="menu_item"><a href="sellerProductList.se">상품조회/수정</a></div>
				<div class="menu_item"><a href="productEnrollForm.se">상품등록</a></div>
				<div class="menu_item"><a id="orderManage" href="orderManage.se">주문/배송관리</a></div>
				<div class="menu_item"><a href="overview.st">정산관리</a></div>
        <div class="menu_item"><a href="detail.st">정산 내역 상세 조회</a></div>
				<div class="menu_item"><a href="sellerList.qu">1:1 문의관리</a></div>
			</div>
		</div>
  </div>

</body>
</html>