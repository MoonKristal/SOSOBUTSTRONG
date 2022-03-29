<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세 조회</title>
<link rel="stylesheet" href="resources/css/user/notice/noticeDetailView.css">
</head>
<body>

	<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>		
	
	<div class="wrap">
		<div class="listView" margin="auto">

			<div class="title"><h2>공지사항 상세 조회</h2></div>		
	
			<table class="table table-borderless" align="center" width="800px" margin-left="20px">
				<tr>
					<td>${ n.title }</td>
					<td>${ n.createDate }</td>
				</tr>
	
				<tr>
					<td colspan="2">
						<c:choose>
							  <c:when test="${ n.originName eq null }">
								  -
							  </c:when>
							  <c:otherwise>
								  <div><img src="${ n.changeName }" alt="공지사항이미지" width="500" height="300"></div>
							  </c:otherwise>
						  </c:choose>
					</td>
				</tr>
	
				<tr>
					<td align="center" colspan="2"><pre name="content" style="width: 700px; height: 500px; border-style: solid; padding: 20px; text-align: left !important; font-size: 20px;" >${ n.content }</pre></td>
				</tr>
			</table>
		</div> <!—div class="listView" 영역 끝—>
	</div>

    <div align="center">
        <button type="button" onclick="location.href='list.no'" class="btn btn-warning" style="margin-left: 540px;">목록으로 돌아가기</button>
	</div>
	<br>

	
	<jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>

    <br>

</body>
</html>