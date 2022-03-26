<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매자 1:1문의 상세 조회</title>
</head>
<body>
	<!--2022.3.18(금) 10h50-->

    <jsp:include page="/WEB-INF/views/user/common/header.jsp"/>

    <div class="outer"> <!--header 아래 모든 부분 감싸는 div-->

        <!--구매자 마이페이지 좌측 메뉴바-->
        <jsp:include page="/WEB-INF/views/user/common/buyerMyPageMenuBar.jsp"/>

        <div class="content">
            <h2>1:1문의 상세 조회</h2>
            <br>
            
            <table class="table table-bordered" align="center">
            	<tr>제목
            	</tr>
            
            </table>

        </div> <!--div class="content" 영역 끝-->

    </div> <!--header 아래 모든 부분 감싸는 div 'outer' 영역 끝-->

</body>
</html>