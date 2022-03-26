<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 게시글 신고 관리</title>
<link rel="stylesheet" href="resources/css/admin/report/communityReportListView.css">
</head>
<body>
    <div class="wrap">
        <div id="menubar">
            <jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>	
        </div>
        <div class="content">
            <div class="content_1">
                <div class="title">
                    <h2>레시피 게시글 신고 관리</h2>
                </div>
            </div>
            <div>
                <table class="table" align="center">
                    <thead>
                        <tr>
                            <th width="70px">글 번호</th>
                            <th width="100px">작성 날짜</th>
                            <th width="300px">제목</th>
                            <th width="150px">상태</th>
                            <th width="100px">처리</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:choose>
                    		<c:when test="${ empty list }">
                    			<tr>
                    				<td colspan="5">조회된 게시글이 없습니다.</td>
                    			</tr>
                    		</c:when>
                    		<c:otherwise>
                    			<c:forEach var="lists" items="${ list }" varStatus="status">
                    				<tr>
                    					<td>
                                                <form action="post" action="" id="postForm">
													<input type="hidden" name="reportUserNo" id="reportUserNo" value="${ lists.userNo }">
													<input type="hidden" name="reportCom" id="reportCom" value="${ lists.reportCom }">
												</form>
                    						${ fn:length(list) - status.index }
                    					</td>
			                            <td>${ lists.createDate }</td>
			                            <td>${ lists.comTitle }</td>
			                            <c:choose>
			                            	<c:when test="${ lists.status eq 'R' }">
			                            		<td>반려</td>
			                            	</c:when>
			                            	<c:when test="${ lists.status eq 'D' }">
			                            		<td>삭제</td>
			                            	</c:when>
			                            	<c:otherwise>
			                            		<td></td>
			                            	</c:otherwise>
			                            </c:choose>
			                            <c:choose>
			                            	<c:when test="${ lists.completion eq 'N' }">
					                            <td><button class="btn btn-sm btn-warning disabled">대기</button></td>
			                            	</c:when>
			                            	<c:otherwise>
					                            <td><button class="btn btn-sm btn-info disabled">처리완료</button></td>
			                            	</c:otherwise>
			                            </c:choose>
                    				</tr>
                    			</c:forEach>
                    		</c:otherwise>
                    	</c:choose>
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
                                <li class="page-item"><a class="page-link" href="communityReportList.re?rpage=${ pi.currentPage - 1 }">Previous</a>
                            </c:otherwise>
                        </c:choose>
                        <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                            <li class="page-item"><a class="page-link" href="communityReportList.re?rpage=${ p }">${ p }</a></li>
                        </c:forEach>
                        <c:choose>
                            <c:when test="${ pi.currentPage eq pi.maxPage }">	
                                <!-- 마지막 페이지일 경우 -->
                                <li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item"><a class="page-link" href="communityReportList.re?rpage=${ pi.currentPage + 1 }">Next</a>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </div>
	</div>
	
	<script>
	
		$(function(){
			$(".table>tbody>tr").click(function(){
				location.href='communityReportDetail.re?reportUserNo=' + $(this).children().eq(0).children().children("#reportUserNo").val() + '&reportCom=' + $(this).children().eq(0).children().children("#reportCom").val();
			})
		})
		
		/*
		function postFormSubmit(){
              $("#postForm").attr("action", "communityReportDetail.re").submit();
        }
        */
	</script>
	
	
	
	
	
	

</body>
</html>