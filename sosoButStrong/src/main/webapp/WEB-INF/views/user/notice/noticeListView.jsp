<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 목록</title>
<link rel="stylesheet" href="resources/css/user/notice/noticeListView.css">
</head>
<body>
	<!--2022.3.29(화) 8H50-->
	
	<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>		

	<br>
	<div class="listView">
		<div class="title"><h2>공지사항</h2></div>

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

	<div id="paging-area">
		<ul class="pagination justify-content-center" style="margin:20px 0">
		
			<c:choose>
				<c:when test="${ pi.currentPage eq 1 }">
					<li class="page-item disabled"><a class="page-link" href="#">&lt;&lt;</a></li>
					   <li class="page-item disabled"><a class="page-link" href="#">&lt;</a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link" href="list.no">&lt;&lt;</a></li>
					<li class="page-item"><a class="page-link" href="list.no?cpage=${ pi.currentPage - 1 }">&lt;</a></li>
				</c:otherwise>
			</c:choose>
			
			<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
				<c:choose>
					<c:when test="${ p eq pi.currentPage }">
						<li class="page-item disabled"><a class="page-link" href="#">${ p }</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link" href="list.no?cpage=${ p }">${ p }</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
			<c:choose>
				<c:when test="${ pi.currentPage eq pi.maxPage }">
					<li class="page-item disabled"><a class="page-link" href="#">&gt;</a></li>
					<li class="page-item disabled"><a class="page-link" href="#">&gt;&gt;</a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled"><a class="page-link" href="list.no?cpage=${ pi.currentPage + 1 }">&gt;</a></li>
					<li class="page-item disabled"><a class="page-link" href="list.no?cpage=${ pi.maxPage }">&gt;&gt;</a></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div> <!—div id="paging-area" 영역 끝—>
	
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