<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 에러페이지</title>
<style>
	.wrap{
	    width: 1200px;
	    height: 800px;
	}
	#menubar{
	    float: left;
	}
	div{
	   border: 1px solid black;
	}
	.content{
	    width: 70%;
	    height: 800px;
	    margin-left: 350px;
	    padding-top: 50px;
	}
	#main-title {
		width: 100%;
		text-align: left;
	}
</style>
</head>
<body>
    
    <div class="wrap">
        <div id="menubar">
            <jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>
        </div>
	        <div class="content">
	            <div align="center">
		        <img src="https://cdn2.iconfinder.com/data/icons/oops-404-error/64/208_balloon-bubble-chat-conversation-sorry-speech-256.png">
		        <br><br>
		        <h1 style="font-weight:bold;">${ errorMsg }</h1>
	   		</div>
            
        </div>
	</div>
</body>
</html>