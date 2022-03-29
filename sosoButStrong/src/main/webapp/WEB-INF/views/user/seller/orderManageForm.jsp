<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문/배송 관리</title>
<!-- css -->
<link rel="stylesheet" href="resources/css/user/seller/orderManageForm.css">
<!-- 돋보기, 아이콘 CDN-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
	
	<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>
	
	<div class="list_outer">

		<jsp:include page="/WEB-INF/views/user/seller/sellerMyMenu.jsp"/>

		<div class="content">
			<br><br>
			<h2 style="font-weight: bold;">주문/배송관리</h1>

			<div align="right">
				<!-- 검색어 키워드로 주문목록 검색하기 -->
				<form action="searchManage.se" name="searchForm" id="searchForm">
					<input type="hidden" name="cpage" value="1">
					<button type="submit" style="color: #ccc; background: none; border-style:none;"><i class="fa-solid fa-magnifying-glass fa-lg"></i></button>
					<input type="search" name="keyword" class="form-control form-control-sm keyword" style="width: 300px; margin-bottom: 10px; display: inline-block;" placeholder="회원 아이디로 검색" value="${keyword}">
					<br>	
				</form>
				<form action="searchManage.se" id="statusForm">					
					<select name="status" id="selected" class="form-control form-control-sm" style="width: 200px; margin-bottom: 10px;">
						<option disabled selected>주문상태 선택</option>
						<option value="결제취소">결제취소</option>
						<option value="결제완료">결제완료</option>
						<option value="상품준비중">상품준비중</option>
						<option value="배송중">배송중</option>
						<option value="배송완료">배송완료</option>
					</select>
				</form>
			
				<a href="searchManage.se?month=-6"><span class="badge badge-pill badge-success">최근 6개월</span></a>
				<a href="searchManage.se?cpage=1&year=2021"><span class="badge badge-pill badge-success">2021</span></a>
							
			</div>

			<br>

			<c:choose>
				<c:when test="${empty list}">					
					<table class="nothing" border="1">
						<tr>
							<th>주문번호</th>
							<th>주문날짜</th>
							<th>주문자</th>
							<th>상품</th>
							<th>수량</th>
							<th>결제금액</th>
							<th>상태</th>
							<th>운송장번호</th>
						</tr>
						<tr>
							<td colspan="8" height="230" align="center" style="font-size: 17px; font-weight: bold;">주문 내역이 없습니다.</td>
						</tr>
					</table>				
				</c:when>
				<c:otherwise>
					<table id="odManage" border="1">
						<thead>
							<tr>
								<input id="pSeller" type="hidden" value="${loginUser.userNo}"><!--${loginUser.userNo}-->
								<th>주문번호</th>
								<th>주문날짜</th>
								<th>주문자</th>
								<th>상품</th>
								<th>수량</th>
								<th>결제금액</th>
								<th>상태</th>
								<th>운송장번호</th>
							</tr>
						</thead>

						<tbody>
						<c:forEach var="o" items="${list}">													
							<tr>
								<td class="oNo">${o.orderNo}</td>
								<td>${o.orderDate}</td>
								<td>${o.orderer}</td>
								<td>${o.productName}</td>
								<td>${o.quantity}</td>
								<td><fmt:formatNumber value="${o.orderPrice * o.quantity}"/>원</td>
								<td class="noClick">
									<c:choose>
										<c:when test="${o.status eq '결제취소'}">
											<span style="color: red;">${o.status}</span>
										</c:when>
										<c:when test="${o.status eq '결제완료'}">
											<input class="btn_confirm" type="button" value="확인" style="background: red; color: white;" data-orderNo="${o.orderNo}" data-status="상품준비중">
										</c:when>
										<c:when test="${o.status eq '배송완료'}">
											<span style="color: blue;">${o.status}</span>
										</c:when>
										<c:otherwise>
											${o.status}
										</c:otherwise>
									</c:choose>
									
								</td>
								<td class="noClick">
									<c:choose>
										<c:when test="${empty o.deliveryNo && o.status eq '상품준비중'}">
											<input type="button" class="btn_insertNo" value="송장번호 등록" data-orderNo="${o.orderNo}" style="background:rgb(182, 238, 86);">
										</c:when>
										<c:when test="${o.status eq '배송중' || o.status eq '배송완료'}">
											<a href="#" class="deliveryNo">${o.deliveryNo}</a> 
											<c:if test="${o.status ne '배송완료'}">
												<input class="complete" type="button" value="배송완료" style="color:white; background:rgb(255, 163, 63);" data-orderNo="${o.orderNo}" >
											</c:if>
										</c:when>										
										<c:otherwise>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</c:otherwise>
			</c:choose>

			<br><br>

			<!-- 페이징 바 -->
			<ul class="pagination justify-content-center">      

				<c:choose>                                      
					<c:when test="${ pi.currentPage eq 1 or empty list}">                            
						<li class="page-item disabled"><a class="page-link" href="#">이전</a></li>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${not empty keyword}">
								<li class="page-item"><a class="page-link" href="searchManage.se?cpage=${pi.currentPage - 1}&keyword=${keyword}">이전</a></li>
							</c:when>
							<c:when test="${ not empty year}">
								<li class="page-item"><a class="page-link" href="searchManage.se?cpage=${pi.currentPage - 1}&year=${year}">이전</a></li>
							</c:when>
							<c:when test="${ not empty month}">
								<li class="page-item"><a class="page-link" href="searchManage.se?cpage=${pi.currentPage - 1}&month=${month}">이전</a></li>
							</c:when>
							<c:when test="${ not empty status}">
								<li class="page-item"><a class="page-link" href="searchManage.se?cpage=${pi.currentPage - 1}&status=${status}">이전</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" href="orderManage.se?cpage=${pi.currentPage - 1}">이전</a></li>
							</c:otherwise>
						</c:choose>
					</c:otherwise>

				</c:choose>

				<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">   
					<c:if test="${p eq pi.currentPage}">
						<li class="page-item disabled"><a class="page-link" href="orderManage.se?cpage=${p}">${p}</a></li> 
					</c:if>
					<c:if test="${p ne pi.currentPage}">
						<c:choose>
							<c:when test="${ not empty keyword}">
								<li class="page-item"><a class="page-link" href="searchManage.se?cpage=${p}&keyword=${keyword}">${p}</a></li>
							</c:when>
							<c:when test="${ not empty year}">
								<li class="page-item"><a class="page-link" href="searchManage.se?cpage=${p}&year=${year}">${p}</a></li>
							</c:when>
							<c:when test="${ not empty month}">
								<li class="page-item"><a class="page-link" href="searchManage.se?cpage=${p}&month=${month}">${p}</a></li>
							</c:when>
							<c:when test="${ not empty status}">
								<li class="page-item"><a class="page-link" href="searchManage.se?cpage=${p}&status=${status}">${p}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" href="orderManage.se?cpage=${p}">${p}</a></li> 
							</c:otherwise>    
						</c:choose>
					</c:if>
				</c:forEach>

				<c:choose>                                      
					<c:when test="${pi.currentPage eq pi.maxPage or empty list}">
						<li class="page-item disabled"><a class="page-link" href="#">다음</a></li>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${not empty keyword}">
								<li class="page-item"><a class="page-link" href="searchManage.se?cpage=${pi.currentPage + 1}&keyword=${keyword}">다음</a></li>
							</c:when>
							<c:when test="${not empty year}">
								<li class="page-item"><a class="page-link" href="searchManage.se?cpage=${pi.currentPage + 1}&year=${year}">다음</a></li>
							</c:when>
							<c:when test="${ not empty month}">
								<li class="page-item"><a class="page-link" href="searchManage.se?cpage=${pi.currentPage + 1}&month=${month}">다음</a></li>
							</c:when>
							<c:when test="${ not empty status}">
								<li class="page-item"><a class="page-link" href="searchManage.se?cpage=${pi.currentPage + 1}&status=${status}">다음</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" href="orderManage.se?cpage=${pi.currentPage + 1}">다음</a></li>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</ul> 

			
		</div>			
	</div>	
	 

	<jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>	

	<br><br><br>


	<!-- 배송조회 form-->
	<form id="select_delivery" method="post" action="http://info.sweettracker.co.kr/tracking/4" target="w" onsubmit="goSubmit();">
		<div class="form-group">
		  <label for="t_key">API key</label>
		  <input type="text" class="form-control" id="t_key" name="t_key" value="wBg7Ku3cHqAJyfh4vMKthQ">
		</div>
		<div class="form-group">
		  <label for="t_code">택배사 코드</label>
		  <input type="text" class="form-control" name="t_code" id="t_code" value="04">
		</div>
		<div class="form-group">
		  <label for="t_invoice">운송장 번호</label>
		  <input type="text" class="form-control" name="t_invoice" id="t_invoice" >
		</div>
		<button type="submit" class="btn btn-default">조회하기</button>
	</form>


	<script>
		 // 배송조회시 실행될 작은 사이즈의 창
		 function goSubmit(){
            var win = window.open("", "w", "width=500,height=670");   
        }   

		$(function(){
			$('#select_delivery').css('display', 'none'); // 배송조회 폼 눈에 안보임

			$('.deliveryNo').click(function(){ //배송조회 버튼 click시 
                $('#t_invoice').val($(this).text()); // 각 고유 운송장번호 입력됨
                $('#select_delivery').submit(); // 배송조회 form태그 실행

            }) 

			// 현재 해당 메뉴바 CSS효과주기 
			$('#orderManage').addClass('current');   
			

			 // 키워드 검색 이벤트 일어날때
			 $('#searchForm').submit(function(){
                if($('.keyword').val() == false){
                    alert('회원 아이디를 입력해 주세요.');
                    return false;
                }
                return true;
            })


			// 주문확인 버튼 상태 업데이트
			$('.btn_confirm').on('click', function(e){
				if(confirm('주문을 확인하시겠습니까?')){
					$.ajax({
						url: "updateStatus.od",
						data: {
							orderNo: $(this).attr('data-orderNo'),
							status: $(this).attr('data-status'),
							seller: $('#pSeller').val()							
						},
						success: function(result){
							if(result == 'success')
							location.href="searchManage.se?alertMsg=주문이 확인되었습니다.&cpage=${pi.currentPage}&keyword=${keyword}&year=${year}&month=${month}&status=${status}";
						},
						error: function(){
							console.log('주문확인 서버 에러');
						}
					})
				}	
			})


			// 배송완료버튼 클릭시 
			$('.complete').on('click', function(){
				if(confirm('배송을 완료하시겠습니까?')){
					$.ajax({
						url: "updateStatus.od",
						data: {
							orderNo: $(this).attr('data-orderNo'),
							status: $(this).val(),
							seller: $('#pSeller').val()							
						},
						success: function(result){
							if(result == 'success'){
								location.href="searchManage.se?alertMsg=배송이 완료되었습니다.&cpage=${pi.currentPage}&keyword=${keyword}&year=${year}&month=${month}&status=${status}";							
							}
						},
						error: function(){
							console.log('주문확인 서버 에러');
						}					
					})
				}
			})



			// 송장번호 등록 팝업창
			$('.btn_insertNo').on('click', function(){
				window.open('insertDeliveryNoFrom.se?cpage=${pi.currentPage}&keyword=${keyword}&year=${year}&month=${month}&status=${status}',
										'운송장번호 등록','width=520,height=350,location=no,status=no,scrollbars=yes');				
			})

			// 주문상세보기 상세페이지
			$('#odManage>tbody td').not('.noClick').on('click', function(){							
				window.open('orderDetailManage.se?orderNo=' + $(this).siblings('.oNo').text(), '주문상세보기', 'width=620,height=790,location=no,status=no,scrollbars=yes');			
			})

			// 주문상태 카테고리 검색필터
			$('#selected').change(function(){
				$('#statusForm').submit();				
			})

			// 주문상태 카테고리 선택되어 있도록
			$('#statusForm option[value=${status}]').attr('selected', true);

		})

	</script>

</body>
</html>