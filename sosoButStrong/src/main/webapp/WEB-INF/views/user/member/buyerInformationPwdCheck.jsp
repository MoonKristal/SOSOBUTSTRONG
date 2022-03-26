<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정 비밀번호 확인</title>
<link rel="stylesheet" href="resources/css/user/member/buyerInformationPWDCheck.css">
</head>
<body>

	<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>
	
    <div class="outer"> <!--header 아래 모든 부분 감싸는 div-->
        
        <!--구매자 마이페이지 좌측 메뉴바-->
        <jsp:include page="/WEB-INF/views/user/common/buyerMyPageMenuBar.jsp"/>

		<!-- 여기는 content div입니다 -->
        <div class="content">
			
			<!-- header -->
			<div id="wordsOfGuidance"><h5>회원님의 안전한 개인정보 보호를 위해 비밀번호를 다시 한번 확인합니다.</h5></div>
			
			<!-- content-->
			<div id="content2">
			      <form action="PWDCheck.me" method="post">
			       <table>
				        <tr>
				       		<th>
					            <span class="box">
					                <input type="password" class="int" name="userPwd" maxlength="20" placeholder="비밀번호를 입력해주세요" required>
					            </span>
				            </th>
				            <th>
				          		<button type="submit" id="btnJoin">확인</button>
				           </th>
			           </tr>
					</table>
				</form>
			</div> 
		</div> <!--div class="content" 영역 끝-->
    </div>

    <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>

</body>
</html>