<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 메인사진 등록</title>
<link rel="stylesheet" href="resources/css/admin/main/mainInsertForm.css">
</head>
<body>
    <div class="wrap">
        <div id="menubar">
            <jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>
        </div>
        <div class="content">
            <form action="insertPic.main" method="post" enctype="multipart/form-data">
                <div class="content_1">
                    <div class="title">
                        <h2>메인페이지 사진 등록</h2>
                    </div>
                </div>
                <div class="content_2">
                    <div class="mainPic_info">
                        <div class="input_ment">
                            첨부파일 <br>
                        </div>
                        <div class="input_tag">
                            <input type="file" name="upfile" class="input_size" required>
                        </div>
                    </div>
                </div>
                <div class="content_3">
                    <a href="" class="btn btn-outline-secondary">목록가기</a>
                    <button class="btn btn-outline-danger" type="reset">취소하기</button>
                    <button class="btn btn-outline-primary" type="submit">등록하기</button>
                </div>
            </form>
        </div>
    </div>

</body>
</html>