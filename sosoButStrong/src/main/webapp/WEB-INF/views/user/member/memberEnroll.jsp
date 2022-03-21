<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<style>
    div {
        width: 100%;
        height: 300px;
        
        border: 1px solid #000;
    }
    div.left {
        width: 50%;
        float: left;
        box-sizing: border-box;
    }
    div.right {
        width: 50%;
        float: right;
        box-sizing: border-box;
    }
    </style>



</head>
<body>
	<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	<div>
        <div class="left">
        	<a href="memberEnroll.me">일반회원</a>
        </div>
        <div class="right">
        	<a href="sellerEnroll.me">판매자</a>
        </div>
    </div>
	<br><br><br><br><br>
	<jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>	
</body>
</html>