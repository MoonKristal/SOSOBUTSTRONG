<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매자 1:1문의 글 등록</title>
<link rel="stylesheet" href="resources/css/user/question/buyerQuestionEnrollForm.css">
</head>
<body>
	<!--2022.3.14(월) 9h30 파일 생성
		2022.3.16(수) 10h15 작업 시작-->
	
	<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>

	<div class="outer"> <!--header 아래 모든 부분 감싸는 div-->
        
        <!--구매자 마이페이지 좌측 메뉴바-->
        <jsp:include page="/WEB-INF/views/user/common/buyerMyPageMenuBar.jsp"/>

		<div class="content">
			<h2>1:1문의 글 남기기</h2>
			<br>

			<p>* 표시는 필수 입력 사항입니다.</p>

			<form id="enrollForm" action="buyerInsert.qu" method="post" enctype="multipart/form-data">
				<input type="hidden" name="questionWriter" value="${ loginUser.userNo }">

				<table class="table table-bordered" align="center">
					<!--(tr>(th+td))*7-->
					<tr>
						<th class="label">주문번호</th>
						<td>
							<input type="text" name="orderNo" placeholder="관련 주문번호가 있는 경우 선택해 주세요" size="40" readonly>
							<button type="button" data-toggle="modal" data-target="#selectOrder" id="buyerOrderList">주문 조회</button>
						</td>
					</tr>
					<tr>
						<th class="label">판매자*</th>
						<td>
							<input type="hidden" name="questionSeller">
							<input type="text" name="questionSellerName" placeholder="판매자 이름(전체 또는 일부)을 입력해 주세요" size="40" required>
							<div id="autoComplete"></div>
						</td>
					</tr>
					<tr>
						<th class="label">제목*</th>
						<td>
							<select name="category" id="" required>
								<option selected disabled>선택해 주세요</option> <!--해당 항목은 콤보박스 리스트에 보여지지만, 선택은 할 수 없게 됨-->
								<option>배송 지연</option>
								<option>주문/결제 문의</option>
								<option>상품 정보 문의</option>
								<option>기타 문의</option>
							</select>
							<input type="text" name="questionTitle" size="70" required>
						</td>
					</tr>
					<tr>
						<th class="label">이메일</th>
						<td>
							<input type="email" value="${ loginUser.email }" required readonly> <!--로그인한 구매자의 이메일 주소 띄워두기-->
							<input type="checkbox" name="answerMode" value="email" id="answerEmail"> <label for="answerEmail">답변 수신을 이메일로 받겠습니다.</label>
						</td>
					</tr>
					<tr>
						<th class="label">휴대폰</th>
						<td>
							<input type="text" value="${loginUser.phone }" placeholder="하이픈(-)포함" required readonly><!--로그인한 구매자의 휴대폰 번호 띄워두기-->
							<input type="checkbox" name="answerMode" value="sms" id="answerSms"> <label for="answerSms">답변 수신을 문자 메시지로 받겠습니다.</label>
							<br>
							<p class="phoneCheckResult"></p>
						</td>
					</tr>
					<tr>
						<th class="label">내용*</th>
						<td>
							<p>
								1:1 문의 작성 전 확인해주세요!<br>
								- 제품 하자/이상이 있는 경우, 사진과 함께 구체적인 내용을 남겨주세요.<br>								
								- 배송일 및 배송시간 지정은 불가능합니다.
							</p>
							<textarea name="questionContent" cols="90" rows="10" style="resize: none;" placeholder="문의 내용을 입력해 주세요" required></textarea>
						</td>
					</tr>
					<tr>
						<th class="label">첨부파일</th>
						<td>
							<input type="file" name="upfile">
							<!-- <input type="file" name="upfile2"><br>
							<input type="file" name="upfile3">
							<input type="file" name="upfile4"><br>
							<input type="file" name="upfile5"><br><br> -->
							<p>- 파일은 1개 업로드가 가능합니다.</p>
						</td>
					</tr>
				</table> 

				<!--2022.3.17(목) 14h20-->
				<div align="center" style="float: right;">
					<button type="button" onclick="location.href='buyerList.qu'">취소(문의 목록으로 돌아가기)</button>
					<button type="reset" class="grayBtn">초기화</button>
					<button type="submit" class="orangeBtn">문의 글 등록</button> <!--onclick="location.href='buyerInsert.qu'"-->		
				</div>
			</form>

		</div> <!--div class="content" 영역 끝-->

		<!-- The Modal -->
		<div class="modal fade" id="selectOrder">
			<div class="modal-dialog modal-xl">
				<div class="modal-content">
				
					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">주문번호 선택</h4>
						<!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
					</div>
					
					<!-- Modal body -->
					<div class="modal-body">
						<p>
							문의하실 주문번호를 선택하세요.<br>
							이미 선택된 주문번호를 삭제하시려면 '취소' 버튼을 눌러주세요.
						</p>
						<table class="table">
							<thead class="thead-light">
								<tr>
									<th>주문번호</th>
									<th>주문일자</th>
									<th>판매자 번호</th>
									<th>판매자명</th>
									<th>주문상품</th>
									<th>수량</th>
									<th>주문금액</th>
									<th>선택</th>
								</tr>
							</thead>
							<tbody id="order-list">
								<!-- <tr>
									<td>1234567890</td>
									<td>2022-01-31 15:31</td>
									<td>판매자1</td>
									<td>샐러드1c</td>
									<td>2</td>
									<td>18,000원</td>
									<td><input type="radio" name="selectOrderNo"></td>
								</tr> -->
							</tbody>
						</table>

						<div id="paging-area">
							<ul class="pagination justify-content-center" style="margin:20px 0">
								<!-- <li class="page-item"><a class="page-link" href="#">&lt;&lt;</a></li>
								<li class="page-item"><a class="page-link" href="#">&lt;</a></li>
								<li class="page-item"><a class="page-link" href="#">1</a></li>
								<li class="page-item disabled"><a class="page-link" href="#">2</a></li>
								<li class="page-item"><a class="page-link" href="#">3</a></li>
								<li class="page-item"><a class="page-link" href="#">&gt;</a></li>
								<li class="page-item"><a class="page-link" href="#">&gt;&gt;</a></li> -->
							</ul>
						</div> <!--div id="paging-area" 영역 끝-->

					</div>
					
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="" data-dismiss="modal" onclick="cancelOrderNo();">취소</button>
						<button type="button" class="greenBtn" data-dismiss="modal" onclick="confirmOrderNo();">선택</button> <!--이 '선택' 버튼 클릭하면, checked 라디오버튼 행의 주문번호와 판매자명을 입력 양식 칸에 각각 입력함-->
					</div>
					
				</div>
			</div>
		</div> <!--주문번호 선택 modal창 영역 끝-->

	</div> <!--header 아래 모든 부분 감싸는 div 'outer' 영역 끝-->

	<jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>

	<!--2022.3.17(목) 15h-->
	<script>
		// $(function() {
		// 	$("input[type=radio]").click(function() {
		// 		console.log("라디오 버튼이 클릭됨");


		// 	})
		// })
		
		// 2022.3.23(수) 4h20 '주문 조회' 모달 창에서 '취소' 버튼 클릭 시
		function cancelOrderNo() {
			$("input[name=orderNo]").val("").attr("readonly", false);
			$("input[name=questionSellerName]").val("").attr("readonly", false);
			
			/*
			let $orderNo = $("#order-list input[type=radio]:checked").parent().siblings().eq(0).text();
			let $sellerName = $("#order-list input[type=radio]:checked").parent().siblings().eq(3).text();
			
			if ($("input[type=radio]:checked")) {
				$("input[name=orderNo]").val($orderNo).attr("readonly", true);
				$("input[name=questionSellerName]").val($sellerName).attr("readonly", true);
			} else {
				
			}
			*/
		}
		
		// 선택된 주문번호 관련하여 기존 문의 내역이 있는지 확인하는 함수
		function confirmOrderNo() {
			let $orderNo = $("#order-list input[type=radio]:checked").parent().siblings().eq(0).text();
			let $seller = $("#order-list input[type=radio]:checked").parent().siblings().eq(2).text();
			let $sellerName = $("#order-list input[type=radio]:checked").parent().siblings().eq(3).text();
			// console.log($seller);

			// 2022.3.18(금) 11h50 소영님이 알려주신, 주문번호 생성 테스트
			/*
			let sampleOrderNo = new Date().getTime();
			console.log(sampleOrderNo); // 1647571870181
			*/
			
			/*
			if (window.confirm("선택하신 주문번호" + $orderNo + " 관련 기존 문의 내역이 있습니다. 그래도 새로운 문의 글을 작성하시겠습니까?")) {
				addOrderNo($orderNo);
			} else {
				
			}
			*/
			
			// 2022.3.23(수) 1h40
			$.ajax({
				url : "confirmOrderNo.qu",
				data : {
					questionWriter : '${ loginUser.userNo }', // key에 해당하는 값을 ''로 안 묶으면 Uncaught SyntaxError: Unexpected token ',' 브라우저 개발자 도구 오류
					// questionWriter : 2,
					questionSeller : $seller,
					orderNo : $orderNo
				},
				success : function(result) {
					console.log(result);
					
					if (result == "Y") { // 해당 주문번호로 기존 1:1 문의 내역이 있는 경우 = result는 1 이상의 정수 = db에서 select count(*) 조회한 결과
						if (window.confirm("주문번호" + $orderNo + " 관련 " + $sellerName + " 앞 기존 문의 내역이 있습니다. 그래도 새로운 문의 글을 작성하시겠습니까?")) {
							addOrderNo($orderNo);
						} else { // 사용자가 해당 주문번호로 새로운 문의 글 작성을 희망하지 않는 경우, 모달 창 띄워두고 싶은데, 모달 창 닫힘 -> 어떻게 코드 써야 할지 잘 모르겠음
							console.log("해당 주문번호로 기존 1:1 문의 내역 있는데, 새로운 문의 글 작성을 희망하지 않음");
						}
					} else { // 해당 주문번호로 기존 1:1 문의 내역 없는 경우, 별도 확인 필요 없이, 문의 글 쓰도록 넘어가면 됨
						console.log("해당 주문번호로 기존 1:1 문의 내역 없음");
						addOrderNo($orderNo);
					}
				},
				error : function() {
					console.log("주문번호 관련 문의 글 조회 실패")
				}
			})
		}

		// 문의 글 작성 양식에 주문번호 및 판매자 입력
		function addOrderNo($orderNo) {
			// let $orderNo = $("#order-list input[type=radio]:checked").parent().siblings().eq(0).text();
			let $sellerName = $("#order-list input[type=radio]:checked").parent().siblings().eq(3).text();
			let $seller = $("#order-list input[type=radio]:checked").parent().siblings().eq(2).text();

			$("input[name=orderNo]").val($orderNo).attr("readonly", true);
			$("input[name=questionSellerName]").val($sellerName).attr("readonly", true);
			$("input[name=questionSeller]").val($seller);
		}
		
		$(function() {
			// '주문 조회' 버튼 클릭 -> 해당 회원의 주문 list 조회 AJAX 요청
			$("#buyerOrderList").click(function() {
				$.ajax({
					url : "buyerOrderList.qu",
					data : {
						userNo : '${ loginUser.userNo }' // key에 해당하는 값을 ''로 안 묶으면 Uncaught SyntaxError: Unexpected token ',' 브라우저 개발자 도구 오류
						// userNo : 2
					},
					success : function(result) {
						// console.log(result);
						
						// 2022.3.22(화) 23h5
						let list = result.list;
						// console.log(list);
						
						let tbody = "";
						
						if (!result.list.length) { // 주문 내역이 없는 경우
							tbody = "<tr><td colspan=8>주문 내역이 없습니다.</td></tr>"
						} else { // 주문 내역이 있는 경우
							// 주문 내역 목록 띄우기
							$.each(list, function(index, order) {
								tbody += "<tr>"
										+ "<td>" + order.orderNo + "</td>" 
										+ "<td>" + order.orderDate + "</td>" 
										+ "<td>" + order.seller + "</td>" 
										+ "<td>" + order.sellerName + "</td>" 
										+ "<td>" + order.orderItem.substr(0, 30) + "...</td>" 
										+ "<td>" + order.quantity + "</td>" 
										+ "<td>" + order.orderPrice + "</td>";
										
								// 라디오버튼 1개가 checked되면, Ajax 요청 보내서 이 구매자가 이 주문번호로 문의한 내역이 QUESTION 테이블에 있는지 확인
								// -> 해당 사항 있으면 confirm 창 띄우고,
								// -> 구매자가 true 선택 시 modal창 닫으며(근데 이걸 어떻게 하지?) checked 라디오버튼 행의 주문번호와 판매자명을 입력 양식 칸에 각각 입력함
								if ($("input[name=orderNo]").val() == order.orderNo) { //  && $("input[name=sellerName]").val() == order.sellerName
									tbody += "<td><input type='radio' name='selectOrderNo' checked></td>";
								} else {
									tbody += "<td><input type='radio' name='selectOrderNo'></td>";
								}
								
								tbody += "</tr>";
							})
							
							$("#order-list").html(tbody);
							
							// 주문 내역 페이징 처리
							let pi = result.pi;
							// console.log(pi);
							// console.log(pi.currentPage);
							
							var pagingArea = ""; // 여기 페이징바가 떠야 하는데..
							
							if (pi.currentPage != 1) {
								pagingArea += "<li class='page-item'><a class='page-link' href='buyerOrderList.qu?cpage=" + (pi.currentPage - 1) + ">&gt;</a></li>";
								// pagingArea += "<button onclick='location.href='buyerOrderList.qu?cpage=" + (pi.currentPage - 1) + "''>&lt;</button>";
							}
							
							for (let i = pi.startPage; i <= pi.endPage; i++) {
								if (i != pi.currentPage) {
									pagingArea += "<li class='page-item'><a class='page-link' href='buyerOrderList.qu?cpage=" + i + ">" + i + "</a></li>";
									// pagingArea += "<button onclick='location.href='buyerOrderList.qu?cpage=" + i + "''>" + i + "</button>";
								} else {
									pagingArea += "<li class='page-item'><a class='page-link' href='#'>" + i + "</a></li>";
								}
							}
							
							if (pi.currentPage != pi.maxPage && pi.maxPage != 0) {
								pagingArea += "<li class='page-item'><a class='page-link' href='buyerOrderList.qu?cpage=" + (pi.currentPage + 1) + ">&gt;</a></li>";
							}
							
							$("#paging-area>ul").html(pagingArea);
						} // else문 영역 끝
						
					},
					error : function() {
						console.log("주문 목록 조회 실패")
					}
				})
			})
			
			// 2022.3.23(수) 3h20 판매자 이름 자동완성 검색해서 입력
			// 참고 = https://lts0606.tistory.com/469
			$("input[name=questionSellerName]").keyup(function() {
				let $searchSellerName = $(this).val();

				$.ajax({
					url : "searchSellerName.qu",
					data : {
						sellerNameKeyword : $searchSellerName
					},
					success : function(result) {
						console.log(result);
						
						if ($("input[name=orderNo]").val() == '' && $searchSellerName != '') { // 주문번호는 빈칸이고 + 판매자 이름 칸에 어떤 글자가 입력되면
							$("#autoComplete").children().remove();

							// let $selectedSeller = "";

							result.forEach(function(seller) { // 이 반복문 형태 공부해야 함 ㅠ.ㅠ
								if (seller.sellerName.indexOf($searchSellerName) > -1) { // 만약 입력된 데이터가 가져온 데이터에 비슷한 경우면,
									// 인터넷 검색 + 수정님 댓글 신고 구현 시 논의한 것 참고
									// $("#autoComplete").append($("<div>").text(seller.sellerName).attr({"data-userNo":seller.userNo}));

									$("#autoComplete").append($("<div>").text(seller.sellerName));
									$("#autoComplete").append($("<input>").attr("type", "hidden").attr("name", "userNo").val(seller.userNo));
									// $selectedSeller = $("#autoComplete>input").val();
								}
							})
							
							$("#autoComplete>div").each(function() { // 이 반복문 형태 공부해야 함 ㅠ.ㅠ
								$(this).click(function() {
									let $selectedSellerName = $(this).text();
									let $selectedSeller = $(this).next().val();

									console.log($selectedSellerName); // King받는샐러드숍
									console.log($selectedSeller); // 3
									// console.log($("input[name=questionSeller]").val());
									
									$("input[name=questionSellerName]").val($selectedSellerName);
									$("input[name=questionSeller]").val($selectedSeller);
																		
									// 특정 판매자가 선택된 이후에는 검색 결과 안 보이게 함
									$("#autoComplete").children().remove();
									// isComplete = true; // 참고 사이트의 '전체 코드' 부분에는 이 코드가 적혀있는데, 무슨 의미인지 모르겠음 -> 4h10 아래 부분 읽다 보니, 내 화면에는 필요 없는 부분임
								})
							})
						} else {
							$("#autoComplete").children().remove();
						}
						
					},
					error : function() {
						console.log("판매자 이름 검색 실패");
					}

				})

			})
			
			// 2022.3.23(수) 11h30 답변 수신 방법에 따라 필수 입력 여부 표시
			$("input[name=answerMode]").on('change', function() {
				let $answerMode = $(this).prop('checked');
				let $label = $(this).parent().siblings().text();
				
				if ($answerMode) {
					$(this).siblings().attr('required', true);
					
					// console.log("답변 수신 방법 체크박스 체크 - " + $label); // 답변 수신 방법 체크박스 체크 - 이메일
					// console.log(typeof($label)); // string
					$label += "*";
					// console.log($label); // 이메일*
					$(this).parent().siblings().text($label);
				}
				else {
					$(this).siblings().attr('required', false);
					
					$label = $label.substring(0, 3);
					$(this).parent().siblings().text($label);
				}
			})
			
			/*
			// 2022.3.23(수) 13h 현재 필요 없을 듯..
			// 휴대전화 번호 형식 검사 정규표현식 -> 2022.3.17(목) 18h20 테스트 시 문제점 = 정규표현식에 부합하는 전화번호 입력한 다음, 그 번호 수정해서 다시 이상한 형식이 되었을 때 오류 메시지가 안 뜸
			$("input[name=phone]").blur(function() {
				
				if ($("#answerSms").prop('checked')) {
					
				}
				
				let $phone = $(this).val();
				let regExp = /^01[016789]-\d{4}-\d{4}$/;

				if (!regExp.test($phone)) {
					$(".phoneCheckResult").text("잘못된 전화번호 형식입니다. 확인해 주세요~").css("display", "block");
					$("input[name=phone]").focus();
				} else {
					$(".phoneCheckResult").css("display", "none");
				}
			})
			*/
		})
		
	</script>

</body>
</html>