<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매자 1:1문의 내역</title>
<link rel="stylesheet" href="resources/css/user/question/buyerQuestionListView.css">
</head>
<body>

	<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>
	
	<!--2022.3.7(월) 14h25
		http://localhost:8765/wemasal/WEB-INF/views/user/question/buyerQuestionListView.jsp-->
    <div class="outer"> <!--header 아래 모든 부분 감싸는 div-->
        
        <!--구매자 마이페이지 좌측 메뉴바-->
        <jsp:include page="/WEB-INF/views/user/common/buyerMyPageMenuBar.jsp"/>

        <div class="content">
			<!-- 여기는 content div입니다 -->
            <h2>1:1문의 내역</h2>

            <br>
            <button class="orangeBtn" onclick="location.href='enrollForm.qu'" style="float:right;">문의 글 등록</button>
			<br><br>
			
            <!--2022.3.14(월) 9h50-->
            <div id="search-area"> 
                <form action="buyerSearch.qu">
                    <input type="hidden" name="questionWriter" value="${ loginUser.userNo }"> <!--이렇게 hidden input으로 안 보내도, controller에서 session으로부터 loginUser 꺼내써도 됨-->
                    <table class="table table-borderless" style="background-color: rgb(238, 238, 238);">
                        <!--(tr>(th+td))*4-->
                        <tr>
                            <th>문의 접수일</th>
                            <td>
                                <button type="button" class="searchPeriod today" value="1">오늘</button>
                                <button type="button" class="searchPeriod 3days" value="2">3일</button>
                                <button type="button" class="searchPeriod 1week" value="3">1주일</button>
                                <button type="button" class="searchPeriod 1month" value="4">1개월</button>
                                <button type="button" class="searchPeriod 3months" value="5">3개월</button>
                                <button type="button" class="searchPeriod 1year" value="6">1년</button>
                                <button type="button" class="searchPeriod customized" value="7">직접 입력</button>

                                <input type="date" name="startDate"> ~ <input type="date" name="endDate">
                            </td>
                        </tr>

                        <!--참고
                            말일 처리 로직 https://beforb.tistory.com/23?category=1106228
                            JavaScript 날짜 처리 관련 전반 https://hianna.tistory.com/329?category=764998-->
                        <script>
                            dayFormatter = function(day) {
                                let dayYear = day.getFullYear();
                                let dayMonth = ("0" + (day.getMonth() + 1)).slice(-2);
                                let dayDate = ("0" + day.getDate()).slice(-2);
                                return dayYear + "-" + dayMonth + "-" + dayDate;
                            }

                            // 2022.3.15(화) 14h40
                            dateModifier = function(startDay, now) {
                                let startYear = startDay.getFullYear();
                                let startMonth = startDay.getMonth();
                                let startDate = startDay.getDate();

                                let nowDate = now.getDate();

                                if (startDate != nowDate) {
                                    startDay = new Date(startYear, startMonth, 0); // 전월의 마지막 날
                                }

                                return startDay;
                            }

                            $(function() {
                                // 오늘 날짜를 date 타입의 input에 입력하기 위해 'YYYY-MM-DD' 형식으로 만듦
                                let now = new Date();
                                let today = dayFormatter(now);                             

                                // 어떤 기간의 게시글을 조회하고 싶은지 버튼을 클릭하면 
                                $(".searchPeriod").each(function(index, value) {
                                    $(this).click(function() {
                                        console.log($(this).text()); // 클릭된 버튼이 어떤 기간을 선택한 것인지 console에서 확인해봄
                                        $(this).siblings().css('background-color', '#EFEFEF'); // 클릭된 버튼을 제외하고 나머지 버튼의 배경색은 default 값으로 함
                                        $(this).css('background-color', 'rgb(182, 238, 86)'); // 클릭된 버튼의 배경색은 연두색으로 변경
                                        
                                        // 2022.3.22(화) 14h20 '직접 입력' 버튼 추가
                                        if ($(this).val() != 7) {
                                        	// 조회 시작일 변수 startDate 선언 + 오늘 날짜로 값 초기화
                                            let startDate = new Date();

                                            // 조회 종료일로써 'YYYY-MM-DD' 형식의 오늘 날짜를 입력
                                            // console.log("오늘은 " + now.getFullYear() + "년 " + now.getMonth() + "월 " + now.getDate() + "일입니다"); // 오늘은 2022년 2월 14일입니다
                                            // console.log("오늘은 " + today + "로써, " + nowYear + "년 " + nowMonth + "월 " + nowDate + "일입니다"); // 오늘은 2022-03-14로써, 2022년 03월 14일입니다
                                            $("input[name=endDate]").val(today).attr("readonly", true);
                                          
                                            switch($(this).val()) {
                                                case '1' : // 오늘~오늘 게시글 조회                                                                                
                                                    $("input[name=startDate]").val(today).attr("readonly", true);
                                                    break;
                                                case '2' : // 3일전~오늘 게시글 조회
                                                    // console.log(now.getDate()); // 14
                                                    startDate.setDate(now.getDate() - 3);
                                                    // console.log(startDate); // now - 3 = 1647241000773 vs 'Fri Mar 11 2022 16:14:55 GMT+0900 (한국 표준시)'

                                                    // '3일전' 실험 -> 문제 없음
                                                    /*
                                                    let march1 = new Date("2022-03-01");
                                                    startDate.setDate(march1.getDate() - 3);
                                                    console.log(startDate); // Sat Feb 26 2022 16:37:06 GMT+0900 (한국 표준시)
                                                    */                                               
                                                    $("input[name=startDate]").val(dayFormatter(startDate)).attr("readonly", true);
                                                    break;
                                                case '3' : // 7일전~오늘 게시글 조회
                                                    startDate.setDate(now.getDate() - 7);

                                                    // '7일전' 실험 -> 문제 없음
                                                    /*
                                                    let march3 = new Date("2022-03-03");
                                                    startDate.setDate(march3.getDate() - 7);
                                                    console.log(startDate); // Thu Feb 24 2022 16:39:48 GMT+0900 (한국 표준시)
                                                    */                                               
                                                    $("input[name=startDate]").val(dayFormatter(startDate)).attr("readonly", true);
                                                    break;
                                                case '4' : // 1개월전~오늘 게시글 조회
                                                    // console.log(now.getMonth() - 1); // 1
                                                    startDate.setMonth(now.getMonth() - 1);

                                                    // 문제점 사례1)
                                                    /*
                                                    let august31 = new Date("2021-08-31");
                                                    let exStartDate1 = new Date(august31);
                                                    exStartDate1.setMonth(august31.getMonth() - 2); // 연산 결과 = 2021.6.31 -> 2021.6/31은 현실에서 존재하지 않는 바, 2021.7.1로 찍힘
                                                    console.log(exStartDate1); // Thu Jul 01 2021 09:00:00 GMT+0900 (한국 표준시) vs 의도하는 바는 2021-06-30
                                                    */

                                                    // 문제점 사례2)
                                                    /*
                                                    let march31 = new Date("2022-03-31");
                                                    let exStartDate2 = new Date(march31);
                                                    exStartDate2.setMonth(march31.getMonth() - 1); // 연산 결과 = 2022.2.31 -> 2022.2/29~부터 현실에서는 존재하지 않는 날짜이기 때문에 2022.3.3로 찍힘
                                                    console.log(exStartDate2); // Thu Mar 03 2022 09:00:00 GMT+0900 (한국 표준시) vs 의도하는 바는 2022-02-28
                                                    */

                                                    // JavaScript에서 개월 수 감소시키는 연산에 따라 x개월 전의 날짜로써 2/4/6/9/11월31일 등의 날짜가 나오는 경우의 문제를 해결하기 위해 dateModifer() 메소드/로직 만듦
                                                    startDate = dateModifier(startDate, now);

                                                    $("input[name=startDate]").val(dayFormatter(startDate)).attr("readonly", true);
                                                    break;
                                                case '5' : // 3개월전~오늘 게시글 조회
                                                    startDate.setMonth(now.getMonth() - 3);
                                                    startDate = dateModifier(startDate, now);
                                                    $("input[name=startDate]").val(dayFormatter(startDate)).attr("readonly", true);
                                                    break;
                                                case '6' : // 1년전~오늘 게시글 조회
                                                    // 2022.3.15(화) 15h30 test -> 15h40 test 완료
                                                    /*
                                                    let feb2020 = new Date("2020-02-29");
                                                    let exStartDate3 = new Date(feb2020);
                                                    exStartDate3.setMonth(feb2020.getMonth() - 12); // 나의 의도 = 2020.2.29로부터 1년 전 = 2019.2.28(o) 2019.3.1(x) -> 나의 의도대로 동작함
                                                    exStartDate3 = dateModifier(exStartDate3, feb2020);

                                                    $("input[name=endDate]").val(dayFormatter(feb2020));
                                                    $("input[name=startDate]").val(dayFormatter(exStartDate3));
                                                    */

                                                    startDate.setMonth(now.getMonth() - 12);
                                                    startDate = dateModifier(startDate, now);
                                                    $("input[name=startDate]").val(dayFormatter(startDate)).attr("readonly", true);

                                                    break;
                                            } // switch문 영역 끝
                                        }
                                        else { // 사용자가 날짜 직접 입력하는 경우
                                        	$("input[name=startDate]").val("").attr("readonly", false);
                                        	$("input[name=endDate]").val("").attr("readonly", false);
                                        }
                                        
                                        // 2022.3.25(금) 3h30 검색 기능 구현하며, 테스트용으로 추가
                                        console.log($("input[name=startDate]").val());
                                        console.log($("input[name=endDate]").val());
                                    })
                                })

                                // $(".today").click(function() {
                                    
                                //     console.log(now);
                                //     $("input[class=startDate]").val("2022-03-14");
                                //     // $("input[class=endDate]").val(now);
                                // })
                            }) // '이 문서가 읽히면' 함수 영역 끝
                        </script>

                        <tr>
                            <th>처리 상태</th>
                            <td>
                                <select name="answer"> <!--2022.3.25(금) 3h20 Question vo 객체의 answer 필드를 사용해서 요청 보내고자 함-->
                                    <option value="" selected>전체</option>
                                    <option value="Y">처리 완료</option>
                                    <option value="N">미처리</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>카테고리</th>
                            <td>
                                <select name="category">
                                    <option value="" selected>전체</option> 
                                    <option>배송 지연</option>
                                    <option>주문/결제 문의</option>
                                    <option>상품 정보 문의</option>
                                    <option>기타 문의</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>상세 검색</th>
                            <td>
                                <select name="condition">
                                    <option value="">선택해 주세요</option> <!--selected 속성 안 써놔도 될듯-->
                                    <option value="sellerName">판매자명</option>
                                    <option value="titleOrContent">제목 또는 내용</option>
                                    <option value="orderNo">주문 번호</option>
                                </select>
                                <input type="text" name="keyword"> <!--value="${ keyword }" 사용자가 검색하고자 입력했던 keyword가 input 입력난에 남아있도록 함-->
                            </td>
                        </tr>
                    </table>

                    <div align="center">
                        <button type="submit" class="orangeBtn">검색</button>
                        <button type="reset">초기화</button>
                    </div>                    
                </form>
            </div> <!--div id="search-area" 영역 끝-->
            <br><br>

            <p>
               <b>문의 제목을 클릭</b>하시면, 상세한 문의 내역을 확인할 수 있습니다.<br>
                미처리 상태의 문의 내역은 '수정' 버튼을 클릭해서 수정이 가능합니다.
            </p>

            <div class="listView">
                <table class="table table-bordered" align="center">
                    <thead class="thead-light">
                        <tr>                           
                            <th>글 번호</th>
                            <th>문의 날짜</th>
                            <th>판매자명</th>
                            <th>카테고리</th>
                            <th>제목</th>
                            <th>주문 번호</th>
                            <th>처리 상태</th>
                        </tr>
                    </thead>

                    <tbody>
                    	<c:choose>
                    		<c:when test="${ empty list }">
                    			<tr>
                    				<td colspan="8">1:1문의 내역이 없습니다.</td>
                    			</tr>
                    		</c:when>
                    		<c:otherwise>
                    			<c:forEach var="q" items="${ list }">
                    				<tr>			                            
			                            <td class="qno">${ q.questionNo }</td>
			                            <td>${ q.createDate }</td>
			                            <td>${ q.sellerName }</td>
			                            <td>${ q.category }</td>
			                            <td class="questionTitle">${ q.questionTitle }</td>
			                            <td>
			                            	<c:choose>
			                            		<c:when test="${ q.orderNo eq null }">
			                            			-
			                            		</c:when>
			                            		<c:otherwise>
			                            			${ q.orderNo }
			                            		</c:otherwise>
			                            	</c:choose>
			                            </td>
			                            <td>
			                                <!--처리 상태(answer)가 "N"인 경우 '미처리' vs "Y"인 경우 '처리 완료' 배지 표시-->
			                                <c:choose>
			                                	<c:when test="${ q.answer eq 'N' }">
			                                		<span class="badge badge-danger">미처리</span>
			                                	</c:when>
			                                	<c:otherwise>
			                                		<span class="badge badge-success">처리 완료</span>
			                                	</c:otherwise>
			                                </c:choose>
			                            </td>
			                        </tr>
                    			</c:forEach>
                    		</c:otherwise>
                    	</c:choose>          
                    </tbody>
                </table>
            </div> <!--div class="listView" 영역 끝-->
            <br><br>

            <div id="paging-area">
                <ul class="pagination justify-content-center" style="margin:20px 0">
                
                	<c:choose>
                		<c:when test="${ pi.currentPage eq 1 }">
                			<li class="page-item disabled"><a class="page-link" href="#">&lt;&lt;</a></li>
                   			<li class="page-item disabled"><a class="page-link" href="#">&lt;</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item"><a class="page-link" href="buyerList.qu">&lt;&lt;</a></li>
                    		<li class="page-item"><a class="page-link" href="buyerList.qu?cpage=${ pi.currentPage - 1 }">&lt;</a></li>
                		</c:otherwise>
                	</c:choose>
                	
                	<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                		<c:choose>
                			<c:when test="${ p eq pi.currentPage }">
                				<li class="page-item disabled"><a class="page-link" href="#">${ p }</a></li>
                			</c:when>
                			<c:otherwise>
                				<li class="page-item"><a class="page-link" href="buyerList.qu?cpage=${ p }">${ p }</a></li>
                			</c:otherwise>
                		</c:choose>
                	</c:forEach>
                	
                	<c:choose>
                		<c:when test="${ pi.currentPage eq pi.maxPage }">
                			<li class="page-item disabled"><a class="page-link" href="#">&gt;</a></li>
                    		<li class="page-item disabled"><a class="page-link" href="#">&gt;&gt;</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item disabled"><a class="page-link" href="buyerList.qu?cpage=${ pi.currentPage + 1 }">&gt;</a></li>
                    		<li class="page-item disabled"><a class="page-link" href="buyerList.qu?cpage=${ pi.maxPage }">&gt;&gt;</a></li>
                		</c:otherwise>
                	</c:choose>
                </ul>
            </div> <!--div id="paging-area" 영역 끝-->

        </div> <!--div class="content" 영역 끝-->

    </div>
    
    <script>
    	$(function() {
    		$(".listView td[class=questionTitle]").click(function() {
    			console.log($(this).siblings(".qno").text());
    			location.href = 'buyerDetail.qu?qno=' + $(this).siblings(".qno").text();
    		})
    		
    		// console.log(${ searchQ });
    		
    		// 2022.3.25(금) 6h5 검색 기능 구현 후 추가 -> 6h30 일단 포기 ㅠ.ㅠ
    		/*
    		$("input[name=startDate]").val(${ startDate });
    		$("input[name=endDate]").val(${ endDate } );
    		$("#search-area option[value=${ answer }]").attr("selected", true);
    		$("select[name=category] option[value=${ category }]").attr("selected", true);
    		*/
    	})
    </script>

    <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>

</body>
</html>