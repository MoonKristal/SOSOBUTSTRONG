<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 레시피</title>
<link rel="stylesheet" href="resources/css/user/community/communityMyRecipeListView.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/user/common/header.jsp"/>	
    <div class="wrap">
        <div id="menubar">
            <jsp:include page="/WEB-INF/views/user/common/buyerMyPageMenuBar.jsp"/>	
        </div>
        <div class="content">
            <div class="content_1">
                <div class="title">
                    <h2>등록된 나의 레시피</h2>
                </div>
            </div>
            <div class="table_wrap">
                <table class="table" align="center">
                    <thead>
                        <tr>
                            <th width="100px">글 번호</th>
                            <th width="300px">제목</th>
                            <th width="200px">레시피 명</th>
                            <th width="150px">작성한 날짜</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:choose>
                    		<c:when test="${ empty myList }">
                    			<tr>
                    				<td colspan="4">조회된 게시글이 없습니다.</td>
                    			</tr>
                    		</c:when>
                    		<c:otherwise>
		                    	<c:forEach var="myList" items="${ myList }">
			                        <tr class="listTr">
			                            <td>${ myList.comNo }</td>
			                            <td>${ myList.comTitle }</td>
			                            <td>${ myList.saladName }</td>
			                            <td>${ myList.createDate }</td>
			                        </tr>
		                        </c:forEach>
	                        </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
            
            <script>
		       	$(function(){
		       		$(".table>tbody>tr").click(function(){
						location.href='communityDetail.co?cno=' + $(this).children().eq(0).text();
		       		})
		       	})
		    </script>

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
                                <li class="page-item"><a class="page-link" href="myRecipeListView.co?cpage=${ pi.currentPage - 1 }">Previous</a>
                            </c:otherwise>
                        </c:choose>
                        <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                            <li class="page-item"><a class="page-link" href="myRecipeListView.co?cpage=${ p }">${ p }</a></li>
                        </c:forEach>
                        <c:choose>
                            <c:when test="${ pi.currentPage eq pi.maxPage }">	
                                <!-- 마지막 페이지일 경우 -->
                                <li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item"><a class="page-link" href="myRecipeListView.co?cpage=${ pi.currentPage + 1 }">Next</a>
                            </c:otherwise>
                        </c:choose>
                    </ul>

                </div>
            </div>
        </div>
        <br clear="both">
        
		
		<!-- The Modal : DeleteForm -->
		<div class="modal delete-form fade" id="deleteForm">
		  <div class="modal-dialog">
		    <div class="modal-content">
		
		      <!-- Modal Header -->
		      <div class="modal-header">
		        <h4 class="modal-title">
		        	메인페이지 사진 삭제
		        </h4>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		
		      <!-- Modal body -->
		      <div class="modal-body">
		        <ul id="deleteList">
		        
		        </ul>
		        <span>
		        
		        </span>
		      </div>
		
		      <!-- Modal footer -->
		      <div class="modal-footer">
			      <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			      <form method="post" action="picDeleteAd.main" id="postForm">
			        <button type="submit" id="deleteSubmit" class="btn btn-danger">삭제</button>
			      </form>
		      </div>
		      
		    </div>
		  </div>
		</div>

    </div>
    <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>	
    
    
    
    
    
    
    
    
    

</body>
</html>