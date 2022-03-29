<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정 비밀번호 확인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="resources/css/user/member/buyerInformation.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>
	
	<!--2022.3.7(월) 14h25
		http://localhost:8765/wemasal/WEB-INF/views/user/question/buyerQuestionListView.jsp-->
    <div class="outer"> <!--header 아래 모든 부분 감싸는 div-->
        
        <!--구매자 마이페이지 좌측 메뉴바-->
        <jsp:include page="/WEB-INF/views/user/common/buyerMyPageMenuBar.jsp"/>

        <div class="content">
			<!-- 여기는 content div입니다 -->
			<h3>회원정보</h3>
			<br><br>
			<div id="content">
		      <form action="buyerInformationUpdate.me" method="post">
		       
		        <!-- ID -->
		        <div>
		           <h6 class="join_title">아이디</h6>
		           <span class="box">
		               <input type="text" class="int" name="userId" value="${ loginUser.userId }" readonly>
		           </span>
		        </div>
		
		        <!-- NAME -->
		        <div>
		           <h6 class="join_title">이름</h6>
		           <span class="box box_name">
		               <input type="text" class="int" name="userName" value="${ loginUser.userName }" required >
		            </span>
		        </div>
		
		        <!-- EMAIL -->
		        <div>
		            <h6 class="join_title">이메일</h6>
		            <span class="box">
		                <input type="text" class="int" name="email" value="${ loginUser.email }" required>
		            </span>
		        </div>
		        
		        <!-- MOBILE -->
		        <div>
		            <h6 class="join_title">연락처</h6>
		            <span class="box">
		                <input type="tel" class="int" name="phone" value="${ loginUser.phone }" required>
		            </span>
		        </div>
		
				<!-- ADDRESS -->
		        <div>
		            <h6 class="join_title">주소</h6>
		            <span class="box">
		                <input type="text" class="int" name="address" value="${ loginUser.address }" required>
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
		           		<input type=text class="int" name="birth" value="${ loginUser.birth }" pattern="yyyy-MM-dd" placeholder="yyyy-MM-dd로 입력해주세요." readonly>
		        	</span>
		       	</div>
		       	<script>
                    	$(function(){
                    		if("${ loginUser.gender }" != ""){
	                    		$('input[value="${ loginUser.gender }"]').attr("checked", true)
                    		}
                    	})
                </script>
		        <br>
		        <!-- BTN -->
		        <div class="btn_area" align="center"> 
		           <button type=submit" id="btnUpdate">수정하기</button>
		           <button type="button" id="btnDelete" data-toggle="modal" data-target="#deleteForm">탈퇴하기</button>
		    	</div>
			</form>
		</div> 
		<!-- content-->
		
		<!-- 회원탈퇴 모달 창 -->
		<div class="modal fade" id="deleteForm">
	        <div class="modal-dialog modal-sm">
	            <div class="modal-content">
	
	                <!-- Modal Header -->
	                <div class="modal-header">
	                    <h4 class="modal-title">회원탈퇴</h4>
	                    <button type="button" class="close" data-dismiss="modal">&times;</button>
	                </div>
	
	                <form action="buyerInformationDelete.me" method="post">
	                    <!-- Modal body -->
	                    <div class="modal-body">
	                        <div align="center">
				                             탈퇴 하시겠습니까? <br>
	                        </div>
	                        <br>
	                        <input type="hidden" name="userId" value="${ loginUser.userId }">
	                    </div>
	                    <!-- Modal footer -->
	                    <div class="modal-footer" align="center">
	                        <button type="submit" class="btn btn-danger">탈퇴하기</button>
	                    </div>
	                </form>
	            </div>
	        </div>
	    </div>
			
			
			
			
		</div> <!--div class="content" 영역 끝-->

    </div>

    <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>
		

</body>
</html>