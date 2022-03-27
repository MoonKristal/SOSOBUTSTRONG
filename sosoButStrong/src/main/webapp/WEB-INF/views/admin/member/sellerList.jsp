<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자 승인/거절</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<style>
	.wrap{
	    width: 1200px;
	    height: 800px;
	}
	#menubar{
	    float: left;
	}
	div{
	   /*border: 1px solid black;*/
	}
	.content{
	    width: 70%;
	    height: 800px;
	    margin-left: 350px;
	    padding-top: 50px;
	}
	#main-title {
		width: 100%;
		text-align: left;
	}

	 #pagingArea {width:fit-content; margin:auto;}
</style>
</head>
<body>

	<div class="wrap">
        <div id="menubar">
            <jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>
        </div>
        <div class="content">
            <!--  === Main ===  -->
			<div id="main-title"><h3 style="font-weight: bold;" >판매자 승인/거절</h3></div>
			<div class="innerOuter" style="padding:5% 10%;">
            <table id="boardList" class="table table-hover" align="center">
 				<thead>                  
                    <tr>
                        <th>NO</th>
                        <th>상호</th>
                        <th>사업자등록번호</th>
                        <th>업체연락처</th>
                        <th>심사결과</th>
                    </tr>
                </thead>
                <tbody>
					<c:forEach items="${list}" var="sl">
	                    <tr>
	                        <td class="no">${sl.userNo}</td>
	                        <td>${sl.sellerName}</td>
	                        <td>${sl.sellerBRN}</td>
	                        <td>${sl.sellerPhone}</td>
	                        <td>
	                        <!--처리 상태(answer)가 "N"인 경우 '미처리' vs "Y"인 경우 '처리 완료' 배지 표시-->
			                    <c:choose>
			                    	<c:when test="${ sl.sellerStatus eq 'N' }">
			                   			<span class="badge badge-danger">거절</span>
			                      	</c:when>
			                   		<c:otherwise>
			                        <span class="badge badge-success">승인</span>
			                    	</c:otherwise>
			                    </c:choose>
	                        </td>
	                        
	                    </tr>
                   </c:forEach>
                </tbody>   
            </table>
            <br>
			<script>
            	$(function(){
					    $("#boardList>tbody>tr").click(function(){
					    	location.href = 'detail.bo?no=' + $(this).children(".no").text();
					    })        		
            	})
            </script>
            <div id="pagingArea">
                <ul class="pagination">
					<c:choose>
						<c:when test="${ pi.currentPage eq 1 }">
	                    	<li class="page-item disabled"><a class="page-link" href="#">Previous</a></li><!-- 1번페이지일경우 -->
	                    </c:when>
	                    <c:otherwise>
	                    	<li class="page-item"><a class="page-link" href="list.bo?cpage=${ pi.currentPage - 1 }">Previous</a></li>
	                    </c:otherwise>
					</c:choose>

					<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                    	<li class="page-item"><a class="page-link" href="list.bo?cpage=${ p }">${ p }</a></li>
					</c:forEach>

					<c:choose>
						<c:when test="${ pi.currentPage eq pi.maxPage }">
		                    <li class="page-item disabled"><a class="page-link" href="#">Next</a></li><!-- 마지막페이지일경우 -->
						</c:when>
						<c:otherwise>
		                    <li class="page-item"><a class="page-link" href="list.bo?cpage=${ pi.currentPage + 1 }">Next</a></li><!-- 마지막페이지일경우 -->
						</c:otherwise>
					</c:choose>
                </ul>
            </div>
        </div>
	</div>
	</div>

</body>
</html>



