<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송지 변경</title>
<!-- ajax, 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- 돋보기, 아이콘 CDN-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- 카카오 주소 api CDN-->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- style -->
<link rel="stylesheet" href="resources/css/user/order/addressForm.css">

</head>
<body>

	<div class="address_outer">
		<h2 align="center" style="margin: 10px;">배송지 변경</h2>			
		<hr>
		
		<div id="wrap" style="display:none;border:1px solid;width:460px;height:300px;margin:5px 0;position:absolute;z-index: 1;">
			<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:2" onclick="foldDaumPostcode()" alt="접기 버튼">
		</div>	
					
			<table >
				<tr class="line">
					<th>받는 사람</th>
					<td height="40">
						<input type="text" id="name" required name="receiverName">	
					</td>
				</tr>
				<tr class="line" onclick="sample3_execDaumPostcode();">
					<th rowspan="2">주소</th>	
					<td height="45" class="search" id="sample3_Address" name="receiverAdd">											
					</td>										
					<i class="fa-solid fa-magnifying-glass fa-lg"></i>						
				</tr>
				<tr>
					<td height="40"><input type="text" placeholder="상세주소" id="sample3_detailAddress" name="receiverDeAdd"></td>
				</tr>				
				<tr class="line">
					<th>휴대폰</th>
					<td height="40"><input type="tel" id="phone" name="receiverPhone" required maxlength="13" placeholder="- 포함, 숫자만 입력해주세요"></td>
				</tr>
			</table>
			<br><br>
			<input type="button" value="저장" id="btn-dv" onclick="save();">		
	</div>

	<!-- 자식창에서 부모창으로 값을 넘기기위한 스크립트-->
	<script>
		function save(){	

			if($('#name').val() != false){	//이름이 공백이지 않을때				
				
				if($('#sample3_Address').text() != false){ //주소가 공백이지 않을때

					if($('#phone').val() != false){ //핸드폰이 공백이지 않을때
						
						// 이름 넘기기
						window.opener.document.getElementById('dvName').innerText = $('#name').val();
						// 부모에 있는 요소 											자식요소

						// 주소값 넘기기
						window.opener.document.getElementById('dvAddress').innerText = $('#sample3_Address').text() + ' ' + $('#sample3_detailAddress').val();
						// 휴대폰 넘기기
						window.opener.document.getElementById('dvPhone').innerText = $('#phone').val();						
						
						// 창 닫기
						self.close();						
					}
					else{
						alert("휴대폰이 입력되지 않았습니다.");
						$('#phone').focus();						
					}
				
				}
				else{
					alert("주소가 입력되지 않았습니다.");
					$('#sample3_Address').focus();					
				}

			}
			else{
				alert("이름이 입력되지 않았습니다.");
				$('#name').focus();				
			}		
		}
	</script>

	<!-- 휴대폰값 오직 숫자와 하이픈'-'만 입력받을 수 있도록하는 스크립트-->
	<script>
		$('#phone').keyup(function(e){
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^0-9-]/gi,'')); // 0-9와 - 를 제외한 모든 문자 '' 공백으로 대체
			
			// '^'이 [] 밖에서는 첫문자를 뜻하지만 [] 안에서는 제외를 뜻한다.
			// g : 전역에서 검색
			// i : 대소문자 구분 안함
 		});

	</script>
	


	<!-- 카카오 주소 api -->
	<script>
		// 우편번호 찾기 찾기 화면을 넣을 element
		var element_wrap = document.getElementById('wrap');
	
		function foldDaumPostcode() {
			// iframe을 넣은 element를 안보이게 한다.
			element_wrap.style.display = 'none';
		}
	
		function sample3_execDaumPostcode() {
			// 현재 scroll 위치를 저장해놓는다.
			var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
			new daum.Postcode({
				oncomplete: function(data) {
					// 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
					// 각 주소의 노출 규칙에 따라 주소를 조합한다.
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					var addr = ''; // 주소 변수
					var extraAddr = ''; // 참고항목 변수
	
					//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
					if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
						addr = data.roadAddress;
					} else { // 사용자가 지번 주소를 선택했을 경우(J)
						addr = data.jibunAddress;
					}
	
					// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
					if(data.userSelectedType === 'R'){
						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
							extraAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if(data.buildingName !== '' && data.apartment === 'Y'){
							extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
						}
						// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if(extraAddr !== ''){
							extraAddr = ', (' + extraAddr + ')';
						}
						// 조합된 참고항목을 해당 필드에 넣는다.
						$('#sample3_Address').val('');
					
					} else {
						$('#sample3_Address').val('');
					}
	
					// 우편번호와 주소 정보를 해당 필드에 넣는다.					
					$('#sample3_Address').html('[' + data.zonecode + '] <br>' + addr + extraAddr); // 우편번호, 주소, 참조주소 합쳐서 컨텐츠로 넣기
					// 커서를 상세주소 필드로 이동한다.
					document.getElementById("sample3_detailAddress").focus();
	
					// iframe을 넣은 element를 안보이게 한다.
					// (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
					element_wrap.style.display = 'none';
	
					// 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
					document.body.scrollTop = currentScroll;
				},
				// 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
				onresize : function(size) {
					element_wrap.style.height = size.height+'px';
				},
				width : '100%',
				height : '100%'
			}).embed(element_wrap);
	
			// iframe을 넣은 element를 보이게 한다.
			element_wrap.style.display = 'block';
		}
	</script>

	
</body>
</html>