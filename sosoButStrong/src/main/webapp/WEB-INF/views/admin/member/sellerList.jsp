<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자 승인/거절</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="resources/css/admin/member/sellerList.css">
</head>
<body>

	<div class="wrap">
        <div id="menubar">
            <jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>
        </div>
        <div class="content">
            <!--  === Main ===  -->
			<div id="main-title"><h3 style="font-weight: bold;" >판매자 승인/거절</h3></div>
			<select name="status" onchange="changeSelect(this.value)">
			    <option value="st" selected="selected">전체</option>
			    <option value="승인">승인</option>
			    <option value="대기">거절</option>
			</select>
			<div class="innerOuter" style="padding:5% ">
            <table id="boardList"  align="center" >
 				<thead>                  
                    <tr height=35px>
                        <th width=100px >USER.NO</th>
                        <th width=200px>상호</th>
                        <th width=200px>사업자등록번호</th>
                        <th width=150px>업체연락처</th>
                        <th width=100px>심사결과</th>
                    </tr>
                </thead>
                <tbody>
					<c:forEach items="${list}" var="sl">
	                    <tr style="display:'';">
	                        <td class="no">${sl.userNo}</td>
	                        <td>${sl.sellerName}</td>
	                        <td>${sl.sellerBRN}</td>
	                        <td>${sl.sellerPhone}</td>
			                <c:choose>
			                    <c:when test="${ sl.sellerStatus eq 'N' }">
		                   		   <td class="거절">
				                    	<span class="badge badge-danger">거절</span>
				                   </td>
			                    </c:when>
			               		<c:otherwise>
				                   	<td class="승인">
				                     	<span class="badge badge-success">승인</span>
				                    </td>
			                	</c:otherwise>
			                </c:choose>
	                    </tr>
                   </c:forEach>
                </tbody>   
            </table>
            <br>
			<script>
            	$(function(){
					    $("#boardList>tbody>tr").click(function(){
					    	location.href = 'detail.se?no=' + $(this).children(".no").text();
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
	                    	<li class="page-item"><a class="page-link" href="list.se?cpage=${ pi.currentPage - 1 }">Previous</a></li>
	                    </c:otherwise>
					</c:choose>

					<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                    	<li class="page-item"><a class="page-link" href="list.se?cpage=${ p }">${ p }</a></li>
					</c:forEach>

					<c:choose>
						<c:when test="${ pi.currentPage eq pi.maxPage }">
		                    <li class="page-item disabled"><a class="page-link" href="#">Next</a></li><!-- 마지막페이지일경우 -->
						</c:when>
						<c:otherwise>
		                    <li class="page-item"><a class="page-link" href="list.se?cpage=${ pi.currentPage + 1 }">Next</a></li><!-- 마지막페이지일경우 -->
						</c:otherwise>
					</c:choose>
                </ul>
            </div>
        </div>
	</div>
	</div>
	<!-- 승인 거절 select -->
	<script>
		function changeSelect(e){
		      
		      $("#boardList").find("td").parent().css("display",'');
		      
		      if(e ==='st'){
		      $("#boardList").find("td").parent().css("display",'');
		      }else if(e ==='승인'){
		      $("#boardList").find("td.거절").parent().css('display','none');
		      }else{
		      $("#boardList").find("td.승인").parent().css('display','none');
		      }
		}
	</script>

</body>
</html>



