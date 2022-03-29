<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 메뉴</title>
<!-- ajax, 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- 부트스트랩에서 제공하고 있는 스타일 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- 부트스트랩에서 제공하고 있는 스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="resources/css/admin/common/header.css">
</head>
<body>


	<c:if test="${ not empty alertMsg }">
		<script>
			alert("${ alertMsg }")
		</script>
		<c:remove var="alertMsg" scope="session"/>
	</c:if>
	
	
    <div class="ad_header">
        <div class="logo_area">
            <p class="logo_k">위메샐</p>
            <p class="logo_e">We Make Salad</p>
        </div>
        <div class="ad_menubar">
            <ul class="menubar">
                <li><a href="memberBuyerList.ad">회원관리</a></li>
                <li>
                    <a href="list.se">판매자 관리</a>
                    <ul>
                        <li><a href="list.se">판매자 승인 / 거절</a></li>
                        <li><a href="memberSellerList.ad">판매자 관리</a></li>
                    </ul>
                </li>
                <li>
                    <a href="picListAd.main">메인페이지 관리</a>
                </li>
                <li>
                    <a href="communityReportList.re">커뮤니티 관리</a>
                    <ul>
                        <li><a href="communityReportList.re">레시피 신고 관리</a></li>
                        <li><a href="replyReportList.re">댓글 신고 관리</a></li>
                    </ul>
                </li>
                <li>
                    <a href="managerList.no">공지사항 관리</a>
                </li>
               	<li>
               		<a href="logout.me">로그아웃</a>
               	</li>
            </ul>
        </div>
    </div>
</body>
</html>