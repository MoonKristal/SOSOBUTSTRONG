<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매자 마이페이지</title>
<link rel="stylesheet" href="resources/css/user/common/header.css">
</head>
<body>
	
	<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>
	
	<div class="outer">
        
        <!--구매자 마이페이지 좌측 메뉴바-->
        <jsp:include page="/WEB-INF/views/user/common/buyerMyPageMenuBar.jsp"/>

        <div class="content">
			<div>여기는 content div입니다</div>            
        </div>

    </div>

    <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>

</body>
</html>