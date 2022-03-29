<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 상세보기</title>
<!--style-->
<link rel="stylesheet" href="resources/css/user/order/orderDetailForm.css">
</head>
<body>
    <jsp:include page="../common/header.jsp"/>	

    <div class="orderDetail_outer">

        <jsp:include page="/WEB-INF/views/user/common/buyerMyPageMenuBar.jsp"/>
    
        <div class="content">
           
            
            <h3 style="margin: 20px 0px; font-weight: bold; color: rgb(255, 163, 63);">주문 상세 보기</h3>
            <h5><b>주문날짜</b>&nbsp; <span style="font-weight:400;">${list[0].orderDate}</span> &nbsp;&nbsp;&nbsp; <b>주문번호</b>&nbsp;<span style="font-weight:400;">${list[0].orderNo}</span></h5>
            <a href="orderList.od?cpage"><input type="button" class="order-btn list" value="&lt; 주문목록 돌아가기"></a>
            
            <c:forEach var="c" items="${list}">	

            <table class="detailList">
                <tr>
                    <td width="80%" colspan="2" style="font-weight: bold; font-size: 22px; border-top-style: solid; border-left-style: solid; border-right-style: solid; border-right-color:#ccc;"></td>                        
                    <td rowspan="3" class="btn3" style="border-bottom-style: solid; border-right-style: solid; border-top-style:solid;">
                        <a href="enrollForm.qu"><input type="button" class="order-btn question" value="판매자 문의하기"  ></a> <br>

                        <c:if test="${c.deliveryNo != null}">
                            <input type="button" class="order-btn delivery" value="배송조회" data-deliveryNo="${c.deliveryNo}"><br>                            
                        </c:if>
                        <c:if test="${c.status eq '배송완료'}">
                            <input type="hidden" class="productNo" value="${c.productNo}">
                            <input type="button" class="order-btn review" value="리뷰 작성하기" data-toggle='modal' data-target='#myModal'><br>

                        </c:if>
                    </td>                                   
                </tr>
                <tr>
                    <td colspan="2" style="font-weight: bold; padding-left: 30px; border-left: solid; border-right-style: solid; border-right-color:#ccc; font-size: 20px;"><span style="color: rgb(255, 163, 63); ">${c.status}</span></td>       
                                   
                </tr>
                <tr>
                    <td align="center"  width="18%" style="padding-top:0px; border-left-style: solid; border-bottom-style: solid;"><img style="width: 130px; height: 110px;" src="${c.sellerImage}"></td>
                    <td style="border-right-style: solid; border-right-color:#ccc; border-bottom-style: solid;"><b>[${c.sellerName}]</b>&nbsp; ${c.productName}<br><br>
                        ${c.orderItem}<br><br>
                        <label>${c.quantity}개 / ${c.orderPrice}원</label>                    
                    </td>                                      
                </tr>               
            </table>
            </c:forEach>

            <br><br><br>

            <h4>받는 사람 정보</h4>
			<hr class="line">

            <div class="orderList odLine">
				<table id="dv">
					<tr>
						<th>이름</th>
						<td name="" id="dvName" height="30">${list[0].deliveryName}</td>
					</tr>
					<tr>
						<th>배송주소</th>
						<td name="" id="dvAddress" height="30">${list[0].deliveryAddress}</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td name="" id="dvPhone" height="30">${list[0].deilveryPhone}</td>
					</tr>
                    <tr>
						<th>배송 요청사항</th>
						<td name="" id="dvPhone" height="30">${list[0].deliveryMessage}</td>
					</tr>
				</table>
			</div>


            <br><br><br>

            <c:set var="sum" value="0"/>				
				<c:forEach var="test" items="${list}">				
				 	<c:set var="sum" value="${sum + test.orderPrice * test.quantity}"/>					
				</c:forEach>


            <h4>결제 정보</h4>
			<hr class="line">

            <div class="orderList odLine">
				<table id="dv">
					<tr>
						<td width="55%" style="font-weight: bold;">결제수단</td>
						<td height="25" style="background: #ccc;">총 상품가격</td>
                        <td align="right" style="background: #ccc; font-weight: bold;"><fmt:formatNumber value="${sum}"/> 원</td>
					</tr>
					<tr>
						<td style="border-bottom-style: solid;">${list[0].payMethod}</td>
						<td height="25" style="background: #ccc; border-bottom-style: solid;">사용 포인트</td>
                        <td  align="right" style="background:#ccc; border-bottom-style: solid; font-weight: bold;">${list[0].usePoint}</td>
					</tr>
					<tr>
						<td></td>  
                        <td style="background: #ccc;"></td>
                        <c:choose>                  
                            <c:when test="${list[0].payMethod eq 'phone'}">
                                <td align="right" height="25" style="background: #ccc; font-weight: bold;">휴대폰 결제</td>
                            </c:when>
                            <c:otherwise>
                                <td align="right" height="25" style="background: #ccc; font-weight: bold;">카드 결제</td>
                            </c:otherwise>
                        </c:choose>
					</tr>
                    <tr>
						<td style="border-bottom-style: solid; border-bottom-color: #ccc;"></td>
						<td height="25" style="font-weight: bold; background: #ccc;">총 결제금액</td>
                        <td  align="right" style="background: #ccc;font-weight: bold; color: red; border-bottom-style: solid; border-bottom-color: #ccc;"><fmt:formatNumber value="${sum - list[0].usePoint}"/> 원</td>
					</tr>
				</table>
			</div>

            <br><br>

            <img src="resources/images/위메셀배송.jpg">

        </div>
        
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
    </div>



    <!-- 리뷰 작성용 모달 -->
    <div class="modal" id="myModal">
        <div class="modal-dialog">
        <div class="modal-content">
        
            <div class="modal-header">
            <h4 class="modal-title">리뷰 작성</h4>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            
            <div class="modal-body">
                <form id="" action="uploadReview.cs" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="refPno" id="rpn"><!-- 리뷰작성할 상품번호 -->
                    <input type="hidden" name="reviewWriter" value="${loginUser.userNo}"> <!-- 리뷰작성하는 회원번호 -->
                    <table align="center">
                        <tr>
                            <td><!-- 별점 영역 -->
                                <span class="star">
                                    ★★★★★
                                    <span>★★★★★</span>
                                    <input type="range" name="score" id="rStar" oninput="drawStar(this)" value="0" step="1" min="0" max="5">
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td><!-- 리뷰내용 -->
                                <textarea name="reviewContent" id="rCon" cols="40" rows="6" style="resize: none;" class="form-control"></textarea> 
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="file" name="thumbnail" class="form-control-file border" required> <!-- 리뷰이미지 -->
                            </td>
                        </tr>
                    </table>
                        <div class="modal-footer">
                        <button type="submit" class="btn btn-primary ">등록</button> <!-- 리뷰등록 버튼 -->
                        </div>
                </form>
            </div>
        </div>
        </div>
    </div>

    <script>
        const drawStar = (target) => { // 리뷰작성 폼에서 사용자가 클릭 or 드래그 한 만큼 별점 보여지도록 함
            document.querySelector('.star span').style.width = $('#rStar').val() * 20 + '%';
        }
    </script>

    <script>
        $('.review').on('click', function(){ // 리뷰 작성하기 버튼이 클릭되면

            var $rpn = $(this).prev().val(); // 클릭된 버튼 이전 요소(hidden 속성의 input 태그이며 상품번호 값 들어있음 )의 값을 변수에 담기

            $('#rpn').val($rpn); // 담은 상품번호를 리뷰작성 폼 내부 hidden 속성 input 태그에 값으로 넣어주기
        })
        
    </script>
    

    <script>    
       // 배송조회시 실행될 작은 사이즈의 창
        function goSubmit(){
            var win = window.open("", "w", "width=500,height=670");   
        }   

        $(function(){         
            
            $('#select_delivery').css('display', 'none'); // 배송조회 폼 눈에 안보임

            $('.delivery').click(function(){ //배송조회 버튼 click시 
                $('#t_invoice').val($('.delivery').attr('data-deliveryNo')); // 각 고유 운송장번호 입력됨
                $('#select_delivery').submit(); // 배송조회 form태그 실행

            })            

            // 현재 해당 메뉴바 CSS효과주기
            $('#orderList').addClass('current');             
            
        })
    </script>

    

    <br>
	<jsp:include page="../common/footer.jsp"/>
	
	<br><br>	

</body>
</html>