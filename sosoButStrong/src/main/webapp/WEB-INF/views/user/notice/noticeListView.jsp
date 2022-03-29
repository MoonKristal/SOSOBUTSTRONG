<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 목록</title>
</head>
<body>
	<!--2022.3.29(화) 8H50-->
	
	<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>	

	<h2>공지사항</h2>

	<div class="listView">
		<table class="table table-bordered" align="center">
			<thead class="thead-light">
				<tr>
					<th>글 번호</th>
					<th>작성일</th>
					<th>카테고리</th>
					<th>제목</th>
				</tr>
			</thead>

			<tbody>
				<c:choose>
					<c:when test="${ empty list }">
						<tr>
							<td colspan="4">공지사항이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="n" items="${ list }">
							<tr>
								<td class="nno">
									<c:choose>
										<c:when test="${ n.top eq 'Y' }">
											[중요]
											<input type="hidden" class="noticeNo" value="${ n.noticeNo }">
										</c:when>
										<c:otherwise>
											${ n.noticeNo }
											<input type="hidden" class="noticeNo" value="${ n.noticeNo }">
										</c:otherwise>
									</c:choose>
								</td>
								<td>${ n.createDate }</td>
								<td>${ n.category }</td>
								<td class="nTitle">${ n.title }</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>          
			</tbody>                        
		</table>
	</div> <!--div class="listView" 영역 끝-->	
	
	<jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>	
	
	<script>
    	$(function() {
    		$("tbody tr").click(function() {
    			console.log($(this).find("input[class=noticeNo]").val());
    			location.href = 'detail.no?nno=' + $(this).find("input[class=noticeNo]").val();
    		})
    	})
    </script>

</body>
</html>