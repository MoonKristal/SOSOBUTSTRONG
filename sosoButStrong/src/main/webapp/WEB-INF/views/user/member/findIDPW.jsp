<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 비밀번호 찾기</title>
<link rel="stylesheet" href="resources/css/user/member/findIDPW.css">
<!-- 제이쿼리 --> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 <!-- 자바스크립트 -->
 <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>

	<div class="outer"> <!--header 아래 모든 부분 감싸는 div-->
        <div class="content">
		<!-- 여기는 content div입니다 -->
		    <div class="left">
		    	<div id="header1"><h3>아이디 찾기</h3></div>
		    	<div id="text1"><h6>회원가입 시 입력하신 이름 + 이메일 주소로 <br>아이디를 확인하실 수 있습니다.</h6></div>
		    	<br>
		    	<div id="content1">
			        <form action="findID.me" method="post">
				        <div>
				           <h6>이름</h6>
				           <span class="box">
				               <input type="text" class="int" name="userName" placeholder="이름">
				           </span>
				        </div>
				        <div>
				           <h6>이메일</h6>
				           <span class="box">
				               <input type="text" class="int" name="email" placeholder="이메일">
				            </span>
				        </div>
				        <!-- BTN -->
				        <div class="btn_area" align="center"> 
				           <button type="submit" id="btnFindID">아이디 찾기</button>
				    	</div>
					</form>
				</div>
		    </div><!-- left 영역 끝 -->
		    <!-- 이메일 인증 수정 3 -->
		    <div class="right">
		    	<div id="header2"><h3>비밀번호 찾기</h3></div>
		    	<div id="text2"><h6>가입하신 아이디 + 이메일 주소를 입력하시면<br>임시 비밀번호를 발급해드립니다.</h6></div>
		    	<br>
		    	<div id="content2">
			        <form action="findPwd.me" method="post">
				        <div>
				           <h6>아이디</h6>
				           <span class="box">
				               <input type="text" class="int" name="userId" placeholder="아이디">
				           </span>
				        </div>
				        <div>
				           <h6>이메일</h6>
				           <span class="box">
				               <input type="text" class="int" name="email" placeholder="이메일">
				            </span>
				        </div>
				        <!-- BTN -->
				        <div class="btn_area" align="center"> 
				           <button type="submit" id="btnFindPWD">임시비밀번호 발급</button>
				    	</div>
					</form>
				</div>
		    </div><!-- right 영역 끝 -->
		</div> 
		<!--div class="content" 영역 끝-->
    </div>
   
   	<!-- 이메일 인증 수정2 -->
    <script>
	function sendMail(){
		
		$.ajax({
			
			url:"sendMail.me",
			data:{email:$("#email").val()},
			success:function(result){ 
				if(result=='0'){
				alert("이메일발송실패");
					}else{
						alert("이메일이발송되었습니다.3분이내 입력해주세요");
					}
				},error:function(){
					
					console.log("메일발송실패");
				}
		})
	}
    
    </script>
    
	<jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>	
	<!-- 이메일 인증 수정1 -->
	<!-- 비밀번호 찾기 모달 창 -->
		<div class="modal fade" id="login_searchPwd">
	        <div class="modal-dialog modal-sm">
	            <div class="modal-content">
	
	                <!-- Modal Header -->
	                <div class="modal-header">
	                    <h4 class="modal-title">비밀번호 찾기</h4>
	                    <button type="button" class="close" data-dismiss="modal">&times;</button>
	                </div>
					<!-- Modal body -->
	                <form action="check.mail" method="post">
	                    <div class="modal-body">
	                        <div align="center">
				                             본인인증 <br>
	                        </div>
	                        <br>
	                        <div id="searchPwd_form">
                            <table id="login_searchPwd_information">
	                            <tr>
	                                <td class="login_td1">아이디</td>
	                                <td class="login_td2"><input type="text" id="user_id" name="memberName" required><br></td>
	                            </tr>
	                            <tr>
	                                <td style="height: 5px;"></td>
	                                <td id="email_result" style="height: 5px;"></td>
	                            </tr>
	                            <tr>
	                                <td class="login_td1">인증번호</td>
	                                <td class="login_td2"><input type="text" id="email_chk" name="email_chk" style="width: 200px;" required>
	                                <button type="button" id="email_chk_btn" onclick="checkmail();">확인</button><br></td>
	                            </tr>
	                            <tr>
	                                <td style="height: 5px;"></td>
	                                <td id="vali_result" style="height: 5px;"></td>
	                            </tr>
                            </table>
                        </div>
	                    </div>
	                    <!-- Modal footer -->
	                    <div class="modal-footer">
                            <button type="submit">등록</button>
                            <button type="button" data-dismiss="modal">취소</button>
                        </div>
	                </form>
	            </div>
	        </div>
	    </div>	
	
	
	     


<script>
function checkmail(){
	var chknum = $("#email_chk").val();
	
}
    
    window.onload = $(function(){
    	$('#email_vali').hide();
    	
    })
    
    $(function(){
    	
	    $('#searchId').click(function(){
	    	$('#vali_result').text("");
	    	$("#searchId_btn").attr("disabled",true);
	    	$('#email').text('');
	    })
	    	
	    $('#email_btn').click(function(){
	    		
	    		var $email = $('#email').val();
		    	var $name = $('#name').val();
				var $emailVali = $('#email_chk').val();

	    		$.ajax({
	    			url : "email.chk",
	    			data : {email : $email},
	    			type : "post",					
	    			complete : function(){
						console.log("성공이든 실패든간에 실행");
						$('#email_result').text("이메일 전송이 완료되었습니다.").css("color","gray");
					}
	    			
	    		})
	    		
	    	})
	    })
	    
	    $('#email_chk').blur(function(){
			var $emailVali = $('#email_chk').val();
	    	var $name = $('#name').val();
			var $email = $('#email').val();
			
	
			$.ajax({
				url : "emailVali.chk",
				data : {emailVali : $emailVali},
				type : "post",
				success : function(result){
					console.log(result);
					if(result>0){ //result 1이상 == 일치결과있음
						console.log(result)
						$('#vali_result').text("굿").css("color","gray");
						
					} else{
						$('#vali_result').text($emailVali + "은(는) 잘못된 인증번호입니다. 다시 입력하세요.").css("color","red");
						$('#email_chk').val('');				
					}
				},
				complete : function(){
					if($name!=null&&$email!=null&&$emailVali!=null)
						$("#searchId_btn").attr("disabled",false);
				}
			})
	})
    </script>
	
	
	
	
	
	
    
    
</body>
</html>