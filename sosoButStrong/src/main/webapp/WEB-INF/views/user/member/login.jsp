<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="resources/css/user/member/login.css">
</head>
	<body>
	<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>

	<div class="outer"> <!--header 아래 모든 부분 감싸는 div-->
        <div class="content">
			<!-- 여기는 content div입니다 -->
			<div id="header"><h3>로그인</h3></div>
			
			<div id="content1">
		       <form action="login.me" method="post">
			        <!-- 아이디 -->
			        <div>
			           <h5 class="title">아이디</h5>
			           <span class="box">
			               <input type="text" class="int" name="userId" placeholder="아이디">
			           </span>
			        </div>
			
			        <!-- 비밀번호 -->
			        <div>
			           <h5 class="title">비밀번호</h5>
			           <span class="box">
			               <input type="password" class="int" name="userPwd" placeholder="비밀번호">
			            </span>
			        </div>
					<a href="findIDPW.me" id="forgot">ID/PW 찾기</a>
			        <br>
			        <!-- BTN -->
			        <div class="btn_area" align="center"> 
			           <button type="submit" id="btnLogin" value="로그인">로그인</button>
			    	</div>
				</form>
			</div> 
		<!-- content-->
		</div> 
		<!--div class="content" 영역 끝-->
    </div>
    
    <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>	
	</body>
	
	
</html>