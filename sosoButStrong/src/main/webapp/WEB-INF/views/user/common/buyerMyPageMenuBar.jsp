<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매자 마이페이지 좌측 메뉴바</title>
<link rel="stylesheet" href="resources/css/user/common/buyerMyPageMenuBar.css">
</head>
<body>

	<!--2022.3.8(화) 13h55-->
	<div class="menu_bar" style="height: auto;">
            <div class="profile">
                <div class="profile_photo">
                    <img src="resources/images/defaultUserProfilePhoto.png" alt="로그인 회원 프로필 사진" width="90px" height="90px">
                </div>
                <div class="profile_name">${loginUser.userName}의 My Menu</div>
            </div>

            <div class="menu">
                <div class="menu_group">
                	<!--현재 선택된 menu_item에 current 클래스 속성 주고 싶은데..>.<-->
                    <div class="menu_item"><a href="orderList.od" class="link menu">주문목록/배송조회</a></div>
                    <div class="menu_item"><a href="myCart.cs" class="link menu">장바구니</a></div>
                    <div class="menu_item"><a href="buyerInformationPwdCheck.me" class="link menu">회원정보수정</a></div>
                    <div class="menu_item"><a href="buyerList.qu" class="link menu">1:1문의 내역</a></div>
                    <div class="menu_item"><a href="reviewList.cs" class="link menu">리뷰관리</a></div>
                    <div class="menu_item"><a href="myRecipeListView.co" class="link menu">나의 레시피</a></div>
                </div>
            </div>
    </div>

</body>
</html>