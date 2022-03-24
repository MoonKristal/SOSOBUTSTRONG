<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 비밀번호 찾기</title>
<link rel="stylesheet" href="resources/css/user/member/findIDPW.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>

	<div class="outer"> <!--header 아래 모든 부분 감싸는 div-->
        <div class="content">
		<!-- 여기는 content div입니다 -->
			<div id="header"><h3>로그인</h3></div>
		    <div class="left">
		    	<div id="content1">
			        <form action="" method="post">
				        <!--  -->
				        <div>
				           <h5 class="title">아이디</h5>
				           <span class="box">
				               <input type="text" class="int" name="userId" placeholder="아이디">
				           </span>
				        </div>
				        <!--  -->
				        <div>
				           <h5 class="title">비밀번호</h5>
				           <span class="box">
				               <input type="password" class="int" name="userPwd" placeholder="비밀번호">
				            </span>
				        </div>
				        <!-- BTN -->
				        <div class="btn_area" align="center"> 
				           <button type="submit" id="btnLogin" value="로그인">로그인</button>
				    	</div>
					</form>
				</div>
		    
		    </div>
		    <div class="right"></div>
		</div> 
		<!--div class="content" 영역 끝-->
    </div>
    
<jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>	
</body>
</html>