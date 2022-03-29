<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반회원관리 상세페이지</title>
<link rel="stylesheet" href="resources/css/admin/member/memberBuyerDetail.css">
</head>
<body>
	<div class="wrap">
        <div id="menubar">
            <jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>
        </div>
        <div class="content">
            <!--  === Main ===  -->
			<div id="main-title"><h3 style="font-weight: bold;" >일반회원 상세페이지</h3></div>
			<img id="seller" src="resources/images/일반회원.png"><h5 style="font-weight: bold;" id="userName">${m.userName} 님</h5>
			<br><br>
			<div id="content1">
				<!-- 아이디 -->
				<div>
					<h6>아이디</h6>
					<span class="box">
						<input type="text" class="int" value="${m.userId}" readonly> 
					</span>
				</div>
				<!-- 이름 -->
				<div>
					<h6>이름</h6>
					<span class="box">
						<input type="text" class="int" value="${m.userName}" readonly>
					</span>
				</div>
				<!-- 이메일 -->
				<div>
					<h6>이메일</h6>
					<span class="box">
						<input type="text" class="int" value="${m.email}" readonly>
					</span>
				</div>
				<!-- 연락처 -->
				<div>
					<h6>연락처</h6>
					<span class="box">
						<input type="tel" class="int"  value="${m.phone}" readonly>
					</span>
				</div>
						       
				<!-- 주소 -->
				<div>
					<h6>주소</h6>
					<span class="box">
						<input type="text" class="int" value="${m.address}" readonly>
					</span>
				</div>
				<div>
		            <h6 class="join_title">성별</h6>
		            <span class="box">
		                <input type="text" class="int" value="${m.gender}" readonly>
		          	</span>
		        </div>
				
				<!-- BIRTH -->
				<div>
		        	<h6 class="join_title">생일</h6>
				    	<span class="box">
		           		<input type="text" class="int" name="birth" value="${m.birth}" pattern="yyyy-MM-dd" >
		        	</span>
		       	</div>
		       	
		       	<div>
					<h6>포인트</h6>
					<span class="box">
						<input type="text" class="int" value="${m.point}" readonly>
					</span>
				</div>
				 <!-- BTN -->
		        <div class="btn_area" align="center"> 
		           <button type="button" id="btnDelete" data-toggle="modal" data-target="#deleteForm">탈퇴</button>
		    	</div>
			</div><!-- content1 영역 끝 -->
        </div>
	</div>
	<!-- 탈퇴 모달 창 -->
		<div class="modal fade" id="deleteForm">
	        <div class="modal-dialog modal-sm">
	            <div class="modal-content">
	
	                <!-- Modal Header -->
	                <div class="modal-header">
	                    <h4 class="modal-title">회원탈퇴</h4>
	                    <button type="button" class="close" data-dismiss="modal">&times;</button>
	                </div>
	
	                <form action="buyerDelete.ad" method="post">
	                    <!-- Modal body -->
	                    <div class="modal-body">
	                        <div align="center">
				                             탈퇴 시키겠습니까? <br>
	                        </div>
	                        <br>
	                        <input type="hidden" name="userId" value="${ m.userId }">
	                    </div>
	                    <!-- Modal footer -->
	                    <div class="modal-footer" align="center">
	                        <button type="submit" class="btn btn-danger">예</button>
	                    </div>
	                </form>
	            </div>
	        </div>
	    </div>
</body>
</html>