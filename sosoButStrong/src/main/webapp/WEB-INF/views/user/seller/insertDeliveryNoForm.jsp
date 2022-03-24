<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>운송장번호 등록</title>
<!-- ajax, 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- style -->
<link rel="stylesheet" href="resources/css/user/seller/insertDeliveryNoForm.css">
</head>
<body>
	
	<div class="insert_outer">
		<h2 align="center" style="margin: 20px;">운송장번호 등록</h2>			
		<hr style="margin-bottom: 10px;">	
		
		<div id="inner">			
			<input type="hidden" id="seller" >
			<input type="hidden" id="orderNo">
			<input type="hidden" id="status" value="배송중">
			<input align="center" type="text" class="deliveryNo" required maxlength="12" placeholder="'-'를 제외한 숫자만 입력해주세요." required> <br><br><br>
			<input align="center" type="button" value="등록하기" id="btn_insert">			
		</div>		
	</div>

	<script>
		$(function(){
			// 운송장번도 등록 클릭할때
			$('#btn_insert').click(function(){	
				console.log(opener.$('#orderNo').text());
				$('#seller').val(opener.$('#pSeller').val());	// 부모창에서 판매자 고유번호 자식창에 대입
				$('#orderNo').val(opener.$('.btn_insertNo').attr('data-orderNo'));	// 부모창에서 주문번호 자식창에 대입

				$.ajax({
					url: "updateStatus.od",
					data: {
						seller: $('#seller').val(),
						orderNo: $('#orderNo').val(),
						status: $('#status').val(),
						deliveryNo: $('.deliveryNo').val()
					},
					success: function(result){
						console.log(result)
						if(result == 'success'){
							// 부모창에서 알럿메세지 가지고 다시 리로딩
							opener.parent.location = "searchManage.se?cpage=${currentPage}&keyword=${keyword}&year=${year}&month=${month}";
							self.close(); // 운송장번호등록창 닫기
							opener.parent.alert('운송장번호가 등록되었습니다.');
						}
					},
					error: function(){
						alert('운송장번호 등록 실패');
						self.close(); // 운송장번호등록창 닫기
					}
				})					
			})


			// 운송장번호등록시 숫자만 입력도록
			$('.deliveryNo').keyup(function(e){
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^0-9]/gi,'')); // 0-9를 제외한 모든 문자 '' 공백으로 대체
				
				// '^'이 [] 밖에서는 첫문자를 뜻하지만 [] 안에서는 제외를 뜻한다.
				// g : 전역에서 검색
				// i : 대소문자 구분 안함
 			});
		})

	</script>

</body>
</html>