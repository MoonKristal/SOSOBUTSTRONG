<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 판매자 상세페이지</title>
<link rel="stylesheet" href="resources/css/admin/member/sellerListDetail.css">
</head>
<body>
 <div class="wrap">
        <div id="menubar">
            <jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>
        </div>
	    <div class="content">
            <!--  === Main ===  -->
			<div id="main-title"><h3 style="font-weight: bold;" >일반회원 상세페이지</h3></div>
			<img id="seller" src="resources/images/판매자.png"><h5 style="font-weight: bold;" id="userName">${admin.member.userName} 님</h5>
			<br><br>
			<div id="content1">
			    				<h6 style="font-weight: bold;">판매자대표 정보</h6><br>
				      			<!-- ID -->
							    <div>
								    <h6>아이디</h6>
								    <span class="box">
									    <input type="text" class="int" id="id" name="userId" value="${admin.member.userId}" readonly>
								    </span>
							    </div>
						        <!-- NAME -->
						        <div>
						            <h6>이름</h6>
						            <span class="box">
						                <input type="text" id="name" class="int" name="userName" value="${admin.member.userName}" readonly>
						            </span>
						        </div>
						        <!-- EMAIL -->
						        <div>
						        	<h6>이메일</h6>
						            <span class="box">
						                <input type="text" id="email" class="int" name="email"  value="${admin.member.email}" readonly >
						            </span>
						        </div>
						        <!-- MOBILE -->
						        <div>
						            <h6>연락처</h6>
						            <span class="box">
						                <input type="text" id="phoneNo" class="int" name="phone" value="${admin.member.phone}" readonly>
						            </span>
						        </div>
			    				<br><h6 style="font-weight: bold;">업체 정보</h6><br>
						        <!-- 상호 -->
						        <div>
						            <h6>상호</h6>
						            <span class="box">
						                <input type="text" class="int" name="sellerName" value="${admin.seller.sellerName}" readonly>
						            </span>
						        </div>
						        <!-- 사업자등록번호 -->
						        <div>
						            <h6>사업자등록번호</h6>
						            <span class="box">
						                <input type="text"class="int" name="sellerBRN" value="${admin.seller.sellerBRN}" readonly>
						            </span>
						        </div>
								<!-- 사업장소재지 -->
						        <div>
						            <h6>사업장소재지</h6>
						            <span class="box">
						                <input type="text" class="int"  value="${admin.seller.sellerLocation}" readonly>
						            </span>
						       </div>
						      
						       <!-- 업체 연락처 -->
						       <div>
						            <h6>업체연락처</h6>
						            <span class="box">
						                <input type="tel" class="int" name="sellerPhone" value="${admin.seller.sellerPhone}">
						            </span>
						       </div>
						       <!-- 업체 소개 -->
						       <div>
						            <h6>업체소개</h6>
						    	        <textarea cols="46" rows="10" name="sellerIntro" readonly>${admin.seller.sellerIntro}</textarea>
						       </div>
						       <!-- 업체 대표이미지 -->
						       <div>
						            <h6>업체 대표이미지</h6>
						            <img src="${admin.seller.sellerImagePath}">
						       </div>
						   </div> 
						   <br><br>
							<!-- BTN -->
					        <div id="btn_area" align="center"> 
					           <button type="button" id="btnDelete" data-toggle="modal" data-target="#deleteForm">탈퇴</button>
					    	</div>
  			</div><!-- content1 영역 끝 -->
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
	
	                <form action="memberDelete.ad" method="post">
	                    <!-- Modal body -->
	                    <div class="modal-body">
	                        <div align="center">
				                             탈퇴 시키겠습니까? <br>
	                        </div>
	                        <br>
	                        <input type="hidden" name="userId" value="${admin.member.userId}">
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