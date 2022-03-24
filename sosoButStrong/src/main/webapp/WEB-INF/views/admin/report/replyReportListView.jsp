<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 댓글 신고 관리</title>
<link rel="stylesheet" href="resources/css/admin/report/replyReportListView.css">
</head>
<body>
    <div class="wrap">
        <div id="menubar">
            <jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>	
        </div>
        <div class="content">
            <div class="content_1">
                <div class="title">
                    <h2>레시피 댓글 신고 관리</h2>
                </div>
            </div>
            <div>
                <table class="table" align="center">
                    <thead>
                        <tr>
                            <th width="70px">글 번호</th>
                            <th width="120px">댓글 작성 날짜</th>
                            <th width="300px">댓글</th>
                            <th width="150px">상태</th>
                            <th width="100px">처리</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<tr>
                            <td width="70px">1</td>
                            <td width="100px">2022-03-12</td>
                            <td width="300px">이렇게 먹어봐요</td>
                            <td width="150px">반려</td>
                            <td width="100px">처리완료</td>
                        </tr>
                    	<tr>
                            <td width="70px">1</td>
                            <td width="100px">2022-03-12</td>
                            <td width="300px">이렇게 먹어봐요</td>
                            <td width="150px">삭제</td>
                            <td width="100px">처리완료</td>
                        </tr>
                    	<tr>
                            <td width="70px">1</td>
                            <td width="100px">2022-03-12</td>
                            <td width="300px">이렇게 먹어봐요</td>
                            <td width="150px"></td>
                            <td width="100px">대기</td>
                        </tr>
                    	<tr>
                            <td width="70px">1</td>
                            <td width="100px">2022-03-12</td>
                            <td width="300px">이렇게 먹어봐요</td>
                            <td width="150px"></td>
                            <td width="100px">대기</td>
                        </tr>
                    	<tr>
                            <td width="70px">1</td>
                            <td width="100px">2022-03-12</td>
                            <td width="300px">이렇게 먹어봐요</td>
                            <td width="150px"></td>
                            <td width="100px">대기</td>
                        </tr>
                    	
                    	
                    </tbody>
                </table>
            </div>
            <div class="pagingArea">
                <br>
                <div class="pagingDiv">
                    <ul class="pagination">
                        <c:choose>
                            <c:when test="${ pi.currentPage eq 1 }">
                                <!-- 1번페이지일 경우 -->
                                <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item"><a class="page-link" href="picListAd.main?cpage=${ pi.currentPage - 1 }">Previous</a>
                            </c:otherwise>
                        </c:choose>
                        <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                            <li class="page-item"><a class="page-link" href="picListAd.main?cpage=${ p }">${ p }</a></li>
                        </c:forEach>
                        <c:choose>
                            <c:when test="${ pi.currentPage eq pi.maxPage }">	
                                <!-- 마지막 페이지일 경우 -->
                                <li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item"><a class="page-link" href="picListAd.main?cpage=${ pi.currentPage + 1 }">Next</a>
                            </c:otherwise>
                        </c:choose>
                    </ul>

                </div>
            </div>
        </div>
		
	</div>

</body>
</html>