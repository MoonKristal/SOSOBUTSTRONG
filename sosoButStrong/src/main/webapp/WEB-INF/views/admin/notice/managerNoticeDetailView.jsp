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
                        <td><pre name="content" style="width: 700px; height: 500px;">${ n.content }</pre></td>
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
                <br><br>

                <!--2022.4.2(토) 18h 추가-->
                <div align="center" style="float: right;">
                    <button type="button" onclick="location.href='managerList.no'">목록으로 돌아가기</button>
    
                    <button type="button" class="orangeBtn" onclick="postFormSubmit(1);">수정</button>
                    <button type="button" class="grayBtn" onclick="postFormSubmit(2);">삭제</button>
                    
                    <!--post 방식으로 요청 보내면서 name 속성 값을 보낼 수 있는 방법-->
                    <form method="post" action="" id="postForm">
                        <input type="hidden" name="nno" value="${ n.noticeNo }">
                        <input type="hidden" name="filePath" value="${ n.changeName }">
                    </form>
                    <br>                
                </div>
            </div> 
        </div>
    </div>

    <script>
        function postFormSubmit(num) {
            if (num == 1) {
                $("#postForm").attr("action", "updateForm.no").submit();
            }
            else {
                if (window.confirm("이 공지사항을 정말로 삭제하시겠습니까??")) {
                    $("#postForm").attr("action", "delete.no").submit();
                }                
            }
        }
    </script>

</body>
</html>