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
                <form action="buyerSearch.bo">
                    <input type="hidden" name="questionWriter">
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
                                        
                                        // 조회 시작일 변수 startDate 선언 + 오늘 날짜로 값 초기화
                                        let startDate = new Date();

                                        // 조회 종료일로써 'YYYY-MM-DD' 형식의 오늘 날짜를 입력
                                        // console.log("오늘은 " + now.getFullYear() + "년 " + now.getMonth() + "월 " + now.getDate() + "일입니다"); // 오늘은 2022년 2월 14일입니다
                                        // console.log("오늘은 " + today + "로써, " + nowYear + "년 " + nowMonth + "월 " + nowDate + "일입니다"); // 오늘은 2022-03-14로써, 2022년 03월 14일입니다
                                        $("input[name=endDate]").val(today);
                                      
                                        switch($(this).val()) {
                                            case '1' : // 오늘~오늘 게시글 조회                                                                                
                                                $("input[name=startDate]").val(today);
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
                                                $("input[name=startDate]").val(dayFormatter(startDate));
                                                break;
                                            case '3' : // 7일전~오늘 게시글 조회
                                                startDate.setDate(now.getDate() - 7);

                                                // '7일전' 실험 -> 문제 없음
                                                /*
                                                let march3 = new Date("2022-03-03");
                                                startDate.setDate(march3.getDate() - 7);
                                                console.log(startDate); // Thu Feb 24 2022 16:39:48 GMT+0900 (한국 표준시)
                                                */                                               
                                                $("input[name=startDate]").val(dayFormatter(startDate));
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

                                                $("input[name=startDate]").val(dayFormatter(startDate));
                                                break;
                                            case '5' : // 3개월전~오늘 게시글 조회
                                                startDate.setMonth(now.getMonth() - 3);
                                                startDate = dateModifier(startDate, now);
                                                $("input[name=startDate]").val(dayFormatter(startDate));
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
                                                $("input[name=startDate]").val(dayFormatter(startDate));

                                                break;      
                                        } // switch문 영역 끝
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
                                <select name="searchAnswer">
                                    <option value="searchAnswerAll" selected>전체</option>
                                    <option value="searchAnswerY">처리 완료</option>
                                    <option value="searchAnswerN">미처리</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>카테고리</th>
                            <td>
                                <select name="category">
                                    <option value="categoryAll" selected>전체</option> 
                                    <option value="delivery">배송 지연</option>
                                    <option value="order">주문/결제 문의</option>
                                    <option value="product">상품 정보 문의</option>
                                    <option value="etc">기타 문의</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>상세 검색</th>
                            <td>
                                <select name="condition">
                                    <option value="">선택해 주세요</option> <!--selected 속성 안 써놔도 될듯-->
                                    <option value="seller">판매자</option>
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
                문의 제목을 클릭하시면, 상세한 문의 내역을 확인할 수 있습니다.<br>
                미처리 상태의 문의 내역은 상세 보기 후 수정이 가능합니다.
            </p>

            <div class="listView">
                <table class="table table-bordered" align="center">
                    <thead class="thead-light">
                        <tr>
                            <th>수정</th>
                            <th>글 번호</th>
                            <th>문의 날짜</th>
                            <th>판매자</th>
                            <th>카테고리</th>
                            <th>제목</th>
                            <th>주문 번호</th>
                            <th>처리 상태</th>
                        </tr>
                    </thead>

                    <tbody>
                        <!--(tr>td*8)*5-->
                        <tr>
                            <td>
                                <!--처리 상태(answer)가 "N"인 경우, 이 버튼이 보임-->
                                <button onclick="location.href='updateForm.qu'">수정</button>
                            </td>
                            <td>9</td>
                            <td>2022-02-28</td>
                            <td>판매자1</td>
                            <td>상품 정보 문의</td>
                            <td>xx 재료 더 이상 없나요?</td>
                            <td>-</td>
                            <td>
                                <!--처리 상태(answer)가 "N"인 경우 '미처리' vs "Y"인 경우 '처리 완료' 배지 표시-->
                                <span class="badge badge-danger">미처리</span>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>8</td>
                            <td>2022-02-02</td>
                            <td>판매자1</td>
                            <td>배송 지연</td>
                            <td>배송 조회가 안 돼요</td>
                            <td>1234567890</td>
                            <td>
                                <!--처리 상태(answer)가 "N"인 경우 '미처리' vs "Y"인 경우 '처리 완료' 배지 표시-->
                                <span class="badge badge-success">처리 완료</span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <!--처리 상태(answer)가 "N"인 경우, 이 버튼이 보임-->
                                <button onclick="location.href='updateForm.qu'">수정</button>
                            </td>
                            <td>7</td>
                            <td>2022-01-10</td>
                            <td>판매자8</td>
                            <td>상품 정보 문의</td>
                            <td>소스 질문 있어요</td>
                            <td>-</td>
                            <td>
                                <!--처리 상태(answer)가 "N"인 경우 '미처리' vs "Y"인 경우 '처리 완료' 배지 표시-->
                                <span class="badge badge-danger">미처리</span>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>6</td>
                            <td>2021-12-28</td>
                            <td>판매자2</td>
                            <td>기타 문의</td>
                            <td>품절 상품은 언제 주문 가능한가요?</td>
                            <td>-</td>
                            <td>
                                <!--처리 상태(answer)가 "N"인 경우 '미처리' vs "Y"인 경우 '처리 완료' 배지 표시-->
                                <span class="badge badge-success">처리 완료</span>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>5</td>
                            <td>2021-11-03</td>
                            <td>판매자4</td>
                            <td>주문/결제 문의</td>
                            <td>예약 주문 가능한가요?</td>
                            <td>-</td>                            
                            <td>
                                <!--처리 상태(answer)가 "N"인 경우 '미처리' vs "Y"인 경우 '처리 완료' 배지 표시-->
                                <span class="badge badge-success">처리 완료</span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div> <!--div class="listView" 영역 끝-->
            <br><br>

            <div id="paging-area">
                <ul class="pagination justify-content-center" style="margin:20px 0">
                    <li class="page-item"><a class="page-link" href="#">&lt;&lt;</a></li>
                    <li class="page-item"><a class="page-link" href="#">&lt;</a></li>
                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                    <li class="page-item disabled"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item"><a class="page-link" href="#">&gt;</a></li>
                    <li class="page-item"><a class="page-link" href="#">&gt;&gt;</a></li>
                </ul>
            </div> <!--div id="paging-area" 영역 끝-->

        </div> <!--div class="content" 영역 끝-->

    </div>

    <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>

</body>
</html>