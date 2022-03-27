<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 판매자리스트</title>
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

	#btn {
       		width: 40px;
            padding: 8px 6px;
            border: 0;
            color: #fff;
            border-radius: 7px;
            background-color: red;
            font-size: 6px;
            font-weight: 900;
        }
	#pagingArea {
		width:fit-content; margin:auto;
		}
</style>
</head>
<body>

	<div class="wrap">
        <div id="menubar">
            <jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>
        </div>
        <div class="content">
            <!--  === Main ===  -->
			<div id="main-title"><h3 style="font-weight: bold;" >판매자 관리</h3></div>
			<select name="job">
			    <option value="판매중인 판매자" selected="selected">판매중인 판매자</option>
			    <option value="판매종료 판매자">판매종료</option>
			</select>
			<div class="innerOuter" style="padding:5% 10%;">
            <table id="boardList" class="table table-hover" align="center">
 				<thead>                  
                    <tr>
                        <th>회원.NO</th>
                        <th>상호</th>
                        <th>판매자</th>
                        <th>업체연락처</th>
                        <th>사업자등록번호</th>
                        <th>&nbsp;&nbsp;</th>
                    </tr>
                </thead>
                <tbody>
					<c:forEach items="${list}" var="sl">
	                    <tr>
	                        <td class="no">${sl.userNo}</td>
	                        <td>${sl.sellerName}</td>
	                        <td id="userName"></td>
	                        <td>${sl.sellerBRN}</td>
	                        <td>${sl.sellerPhone}</td>
	                        <td>
	                        	<button type="button" id="btn" data-toggle="modal" data-target="#deleteForm">탈퇴</button>
	                        </td>
	                        
	                    </tr>
                   </c:forEach>
                </tbody>   
            </table>
            <br>
            <!-- 상세페이지 보기 -->
			
           
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
	
	<!-- 모달 창 -->
		<div class="modal fade" id="deleteForm">
	        <div class="modal-dialog modal-sm">
	            <div class="modal-content">
	
	                <!-- Modal Header -->
	                <div class="modal-header">
	                    <h4 class="modal-title">탈퇴 시키기</h4>
	                    <button type="button" class="close" data-dismiss="modal">&times;</button>
	                </div>
	
	                <form action="" method="post">
	                    <!-- Modal body -->
	                    <div class="modal-body">
	                        <div align="center">
				                             탈퇴시키겠습니까? <br>
	                        </div>
	                        <br>
	                        <input type="hidden" name="userNo" value="${ sl.userNo }">
	                    </div>
	                    <!-- Modal footer -->
	                    <div class="modal-footer" align="center">
	                        <button type="submit" class="btn btn-danger">예</button>
	                    </div>
	                </form>
	            </div>
	        </div>
	    </div>	
		<!-- 판매자 이름 가져오기 -->
		<script>
			$(function(){
				$.ajax ({
					url : "sellerUserName.ajax",
					data : {
						"userNo" : ${sl.userNo};
					},
					success : function(e){
						$("#userName").text( e );
						console.log("e");
					},
					error : function(){
						console.log("실패");
					}
				})
			})
		</script>
</body>
</html>



