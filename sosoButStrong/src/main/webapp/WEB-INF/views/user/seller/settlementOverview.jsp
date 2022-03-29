<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정산 관리</title>
<link rel="stylesheet" href="resources/css/user/seller/settlementOverview.css">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script> <!--구글차트 관련-->
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
            <span><img src="resources/images/refresh.png" alt="새로고침" width="18" height="18" onclick="refreshOverview(1);"></span>
            <br><br>

            <div id="overview-area">
                <table class="table table-bordered" align="center" style="background-color: rgb(238, 238, 238);">                                        
                    <tr>
                        <td rowspan="4" width="120"><img src="resources/images/shoppingBag.png" alt="장바구니" width="80" height="80"></td>
                        <th>신규 주문</th>
                        <td class="newOrders"></td>
                        <td rowspan="4" width="120"><img src="resources/images/calculator.png" alt="계산기" width="80" height="80"></td>
                        <th>오늘 정산<span><img src="resources/images/questionMark.png" alt="물음표" width="14" height="14"></span></th>
                        <td class="settleToday"></td>
                    </tr>
                    <tr>                        
                        <th>상품 준비 중</th>
                        <td class="toBeDispatched"></td>
                        <th rowspan="3">정산 예정<span><img src="resources/images/questionMark.png" alt="물음표" width="14" height="14"></span></th>
                        <td class="settleTmr"></td>
                    </tr>
                    <tr>                       
                        <th>배송 중</th>
                        <td class="onDelivery"></td>
                    </tr>
                    <tr>
                        <th>배송 완료</th>
                        <td class="deliveryComplete"></td>
                    </tr>
                    <tr>
                        <td width="120"><img src="resources/images/cancel.png" alt="취소" width="80" height="40"></td>
                        <th>취소 요청</th>
                        <td class="canceled"></td>
                    </tr>                
                </table>

                <div>
                    <span><img src="resources/images/questionMark.png" alt="물음표" width="20" height="20"></span>
                    <span>오늘 정산 : 전일 배송 완료 건 / 정산 예정 : 금일 배송 완료 건, 익영업일에 정산 예정</span>                    
                </div>

            </div>

            <script>
                $(function() {
                	refreshOverview(1);
                	refreshOverview(2);
                })               

                function refreshOverview(num) { // '새로고침' 버튼 누르면 호출되는 함수
                    refreshTime();
                
                	if (num == 1) {
                		$.ajax({
                        	url : "refreshOverview.st",
                        	data : {
                        		num : num
                        	},
                        	success : function(result1) {
                        		// console.log(result1);
                        		$(".newOrders").text(result1.newOrdersCount + "건");
                        		$(".toBeDispatched").text(result1.toBeDispatched + "건");
                        		$(".onDelivery").text(result1.onDelivery + "건");
                        		$(".deliveryComplete").text(result1.deliveryComplete + "건");
                        		$(".canceled").text(result1.canceled + "건");
                        		$(".settleToday").text(result1.settleToday + "원");
                        		$(".settleTmr").text(result1.settleTmr + "원");
                        	},
                        	error : function() {
                        		console.log("매출현황 표 새로고침 AJAX 통신 실패");
                        	}
                        })
                	}
                	else {
                        var queryObject = "";
                        var queryObjectLen = "";

                        $.ajax({
                            url : "refreshOverview.st",
                            data : {
                                num : num
                            },
                            success : function(result2) {
                                console.log(result2); // 23h AJAX 통신 1,2 응답 결과 console에 찍어봄

                                // 구글차트
                                google.charts.load('current', {packages: ['corechart', 'line']}); // 구글차트를 로드한 js로부터 차트의 기능을 불러오는 역할
                                google.charts.setOnLoadCallback(drawCurveTypes); // 파라미터에 해당div에 도표를 넣을 함수명이 들어감

                                function drawCurveTypes() {
                                    var data = new google.visualization.DataTable();

                                    data.addColumn('datetime', 'currentDate');
                                    data.addColumn('number', 'newOrdersCount');

                                    for (var i = 0; i < result2.length; i++) {
                                        var currentDate = result2[i].currentDate;
                                        var newOrdersCount = result2[i].newOrdersCount;
                                        data.addRows([[new Date(currentDate), newOrdersCount]]);
                                        console.log(data); // 23h40 console에 찍히는 것 잘 이해 안 됨 + 브라우저 개발자 도구 오류는 없어짐 + chart_div에 그래프 생기긴 함 -> 일단 포기 ㅠ.ㅠ
                                    }                                 
                                    
                                    var options = {
                                        hAxis: {
                                        title: '날짜'
                                        },
                                        vAxis: {
                                        title: '주문 건수'
                                        },
                                        series: {
                                        1: {curveType: 'function'}
                                        }
                                    };

                                    var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
                                    chart.draw(data, options);
                                }

                                // 2022.3.29(화) 0h25 그래프 구현 못하면, 수치를 표로 보여주기
                                let value = "";
                                for (let i in result2) {
                                    value += "<tr>"
                                                + "<td>" + result2[i].currentDate + "</td>"
                                                + "<td>" + result2[i].newOrdersCount + "건</td>"
                                                + "<td>" + result2[i].newOrdersAmount + "원</td>"
                                            + "</tr>";
                                }
                                
                                $("#graph_area tbody").html(value);
                            },
                            error : function() {
                                console.log("매출통계 그래프 새로고침 AJAX 통신 실패");
                            }
                        })                      
                                                              
                    }
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

            <!--2022.3.28(월) 18h10-->
            <br><br><br>
            <h3 style="display: inline;">매출 통계</h3>
            <span>최근 1달</span>
            <span><img src="resources/images/refresh.png" alt="새로고침" width="18" height="18" onclick="refreshOverview(2);"></span>
            <br><br>

            <div id="graph_area">              

                <!--2022.3.29(화) 0h15-->
                <table class="table table-bordered" align="center">
                    <thead class="thead-light">
                        <tr>
                            <th>날짜</th>
                            <th>주문 건수</th>
                            <th>주문 금액</th>
                        </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>          
                        
        </div> <!--div class="content" 영역 끝-->

    </div>

    <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>

</body>
</html>