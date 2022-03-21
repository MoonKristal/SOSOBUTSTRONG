<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<meta name="viewport" content="width=device-width, height=device-height, minimum-scale=1.0, maximum-scale=1.0, initial-scale=1.0">
<link rel="stylesheet" href="resources/css/user/member/memberLogin.css">
</head>
	<body>
	<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>
 		<header>
            <h4>로그인</h2>
        </header>
        <div align="center" style="width: 300px">
        <form action="login.me" method="POST">
            <div class="input-box">
                <input id="username" type="text" name="userId" placeholder="아이디">
                <label for="username">아이디</label>
            </div>

            <div class="input-box">
                <input id="password" type="password" name="userPwd" placeholder="비밀번호">
                <label for="password">비밀번호</label>
            </div>
            <div id="forgot">ID/PW 찾기</div>
            <input type="submit" value="로그인">
        </form>
        </div>
    <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>	
	</body>
</html>