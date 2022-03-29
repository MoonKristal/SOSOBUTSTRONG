<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문하기</title>
<!-- style -->
<link rel="stylesheet" href="resources/css/user/order/orderForm.css">
</head>
<body>

	<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>

	<br><br>
	
	<div class="order_outer">
		
		<h1 align="center" style="margin: 30px; font-weight: bold; color: rgb(255, 163, 63);">주문하기<img class="od_img" src="https://cdn-icons-png.flaticon.com/512/4624/4624037.png"></h1>
		<br><br>

		<h4>주문상품</h4>
		<hr class="line">


		<div class="orderList">
			<table id="od" >		
			
			
			<c:forEach var="c" items="${list}">					
				<tr>
					<td class="firstTd"><img src="${c.changeName}"></td>
					<td style="text-align: left; padding: 10px;">
						[<b>${c.sellerName}</b>] <label style="font-size: 15px; margin-bottom: 0;">${c.productName}</label>						
						<label style="font-size: 13px; margin-bottom: 0;" id="topping">${c.option }</label>
					</td>
					<td width="70">${c.quantity}</td>
					<td width="70">${c.price }</td>
				</tr>	

						
			</c:forEach>			
			</table>
		</div>
		
		<br><br><br>

		<h4>주문자 정보</h4>
		<hr class="line">

		<div class="orderList odLine">
			<table id="od_person">
				<tr>
					<th>이름</th>
					<td height="40" >${ loginUser.userName }</td>
				</tr>
				<tr>
					<th>휴대폰</th>
					<td height="40">${ loginUser.phone }</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td height="40">${ loginUser.email }</td>
				</tr>				
			</table>
		</div>

		<br><br><br>

		
		
		
			<h4 style="display: inline;">배송 정보</h4> &nbsp;<button type="button" id="changeAdd" class="btn btn-sm" style="background:rgb(255, 163, 63); color: white; font-weight: bold;">배송지 변경</button>
			<hr class="line">

			
			<div class="orderList odLine">
				<table id="dv">
					<tr>
						<th>이름</th>
						<td id="dvName" height="42">${loginUser.userName}</td>
					</tr>
					<tr>
						<th>배송주소</th>
						<td id="dvAddress" height="42">${loginUser.address}</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td id="dvPhone" height="42">${loginUser.phone}</td>
					</tr>
				</table>
			</div>


			<div class="orderList odLine">
				<table>
					<tr>
						<th>배송요청사항</th>
						<td height="42"> 
							<input list="delMsg" id="deliveryMessage" name="deliveryMessage" class="form-control form-control-sm" style="width: 500px;">
							<datalist id="delMsg">
								<option>부재시 경비실에 맡겨 주세요.</option>
								<option>배송 전에 미리 연락 바랍니다.</option>
								<option>택배함에 두고 가주세요.</option>
								<option>현관문 앞에 두고 가주세요.</option>
								<option >직접입력</option>								
							</datalist>
						
						</td>
					</tr>	
				</table>
			</div>


			<br><br><br>

			<h4>적립금 사용</h4>
			<hr class="line">

			<div class="orderList odLine">
				<table id="pointTd">
					<tr>
						<th>보유</th>
						<td height="42"><input type="text" class="form-control form-control-sm" style="width: 200px; display: inline;" readonly value="${loginUser.point}" id="userPoint"></td>
					</tr>
					<tr>
						<th>사용</th>
						<td height="42">
							<input type="number" step="500" min="0" max="${loginUser.point}" placeholder="0" id="usePoint" style="color: rgb(255, 163, 63); width: 200px; display: inline;" class="form-control form-control-sm"> &nbsp; 
							<c:if test="${loginUser.point eq 0}"> <!-- 회원의 보유포인트 0일시 전액사용 버튼 비활성화-->
								<button type="button" class="btn btn-sm point" style="background: #ccc;; color: white;" disabled><b>전액사용</b></button> &nbsp;&nbsp; <label style="font-size: 13px;">500이상부터 사용 가능</label>
							</c:if>
							<c:if test="${loginUser.point ne 0}">
								<button type="button" class="btn btn-sm point" style="background:rgb(182, 238, 86); color: white;" ><b>전액사용</b></button> &nbsp;&nbsp; <label style="font-size: 13px;">500이상부터 사용 가능</label>
							</c:if>
						</td>
					</tr>								
				</table>
			</div>

			
			<br><br><br>
	
				<h4>결제 정보</h4>
				<hr class="line">
	
				<!-- 장바구니안의 모든 price 반복문으로 더하기 -->
				<c:set var="sum" value="0"/>				
				<c:forEach var="test" items="${list}">				
				 	<c:set var="sum" value="${sum + test.price * test.quantity}"/>					
				</c:forEach>
				
	
				<div class="orderList odLine">
					<table id="payTd">
						<tr>
							<th>주문금액</th>
							<td height="42"><c:out value="${sum}"/></td>
						</tr>					
						<tr>
							<th>적립금 사용</th>
							<td height="42"><input type="text" readonly name="" class="usePoint" style="color: rgb(255, 163, 63); border-style: none;" value="0"></td>
						</tr>
						<tr>
							<th>총결제금액</th>
							<td id="finalPay" style="color:red; font-size:18px; font-weight: bold;" height="42" data-final="${sum}"><fmt:formatNumber value="${sum}"/>원</td>
						</tr>	
						<tr>
							<th>결제수단</th>
							<td height="42">
								<input type="radio" id="card" name="payMethod" value="html5_inicis" data-how="카드결제" data-pay="card">  <label for="card">신용/체크 카드</label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;								
								<input type="radio" id="phonePay" name="payMethod" value="danal_tpay" data-how="휴대폰결제" data-pay="phone">  <label for="phonePay">휴대폰 소액결제</label>
							</td>
						</tr>									
					</table>
				</div>				
				
				<br><br><br>

				<input type="button" value="결제하기" id="btn-pay" disabled>
			

		</div>

		

		<script>
			$(function(){
				
				var $userPoint = $('#userPoint').val();	//사용자 보유포인트		
				var $usePay = "${sum}" - $('#usePoint').val(); // 주문금액 - 가용포인트
				var $howPay = "${sum}" // 주문금액
				
				$('.point').click(function(){	//전액사용 클릭시		
				
					// 주문금액보다 포인트 사용이 많게되는 마이너스방지하기
					if(($howPay - $('#userPoint').val()) <= 0){							
						$(this).attr('disabled','true').css('background', '#ccc'); //전액사용 버튼 비활성화
						$('#usePoint').val($('#payTd').find('td').eq(0).text()).attr('max', $('#payTd').find('td').eq(0).text()); // 사용포인트에 주문금액 찍힘
						$('.usePoint').val($('#usePoint').val()); // 결제 정보에 사용 적립금 찍힘
						var $result = ($usePay).toLocaleString('ko-KR');	
						$('#finalPay').text( $result + '원');	// 마무리 총결제금액에 다시 '원'문자열과 합쳐서 결과 반환	
					   	$('#finalPay').attr('data-final', '${sum}' - Number($('.usePoint').val()));

					}
					else{
					   $('#usePoint').val($userPoint); //전액출력
					   $(this).attr('disabled','true').css('background', '#ccc'); //전액사용 버튼 비활성화
					   $('.usePoint').val($('#usePoint').val()); // 결제 정보에 사용 적립금 찍힘	
					   var $result = ($usePay).toLocaleString('ko-KR');					   
					   $('#finalPay').text(('${sum}' - $('#usePoint').val()).toLocaleString('ko-KR') + '원');	// 마무리 총결제금액에 다시 '원'문자열과 합쳐서 결과 반환	
					   $('#finalPay').attr('data-final', '${sum}' - Number($('.usePoint').val()));	
						
					}

				})	

				
				$('#usePoint').change(function(){ //포인트 사용금액에 변동 있을시
					$('.point').removeAttr('disabled').css('background', 'rgb(182, 238, 86)'); // 전액사용 버튼 활성화

					if($('#usePoint').val() >= 500){
						$('.usePoint').val($('#usePoint').val()); // 결제 정보 적립금액에 출력	

						if(($howPay - $('#userPoint').val()) >= 0){
							$('#finalPay').text(('${sum}' - $('#usePoint').val()).toLocaleString('ko-KR') + '원');
							$('#finalPay').attr('data-final', '${sum}' - Number($('.usePoint').val()));
						}			
						
					}
					else{
						alert('500이상부터 사용가능합니다.');
						$('.point').attr('disabled','true').css('background', '#ccc'); //전액사용 버튼 비활성화
						$(this).val(0); //적립금사용 입력 다시 0으로
						$('.usePoint').val(0); // 결제정보 적립금사용 역시 다시 0으로
						$('#finalPay').text('<fmt:formatNumber value="${sum}"/>' + '원'); // 주문금액 그대로
					}

				})
				

				// 배송지변경 팝업창
				$('#changeAdd').click(function(){
					var windowObj = window.open('address.od','배송지 변경','width=508,height=580,location=no,status=no,scrollbars=yes');
				})



				$('input[name=payMethod]').change(function(){
					$('#btn-pay').removeAttr('disabled');
					
				})


				// 판매자별로 각각 다른 상품들 반복문으로 각각 주문객체로 만들어서 배열에 담아 객체배열 만들기
				var $orderNo = new Date().getTime(); // Date 타입의 시간을 밀리초로 환산해 주문번호로 만든다.
				var arr = new Array();	 // 판매자별로 주문객체를 담기위한 배열 선언						
				<c:forEach var="item" items="${list}">				
						var order = new Object();
						order.seller = "${item.seller}";
						order.orderItem = "${item.option}";
						order.orderPrice = "${item.price}";
						order.quantity = "${item.quantity}";
						order.sellerName = "${item.sellerName}";
						order.productName = "${item.productName}";
						order.orderer = "${loginUser.userNo}";	
						order.orderNo = $orderNo;

						arr.push(order);
				</c:forEach>					
				
				/* 주문하기 연습코드
				$('#btn-pay').click(function(){						
					// 공통배송정보데이터 객체배열에 마저 추가
					for(var i in arr){						
						arr[i].usePoint = $('.usePoint').val(),
						arr[i].payMethod = $("input[name=payMethod]:checked").attr('data-how'),
						arr[i].deliveryName = $('#dvName').text(),
						arr[i].deliveryAddress = $('#dvAddress').text(),
						arr[i].deilveryPhone = $('#dvPhone').text(),
						arr[i].deliveryMessage = $('#deliveryMessage').val()
						
					}				
									
					console.log(arr);
									// jQuery로 HTTP 요청
									$.ajax({
											url: "insertOrder.od", 
											method: "POST",	
											traditional: true, 	//배열 자바로 넘기기								
											data: {								
												data: JSON.stringify(arr) // 자바스크립트 배열 JSON문자열화 시키기
											},											
											success:function(result){
												if(result == 'success'){	// 결제를 성공했다면 주문성공페이지에 넘어가기위한 정보 쿼리로 담기
													var query = {
														totalPay : $('#finalPay').attr('data-final'), //총결제금액
														price : $howPay, //주문금액
														point : $('.usePoint').val(), 
														name : $('#dvName').text(),
														address : $('#dvAddress').text(),
														message : $('#deliveryMessage').val()
													}
													var qr = $.param(query); //쿼리스트링 만들어주는 메소드													
	
													location.href='orderForm.od"; // 결제 주문하기 페이지로 다시 돌아감
												}
											}		
											,error: function(){
												alert("결제 실패");
											}		
									})		
				})
				*/	
				
				
				
				// 결제 API
				$('#btn-pay').click(function(){
						
						var IMP = window.IMP; // 생략가능
						IMP.init('imp94695267'); 
						// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
						// ''안에 띄어쓰기 없이 가맹점 식별코드를 붙여넣어주세요. 안그러면 결제창이 안뜹니다.
						IMP.request_pay({
							pg: $("input[name=payMethod]:checked").val(),
							pay_method: $("input[name=payMethod]:checked").attr('data-pay'),
							merchant_uid: $orderNo,
							
							name: 'We Make Salad 결제',
							// 결제창에서 보여질 이름
							// name: '주문명 : ${auction.a_title}',
							// 위와같이 model에 담은 정보를 넣어 쓸수도 있습니다.
							amount: $('#finalPay').attr('data-final'),
							// amount: ${bid.b_bid},
							// 가격 
							buyer_name: '${loginUser.userName}',
							buyer_email: '${loginUser.email}'
							// 구매자 이름, 구매자 정보도 model값으로 바꿀 수 있습니다.
							// 구매자 정보에 여러가지도 있으므로, 자세한 내용은 맨 위 링크를 참고해주세요.							
							}, function (rsp) { //callback
					
							if (rsp.success) { //결제 성공시	
								
									// 공통배송정보데이터 객체배열에 마저 추가
									for(var i in arr){						
										arr[i].usePoint = $('.usePoint').val(),
										arr[i].payMethod = $("input[name=payMethod]:checked").attr('data-how'),
										arr[i].deliveryName = $('#dvName').text(),
										arr[i].deliveryAddress = $('#dvAddress').text(),
										arr[i].deilveryPhone = $('#dvPhone').text(),
										arr[i].deliveryMessage = $('#deliveryMessage').val()
										
									}				
													
									console.log(arr);
									// jQuery로 HTTP 요청
										$.ajax({
												url: "insertOrder.od", 
												method: "POST",	
												traditional: true, 	//배열 자바로 넘기기								
												data: {								
													data: JSON.stringify(arr) // 자바스크립트 객체배열 JSON문자열화 시키기
												},											
												success:function(result){
													if(result == 'success'){	// 결제를 성공했다면 주문성공페이지에 넘어가기위한 정보 쿼리로 담기
														var query = {
															totalPay : $('#finalPay').attr('data-final'), //총결제금액
															price : $howPay, //주문금액
															point : $('.usePoint').val(), 
															name : $('#dvName').text(),
															address : $('#dvAddress').text(),
															message : $('#deliveryMessage').val()
														}
														var qr = $.param(query); //쿼리스트링 만들어주는 메소드													
		
														location.href='paySuccess.od?' + qr;
													}
												}		
												,error: function(){
													alert("결제 실패");
												}		
										})											
					
							} else {
								var msg = '결제에 실패하였습니다.';
								msg += '에러내용 : ' + rsp.error_msg;
								//실패시 이동할 페이지
								alert(msg);
								location.href="orderForm.od"; // 결제 주문하기 페이지로 다시 돌아감
							}
						});
					})
					
					
				})
				
			
			</script>


			


	
	<br>
	<jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>	

	<br><br><br>


</body>
</html>