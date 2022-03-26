<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정산 관리</title>
<link rel="stylesheet" href="resources/css/user/seller/settlementOverview.css">
</head>
<body>
	
	<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>

    <!--2022.3.25(금) 15h15-->
    <div class="outer"> <!--header 아래 모든 부분 감싸는 div-->
        
        <!--판매자 마이페이지 좌측 메뉴바-->
        <jsp:include page="/WEB-INF/views/user/seller/sellerMyMenu.jsp"/>

        <div class="content">
			<!-- 여기는 content div입니다 -->
            <h2>정산 관리</h2>
            <br>

            <h3 style="display: inline;">매출 현황</h3>
            <span class="refreshTime"></span>
            <span><img src="resources/images/refresh.png" alt="새로고침" width="18" height="18" onclick="refreshOverview();"></span>
            <br><br>

            <div id="overview-area">
                <table class="table table-bordered" align="center" style="background-color: rgb(238, 238, 238);">                                        
                    <tr>
                        <td rowspan="4" width="120"><img src="resources/images/shoppingBag.png" alt="장바구니" width="80" height="80"></td>
                        <th>신규 주문</th>
                        <td class="newOrder">건</td>
                        <td rowspan="4" width="120"><img src="resources/images/calculator.png" alt="계산기" width="80" height="80"></td>
                        <th class="settleToday">오늘 정산<span><img src="resources/images/questionMark.png" alt="물음표" width="14" height="14"></span></th>
                        <td>건</td>
                    </tr>
                    <tr>                        
                        <th class="toBeDispatched">배송 준비</th>
                        <td>건</td>
                        <th class="settleTmr" rowspan="3">정산 예정<span><img src="resources/images/questionMark.png" alt="물음표" width="14" height="14"></span></th>
                        <td>건</td>
                    </tr>
                    <tr>                       
                        <th class="onDelivery">배송 중</th>
                        <td>건</td>
                    </tr>
                    <tr>
                        <th class="deliveryCompleted">배송 완료</th>
                        <td>건</td>
                    </tr>
                    <tr>
                        <td width="120"><img src="resources/images/cancel.png" alt="취소" width="80" height="40"></td>
                        <th class="canceled">취소 요청</th>
                        <td>건</td>
                    </tr>                
                </table>

                <div>
                    <span><img src="resources/images/questionMark.png" alt="물음표" width="20" height="20"></span>
                    <span>오늘 정산 : 전일 배송 완료 건 / 정산 예정 : 금일 배송 완료 예정 건</span>                    
                </div>

            </div>

            <script>
                $(function() {
                    refreshOverview();
                })               

                function refreshOverview() { // '새로고침' 버튼 누르면 호출되는 함수
                    refreshTime();

                    $.ajax({

                    })

                }

                function refreshTime() {
                    let now = new Date();

                    let year = now.getFullYear();
                    let month = ('0' + (now.getMonth() + 1)).slice(-2);
                    let day = ('0' + now.getDate()).slice(-2);

                    let hours = ('0' + now.getHours()).slice(-2); 
                    let minutes = ('0' + now.getMinutes()).slice(-2);
                    let seconds = ('0' + now.getSeconds()).slice(-2); 

                    let timeString = '&nbsp;&nbsp;&nbsp;최근 ' + year + '-' + month  + '-' + day + ' ' + hours + ':' + minutes  + ':' + seconds;
                    $(".refreshTime").html(timeString);
                }
            </script>
            
        </div> <!--div class="content" 영역 끝-->

    </div>

</body>
</html>