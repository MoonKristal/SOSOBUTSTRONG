<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 관리</title>
<link rel="stylesheet" href="resources/css/admin/notice/managerNoticeListView.css">
</head>
<body>
	<!--2022.3.29(화) 4h35-->

    <div class="wrap">
        <div id="menubar">
            <jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>	
        </div>

        <div class="content">
            <div class="content_1">
                <div class="title">
                    <h2>공지사항 관리</h2>
                </div>
            </div>
            <div>
                <br>
                <button class="orangeBtn" onclick="location.href='enrollForm.no'" style="float:right;">공지사항 등록</button>
                <br><br>
    
                <div id="search-area"> 
                    <form action="managerSearch.no">                    
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
                                    <br><br>
                                    <input type="date" name="startDate"> ~ <input type="date" name="endDate">
                                </td>
                            </tr>
    
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
                                <th>게시 상태</th>
                                <td>
                                    <select name="show">
                                        <option value="" selected>전체</option>
                                        <option value="Y">게시 중</option>
                                        <option value="N">게시 종료</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>카테고리</th>
                                <td>
                                    <select name="category">
                                        <option value="" selected>전체</option> 
                                        <option>공통</option>
                                        <option>구매자 관련</option>
                                        <option>판매자 관련</option>
                                        <option>이벤트</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>중요 여부</th>
                                <td>
                                    <select name="top">
                                        <option value="" selected>전체</option> 
                                        <option value="Y">중요</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>제목 또는 내용</th>
                                <td>                                
                                    <input type="text" name="keyword" placeholder="검색어를 입력하세요"> <!--value="${ keyword }" 사용자가 검색하고자 입력했던 keyword가 input 입력난에 남아있도록 함-->
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

                <p><b>공지 글 제목을 클릭</b>하시면, 상세 내역을 확인할 수 있습니다.</p>

                <div class="listView">
                    <table class="table table-bordered" align="center">
                        <thead class="thead-light">
                            <tr>
                                <th>글 번호</th>
                                <th>작성일</th>
                                <th>카테고리</th>
                                <th>제목</th>
                                <th>게시 상태</th>
                                <th>중요 여부</th>
                                <th>조회 수</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:choose>
                                <c:when test="${ empty list }">
                                    <tr>
                                        <td colspan="7">공지사항이 없습니다.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="n" items="${ list }">
                                        <tr>
                                            <td class="nno">${ n.noticeNo }</td>
                                            <td>${ n.createDate }</td>
                                            <td>${ n.category }</td>
                                            <td class="nTitle">${ n.title }</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${ n.show eq 'N' }">
                                                        <span class="badge badge-danger">게시 종료</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-success">게시 중</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${ n.top eq 'Y' }">
                                                        	중요
                                                    </c:when>
                                                    <c:otherwise>
                                                        -
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${ n.count }</td>
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
                                <li class="page-item"><a class="page-link" href="managerList.no">&lt;&lt;</a></li>
                                <li class="page-item"><a class="page-link" href="managerList.no?cpage=${ pi.currentPage - 1 }">&lt;</a></li>
                            </c:otherwise>
                        </c:choose>
                        
                        <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                            <c:choose>
                                <c:when test="${ p eq pi.currentPage }">
                                    <li class="page-item disabled"><a class="page-link" href="#">${ p }</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item"><a class="page-link" href="managerList.no?cpage=${ p }">${ p }</a></li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        
                        <c:choose>
                            <c:when test="${ pi.currentPage eq pi.maxPage }">
                                <li class="page-item disabled"><a class="page-link" href="#">&gt;</a></li>
                                <li class="page-item disabled"><a class="page-link" href="#">&gt;&gt;</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item disabled"><a class="page-link" href="managerList.no?cpage=${ pi.currentPage + 1 }">&gt;</a></li>
                                <li class="page-item disabled"><a class="page-link" href="managerList.no?cpage=${ pi.maxPage }">&gt;&gt;</a></li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div> <!--div id="paging-area" 영역 끝-->

            </div> 
        </div>
    </div>
    
    <script>
    	$(function() {
    		$("tbody tr").click(function() {
    			console.log($(this).children(".nno").text());
    			location.href = 'managerDetail.no?nno=' + $(this).children(".nno").text();
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

</body>
</html>