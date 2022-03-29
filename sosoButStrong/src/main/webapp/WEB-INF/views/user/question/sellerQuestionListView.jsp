<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자 1:1문의 관리</title>
<link rel="stylesheet" href="resources/css/user/question/sellerQuestionListView.css">
</head>
<body>

    <jsp:include page="/WEB-INF/views/user/common/header.jsp"/>

    <!--2022.3.25(금) 9h20-->
    <div class="outer"> <!--header 아래 모든 부분 감싸는 div-->
        
        <!--판매자 마이페이지 좌측 메뉴바-->
        <jsp:include page="/WEB-INF/views/user/seller/sellerMyMenu.jsp"/>

        <div class="content">
			<!-- 여기는 content div입니다 -->
            <h2>1:1문의 관리</h2>

            <br>
            <div id="search-area"> 
                <form action="sellerSearch.qu">
                    <input type="hidden" name="questionSeller" value="${ loginUser.userNo }"> <!--이렇게 hidden input으로 안 보내도, controller에서 session으로부터 loginUser 꺼내써도 됨-->
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
                                              
                                                    $("input[name=startDate]").val(dayFormatter(startDate)).attr("readonly", true);
                                                    break;
                                                case '3' : // 7일전~오늘 게시글 조회
                                                    startDate.setDate(now.getDate() - 7);
                                              
                                                    $("input[name=startDate]").val(dayFormatter(startDate)).attr("readonly", true);
                                                    break;
                                                case '4' : // 1개월전~오늘 게시글 조회
                                                    // console.log(now.getMonth() - 1); // 1
                                                    startDate.setMonth(now.getMonth() - 1);

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
                              
                                        console.log($("input[name=startDate]").val());
                                        console.log($("input[name=endDate]").val());
                                    })
                                })

                            }) // '이 문서가 읽히면' 함수 영역 끝
                        </script>

                        <tr>
                            <th>처리 상태</th>
                            <td>
                                <select name="answer">
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
                            <th>답변 만족도</th>
                            <td>
                                <select name="score">
                                    <option value="" selected>전체</option> 
                                    <option value="10">★★★★★</option>
                                    <option value="8">★★★★</option>
                                    <option value="6">★★★</option>
                                    <option value="4">★★</option>
                                    <option value="2">★</option>
                                    <option value="0">0점</option>
                                    <option value="999">미평가</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>상세 검색</th>
                            <td>
                                <select name="condition">
                                    <option value="">선택해 주세요</option> <!--selected 속성 안 써놔도 될듯-->
                                    <option value="userId">구매자ID</option>
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
                <b>문의 제목을 클릭</b>하시면, 상세한 문의 내역 확인 및 답변 등록이 가능합니다.
            </p>

            <div class="listView">
                <table class="table table-bordered" align="center">
                    <thead class="thead-light">
                        <tr>                            
                            <th>글 번호</th>
                            <th>문의 날짜</th>
                            <th>구매자ID</th>
                            <th>카테고리</th>
                            <th>제목</th>
                            <th>주문 번호</th>
                            <th>처리 상태</th>
                            <th>처리 날짜</th>
                            <th>답변 만족도</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:choose>
                            <c:when test="${ empty list }">
                                <tr>
                                    <td colspan="9">1:1문의 내역이 없습니다.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="q" items="${ list }">
                                    <tr>
                                        <td class="qno">${ q.questionNo }</td>
                                        <td>${ q.createDate }</td>
                                        <td>${ q.userId }</td>
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
                                        <td>
                                            <!--처리 상태(answer)가 'Y'인 경우 답변 날짜 표시-->
                                            <c:choose>
                                                <c:when test="${ q.answer eq 'N' }">
                                                    -
                                                </c:when>
                                                <c:otherwise>
                                                    ${ q.answerDate }
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <!--답변 만족도 데이터가 있는 경우 점수 표시 vs 답변 만족도가 아직 안 매겨진 경우 '-' 표시
                                            	2022.3.25(금) 10h10 테스트 시 미평가라 db에 null로 저장되어 있는 경우에도 0점으로 표시됨 -> db에서 받아올 때 null 값 처리해서 오기 -> 10h35 처리 완료-->
                                            <c:choose>
                                                <c:when test="${ q.score ne 999 }">
                                                    ${ q.score }점
                                                </c:when>
                                                <c:otherwise>
                                                    -
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
                            <li class="page-item"><a class="page-link" href="sellerList.qu">&lt;&lt;</a></li>
                            <li class="page-item"><a class="page-link" href="sellerList.qu?cpage=${ pi.currentPage - 1 }">&lt;</a></li>
                        </c:otherwise>
                    </c:choose>
                    
                    <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                        <c:choose>
                            <c:when test="${ p eq pi.currentPage }">
                                <li class="page-item disabled"><a class="page-link" href="#">${ p }</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item"><a class="page-link" href="sellerList.qu?cpage=${ p }">${ p }</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    
                    <c:choose>
                        <c:when test="${ pi.currentPage eq pi.maxPage }">
                            <li class="page-item disabled"><a class="page-link" href="#">&gt;</a></li>
                            <li class="page-item disabled"><a class="page-link" href="#">&gt;&gt;</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item disabled"><a class="page-link" href="sellerList.qu?cpage=${ pi.currentPage + 1 }">&gt;</a></li>
                            <li class="page-item disabled"><a class="page-link" href="sellerList.qu?cpage=${ pi.maxPage }">&gt;&gt;</a></li>
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
                location.href = 'sellerDetail.qu?qno=' + $(this).siblings(".qno").text();
            })
            
            // 검색 후 검색 영역 선택 값, 페이징 처리 등 아직 구현 못 함
        })
    </script>

    <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>

</body>
</html>