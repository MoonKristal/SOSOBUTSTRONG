<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- ajax, 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- 부트스트랩에서 제공하고 있는 스타일 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- 부트스트랩에서 제공하고 있는 스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!--결제를 위한 아임포트 -->
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<link rel="stylesheet" href="resources/css/user/common/header.css">
</head>
<body>




	
	<c:if test="${ not empty alertMsg }">
		<script>
			alert("${ alertMsg }")
		</script>
		<c:remove var="alertMsg" scope="session"/>
	</c:if>
	



    <div class="header" align="center">
    	<div class="logo_area">
            <div class="logo_bg">
                <p class="logo_k">위메샐</p>
                <p class="logo_e">We Make Salad</p>
            </div>
            <div>
                <c:choose>
            		<c:when test="${ empty loginUser }">
		            	<!-- 로그인 전 -->
		                <div class="service_area">
		                    <a href="loginPage.me">로그인</a>
		                    <a href="enroll.me">회원가입</a>
		                </div>
		            </c:when>
		            <c:otherwise>
		                <!-- 로그인 후 -->
		                <div class="service_area">
		                    <a href="logout.me">로그아웃</a>
		                    <a href="myPage.cmm">마이페이지</a>

							<c:if test="${loginUser.userType eq 1}"> <!-- 장바구니는 일반회원(1) 만 사용 하도록 -->
		                    <a href="myCart.cs">장바구니</a>
							</c:if>
	                	</div>
	                </c:otherwise>
	            </c:choose>
            </div>
        </div>

        <div class="navi_area">
            <div class="group_navi">
                <ul class="list_navi">
                    <li class="navi_item"><a href="#" class="link navi">ABOUT</a></li>
                    <li class="navi_item"><a href="saladListView.cmm" class="link navi">SALA:D</a></li>
                    <li class="navi_item"><a href="communityList.co" class="link navi">COMMUNITY</a></li>
                    <li class="navi_item"><a href="list.no" class="link navi">SERVICE</a></li>
                </ul>
            </div>
        </div>

    </div>

</body>
</html>