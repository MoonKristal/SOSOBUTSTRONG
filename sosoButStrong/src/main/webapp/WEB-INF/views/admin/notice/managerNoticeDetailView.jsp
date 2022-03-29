<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세 조회</title>
<link rel="stylesheet" href="resources/css/admin/notice/managerNoticeDetailView.css">
<link rel="shortcut icon" href="#">
<script type="text/javascript" src="resources/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
</head>
<body>
	<!--2022.3.29(화) 7h55-->

    <div class="wrap">
        <div id="menubar">
            <jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>	
        </div>

        <div class="content">
            <div class="content_1">
                <div class="title">
                    <h2>공지사항 상세 조회</h2>
                </div>
            </div>
            <div>

                <table class="table table-bordered" align="center" width="800px" margin-left="20px">
                    <tr>
                        <th class="label">카테고리</th>
                        <td>${ n.category }</td>
                    </tr>
                    <tr>
                        <th class="label">제목</th>
                        <td>${ n.title }</td>
                    </tr>
                    <tr>
                        <th class="label">중요도</th>
                        <td>
                            <input type="checkbox" name="show" value="Y" id="show" ${ n.show eq 'Y' ? "checked" : ""} disabled> <label for="show">게시 여부</label>
                            <input type="checkbox" name="top" value="Y" id="top" ${ n.top eq 'Y' ? "checked" : ""} disabled> <label for="top">중요 여부</label>
                        </td>
                    </tr>
                    <tr>
                        <th class="label">내용</th>
                        <td><textarea name="content" id="editorTxt" rows="25" cols="120" required>${ n.content }</textarea></td>
                    </tr>
                    <tr>
                        <th class="label">첨부파일</th>
                        <td>
                            <c:choose>
	                      		<c:when test="${ n.originName eq null }">
	                      			첨부된 이미지가 없습니다.
	                      		</c:when>
	                      		<c:otherwise>
	                      			<div><img src="${ n.changeName }" alt="공지사항이미지" width="500" height="300"></div>
	                        		<div><a download="${ n.originName }" href="${ n.changeName }">${ n.originName }</a></div>
	                      		</c:otherwise>
	                      	</c:choose>
                        </td>
                    </tr>
                </table>

            </div> 
        </div>
    </div>	

</body>
</html>