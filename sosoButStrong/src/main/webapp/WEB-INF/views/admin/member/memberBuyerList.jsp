<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 일반회원리스트</title>
<link rel="stylesheet" href="resources/css/admin/member/memberBuyerList.css">

</head>
<body>

	<div class="wrap">
        <div id="menubar">
            <jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>
        </div>
        <div class="content">
            <!--  === Main ===  -->
			<div id="main-title"><h3 style="font-weight: bold;" >일반회원 관리</h3></div>
			
			<div class="innerOuter" style="padding:5% ">
            <table id="boardList" align="center">
 				<thead>                  
                    <tr height=35px>
                        <th width=100px >USER.NO</th>
                        <th width=150px>아이디</th>
                        <th width=150px>이름</th>
                        <th width=200px>연락처</th>
                        <th width=200px>이메일</th>
                        <th width=150px>적립금</th>
                    </tr>
                </thead>
                <tbody>
					<c:forEach items="${list}" var="m">
	                    <tr>
	                        <td class="no">${m.userNo}</td>
	                        <td>${m.userId}</td>
	                        <td>${m.userName}</td>
	                        <td>${m.phone}</td>
	                        <td>${m.email}</td>
	                        <td>${m.point}</td>
	                    </tr>
                   </c:forEach>
                </tbody>   
            </table>
            <br>
			
           
            <div id="pagingArea">
                <ul class="pagination">
					<c:choose>
						<c:when test="${ pi.currentPage eq 1 }">
	                    	<li class="page-item disabled"><a class="page-link" href="#">Previous</a></li><!-- 1번페이지일경우 -->
	                    </c:when>
	                    <c:otherwise>
	                    	<li class="page-item"><a class="page-link" href="memberBuyerList.ad?cpage=${ pi.currentPage - 1 }">Previous</a></li>
	                    </c:otherwise>
					</c:choose>

					<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                    	<li class="page-item"><a class="page-link" href="memberBuyerList.ad?cpage=${ p }">${ p }</a></li>
					</c:forEach>

					<c:choose>
						<c:when test="${ pi.currentPage eq pi.maxPage }">
		                    <li class="page-item disabled"><a class="page-link" href="#">Next</a></li><!-- 마지막페이지일경우 -->
						</c:when>
						<c:otherwise>
		                    <li class="page-item"><a class="page-link" href="mmemberBuyerList.ad?cpage=${ pi.currentPage + 1 }">Next</a></li><!-- 마지막페이지일경우 -->
						</c:otherwise>
					</c:choose>
                </ul>
            </div>
        </div>
	</div>
	</div>
	<!-- 상세정보조회 -->
	<script>
            	$(function(){
					    $("#boardList>tbody>tr").click(function(){
					    	location.href = 'buyerDetail.ad?no=' + $(this).children(".no").text();
					    })        		
            	})
    </script>
	   
</body>
</html>



