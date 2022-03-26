<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 선택</title>
<link rel="stylesheet" href="resources/css/user/member/memberEnroll.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>
	<div class="outer"> <!--header 아래 모든 부분 감싸는 div-->
        <div class="content">
		<!-- 여기는 content div입니다 -->
			<div id="header"><h3>회원가입</h3></div>
		    <div class="left">
		    	<div id="content1">
				        <!-- 일반회원 -->
				        <div style="text-align:center;">
				           <img src="resources/images/일반회원.png" alt="일반회원">
				        </div>
				        <!-- BTN -->
				        <div class="btn_area" align="center"> 
				           <button type="button" onclick="location.href='memberEnroll.me'" id="buyerBtn" >일반회원</button>
				    	</div>
				</div>
		    </div>
		    <div class="right">
		    	<div id="content2">
				        <!-- 판매자 -->
				        <div style="text-align:center;">
				           <img src="resources/images/판매자.png" alt="판매자">
				        </div>
				        <!--  -->
				        <!-- BTN -->
				        <div class="btn_area" align="center"> 
				           <button type="button" onclick="location.href='sellerEnroll.me'" id="sellerBtn">판매자</button>
				    	</div>
				</div>
		    </div>
		</div> 
		<!--div class="content" 영역 끝-->
    </div>
	<jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>	
</body>
</html>
