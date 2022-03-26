<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일반회원 회원가입</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<!-- 카카오 주소 api -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<link rel="stylesheet" href="resources/css/user/member/memberEnrollForm.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>
	
	<!-- header -->
    <div id="header"><h5>일반회원 회원가입</h5></div>
	
	<!-- content-->
	<div id="content">
	      <form id="enroll-form" action="insert.me" method="post">
	       
	        <!-- ID -->
	        <div>
	           <h6 class="join_title">아이디</h6>
	           <span class="box">
	               <input type="text" id="id" class="int" name="userId" maxlength="20" placeholder="첫글자를 반드시 영문자로, 영문자, 숫자 총 4~12자로 입력하시오." required>
	               <button type="button" id="id_btn" onclick= "idCheck();">중복확인</button>
	           </span>
	           <span class="error_next_box" id="error_userId"></span>
	        </div>
	
	        <!-- PW1 -->
	         <div>
	            <h6 class="join_title">비밀번호*</h6>
	            <span class="box">
	                <input type="password" id="password1" class="int" name="userPwd" maxlength="20" placeholder="영문자, 숫자, 특수문자(!@#$%^)로 총 8~15자로 입력하시오" required>
	            </span>
	            <span class="error_next_box" id="error_password1"></span>
	         </div>
	
	        <!-- PW2 확인 -->
	        <div>
	            <h6 class="join_title">비밀번호 확인*</h6>
	            <span class="box">

	                <input type="password" id="password2" class="int" maxlength="20" placeholder="비밀번호 확인" required>

	            </span>
	            <span class="error_next_box" id="error_password2"></span>
	        </div>
	
	        <!-- NAME -->
	        <div>
	           <h6 class="join_title">이름*</h6>
	           <span class="box box_name">
	               <input type="text" id="name" class="int" name="userName" maxlength="20" required>
	            </span>
	        </div>
	
	        <!-- EMAIL -->
	        <div>
	            <h6 class="join_title">이메일*</h6>
	            <span class="box">
	                <input type="text" id="email" class="int" name="email"  placeholder="이메일 입력" >
	            </span>
	        </div>
			<span class="error_next_box" id="error_email"></span>
	        <!-- MOBILE -->
	        <div>
	            <h6 class="join_title">연락처*</h6>
	            <span class="box">
	                <input type="tel" id="phoneNo" class="int" name="phone" maxlength="16" placeholder="-포함하여 입력" required>
	            </span>
	        </div>
	
			<!-- ADDRESS -->
	        <div>
	            <h6 class="join_title">주소*</h6>
	            <span class="box_address">
	                <button type="button" onclick = "sample4_execDaumPostcode()" id="address_btn">우편번호 찾기</button>
	            </span>
	            <span class="box">
	                <input type="text" id="sample4_Address" class="int" name="address"  placeholder="주소">
	            </span>
	        </div>
	           
	        <!-- GENDER -->
			<div>
	            <h6 class="join_title">성별</h6>
	            <span class="box">
	                <input type="radio" class="input_gender" name="gender" value="남" ><label class="font_gender" for="male">남</label>
	                <input type="radio" class="input_gender" name="gender" value="여" ><label class="font_gender" for="female">여</label>
	          	</span>
	        </div>
				
			<!-- BIRTH -->
			<div>
	        	<h6 class="join_title">생일</h6>
			    	<span class="box">
	           		<input type="date" class="int" name="birth" >
	        	</span>
	       	</div>
	        <br>
	        <!-- JOIN BTN -->
	        <div class="btn_area">
	           <button type="submit" id="btnJoin">
	               <span>가입하기</span>
	           </button>
	    	</div>
		</form>
	</div> 
	<!-- content-->

    <br>
   
  <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>
    
	<script>
	    
		// 주소 api
	    function sample4_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var roadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 참고 항목 변수
	
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }
	                
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                // document.getElementById('sample4_postcode').value = data.zonecode; 
	                // document.getElementById("sample4_roadAddress").value = roadAddr;
	                // document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
	                
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                $('#sample4_Address').val('[' + data.zonecode + '] '+ roadAddr + ' '); 
	                
	        
	            }
	        }).open();
	    }
		
		// 유효성 검사
		
	       $(function(){
	    		// 아이디 유효성 검사 -> 첫글자를 반드시 영문자로, 영문자, 숫자 총 4~12자로 입력
	    		$("#id").keyup(function(){
	    			var $id = $("#id").val();
	    			var regExp = /^[a-z][a-z\d]{3,11}$/i;
	    			
	    			if(regExp.test($id)){
	    				$("#error_userId").text("중복확인을 해주세요.").css("color", "green");
	    			}else{
	    				$("#error_userId").text("첫글자를 반드시 영문자로, 영문자, 숫자 총 4  ~ 12자로 입력하시오.").css("color", "red");
	    				
	    			}
	    		})
	    		
	    		// 비밀번호 유효성 검사 -> 영문자, 숫자, 특수문자(!@#$%^)로 총 8~15자로 입력
	    		$("#password1").keyup(function(){
	    			var $password1 = $("#password1").val();
	    			var regExpPw = /^[a-z\d!@#$%^]{8,15}$/i;
	    			
	    			if(regExpPw.test($password1)){
	    				$("#error_password1").text("사용가능합니다.").css("color","green");
	    			}else{
	    				$("#error_password1").text("영문자, 숫자, 특수문자로 총 8~15자로 입력하시오.").css("color", "red");
	    			}
	    		}) 
	    		
	    		// 비밀번호 확인
	  			$("#password2").keyup(function(){
	  				var $password1 = $("#password1").val();
	  				var $password2 = $("#password2").val();
	  			
	  				if($password1 == $password2){
	  					$("#error_password2").text("일치합니다.").css("color","green");
	  				}else{
	  					$("#error_password2").text("일치하지 않습니다.").css("color", "red");
	  				}
	  			})
	  			
	    		
	    		// 이메일 형식 확인
			 	$("#email").keyup(function(){
			 		var $email = $("#email").val();
			 		var regExp = /^[A-Za-z0-9._]+[@]+[A-Za-z0-9]+[.]+[A-Za-z.]+$/;
			 		
			 		if(regExp.test($email)){
			 			$("#error_email").text("사용가능합니다.").css("color","green");
			 		}else{
			 			$("#error_email").text("이메일 형식이 올바르지 않습니다.").css("color","red");
			 		}
			 	})
			 	
	       })
		   
		// 아이디 중복체크
			function idCheck(){
		        var $userId = $("input[name=userId]");
		        
		        $.ajax({
		            url : "idCheck.me",
		            data : { checkId : $userId.val() },
		            success : function(result){
		                
		                // result 경우의 수 : "NN", "NY"
		                if(result == "NN"){ // 중복된 아이디 == 사용불가
		                    
		                    alert("이미 존재하거나 탈퇴한 회원의 아이디입니다.");
		                    //재입력 유도
		                    $userId.focus();
		                }
		                else{ // 중복되지 않은 아이디 == 사용가능
		                    
		                    alert("사용 가능한 아이디입니다.");
		                    $("#error_userId").text("사용가능합니다.").css("color", "green");
		                }
		            },
		            error : function(){
		                console.log("아이디 중복체크 실패");
		            }
		        })
	    		
		    }
	    
	</script>
</body>
</html>