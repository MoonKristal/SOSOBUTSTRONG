<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자 승인/거절 상세페이지</title>
<link rel="stylesheet" href="resources/css/admin/member/sellerListDetail.css">
</head>
<body>
    <div class="wrap">
        <div id="menubar">
            <jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>
        </div>
	    <div class="content">
			<h3 style="font-weight: bold;">판매자 승인/거절 상세보기&nbsp;</h3>
			<img id="seller" src="resources/images/판매자.png"><h5 style="font-weight: bold;" id="userName"></h5>
			<br><br>
			<div id="content1">
				<!-- 상호 -->
				<div>
					<h6>상호</h6>
					<span class="box">
						<input type="text" class="int" value="${s.sellerName}" readonly> 
					</span>
				</div>
				<!-- 사업자등록번호 -->
				<div>
					<h6>사업자등록번호</h6>
					<span class="box">
						<input type="text" class="int" value="${s.sellerBRN}" readonly>
					</span>
				</div>
				<!-- 사업장소재지 -->
				<div>
					<h6>사업장소재지</h6>
					<span class="box">
						<input type="text" class="int" value="${s.sellerLocation}" readonly>
					</span>
				</div>
				<!-- 사업장 지도 api -->
				<p style="margin-top:-12px"></p>
				<div id="map" style="width:100%;height:350px;"></div>
				<!-- 업체 연락처 -->
				<div>
					<h6>업체연락처</h6>
					<span class="box">
						<input type="tel" class="int"  value="${s.sellerPhone}" readonly>
					</span>
				</div>
						       
				<!-- 업체 소개 -->
				<div>
					<h6>업체소개</h6>
					<textarea cols="46" rows="10">${s.sellerIntro}</textarea>
				</div>
				<!-- 업체 대표이미지 -->
				<div>
					<h6>업체 대표이미지</h6>
					<span>
						<img src="${s.sellerImagePath}">
					</span>
				</div>
				<!-- 승인 버튼 -->		       
				<div class="btn_area"> 
					<button type="button" id="btn" data-toggle="modal" data-target="#approveForm">승인</button>
					<button type="button" id="btn" data-toggle="modal" data-target="#refuseForm">거절</button>
				</div>
			</div><!-- content1 영역 끝 -->
		</div><!-- content 영역 끝 -->   
	</div><!-- wrap 영역 끝 -->
	
<!-- 지도 api -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=548936865aa00185ca643159f049f27c&libraries=services"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  
		
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch('${s.sellerLocation}', function(result, status) {
		
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
		
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
		
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">${s.sellerName}</div>'
		        });
		        infowindow.open(map, marker);
		
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		});    
	</script>
	<!-- 판매자 이름 가져오기 -->
	<script>
		$(function(){
			$.ajax ({
				url : "sellerUserName.ajax",
				data : {
					"userNo" : ${s.userNo}
				},
				success : function(e){
					$("#userName").text("판매자  "+ e + "  님");
				},
				error : function(){
					console.log("실패");
				}
			})
		})
	<!-- 판매자 이름 가져오기 -->
	<script>
		$(function(){
			$.ajax ({
				url : "sellerUserName.ajax",
				data : {
					"userNo" : ${s.userNo}
				},
				success : function(e){
					$("#userName").text("판매자  "+ e + "  님");
				},
				error : function(){
					console.log("실패");
				}
			})
		})
	</script>
	
	<!-- 모달 창 -->
		<div class="modal fade" id="approveForm">
	        <div class="modal-dialog modal-sm">
	            <div class="modal-content">
	
	                <!-- Modal Header -->
	                <div class="modal-header">
	                    <h4 class="modal-title">판매자 승인하기</h4>
	                    <button type="button" class="close" data-dismiss="modal">&times;</button>
	                </div>
	
	                <form action="approveSeller.ad" method="post">
	                    <!-- Modal body -->
	                    <div class="modal-body">
	                        <div align="center">
				                             승인하시겠습니까? <br>
	                        </div>
	                        <br>
	                        <input type="hidden" name="userNo" value="${ s.userNo }">
	                    </div>
	                    <!-- Modal footer -->
	                    <div class="modal-footer" align="center">
	                        <button type="submit" class="btn btn-danger">예</button>
	                    </div>
	                </form>
	            </div>
	        </div>
	    </div>	
	    <!-- 모달 창 -->
		<div class="modal fade" id="refuseForm">
	        <div class="modal-dialog modal-sm">
	            <div class="modal-content">
	
	                <!-- Modal Header -->
	                <div class="modal-header">
	                    <h4 class="modal-title">판매자 승인 취소</h4>
	                    <button type="button" class="close" data-dismiss="modal">&times;</button>
	                </div>
	
	                <form action="refuseSeller.ad" method="post">
	                    <!-- Modal body -->
	                    <div class="modal-body">
	                        <div align="center">
				                             판매자 승인을 철회하시겠습니까? <br>
	                        </div>
	                        <br>
	                        <input type="hidden" name="userNo" value="${ s.userNo }">
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