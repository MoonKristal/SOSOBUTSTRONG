<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지 리스트</title>
<link rel="stylesheet" href="resources/css/admin/main/mainListView.css">
</head>
<body>
    <div class="wrap">
        <div id="menubar">
            <jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>	
        </div>
        <div class="content">
            <div class="content_1">
                <div class="title">
                    <h2>메인페이지 사진 관리</h2>
                </div>
                <div class="btn_area">
                    <a class="btn btn-outline-primary" href="insertPicForm.main">등록</a>
                    <a class="btn btn-outline-danger" id="clickModal" data-toggle="modal" data-target="#deleteForm" href="#">삭제</a>
                </div>
            </div>
            <div>
                <table class="table" align="center">
                    <thead>
                        <tr>
                            <th width="50px"></th>
                            <th width="100px">사진번호</th>
                            <th width="300px">사진명</th>
                            <th width="150px">사진 등록 날짜</th>
                            <th width="100px">미리보기</th>
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
		                    	<c:forEach var="list" items="${ list }">
			                        <tr class="listTr">
			                            <td>
			                            	<input type="checkbox" class="chk batch" name="checked">
			                            	<input type="hidden" name="filePath" value="${ list.changeName }"> 
			                            </td>
			                            <td>${ list.fileNo }</td>
			                            <td>${ list.originName }</td>
			                            <td>${ list.uploadDate }</td>
			                            <td>
			                            	<input type="hidden" class="filePath" name="filePath" value="${ list.changeName }">
			                            	<img src="${ list.changeName }" alt="mainPageSal" class="thumbnail-img">
			                            </td>
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
    
    <script>
    	$(function(){
    		
    		// -------------------체크박스-------------------------
    		// 전체 체크박스를 체크하면 전체체크 / 해제하면 해제
    		$('#all').on('change', function(){
    			var $all = $('#all').prop('checked');
    			
    			if($all){
    				$('.chk').prop('checked', true);
    			}else{
    				$('.chk').prop('checked', false);
    			}
    		})
    		
    		// 전체가 체크된 상태에서 하나라도 체크가 풀리면 전체체크 해제
    		$('.chk').on('change', function(){
    			if($(this).prop('checked') == false){
    				$('#all').prop('checked', false);
    			} 
    		})
    		
    		// 체크박스를 하나씩 눌러 모두 체크가 되면 전체체크도 체크 / 해제하면 해제
    		//$('.chk').on('change', function(){
    			//if($(this).prop('checked') == true){
    				//$('#all').prop('checked', true)
    			//}
    			
    		//})
    		
    		// -------------------삭제-------------------------
    		$('#clickModal').click(function(){
    			if($('.listTr input:checked').length > 0){
    				$('.modal-body>span').html('삭제하시겠습니까?');
    				$('#delete').show();
    			} else {
    				$('.modal-body>span').html('삭제할 사진을 선택해주세요.');
    				$('#delete').hide();
    			}
    		})
    		
    		$('.chk').change('checked', function(){
    			var deleteAno = $(this).parent().siblings().eq(0).text();
    			var deleteTitle = $(this).parent().siblings().eq(1).text();
    			var filePath = $(this).siblings().eq(0).val();
    			
    			if($(this).prop('checked')){
    				$('#deleteList').append('<li class="fileNo">' + deleteTitle + '</li>');
    				$('#postForm').append('<input type="hidden" name="filePath" value="' + filePath + '">');
    				
    				console.log(filePath);
    			} else{
    				$('#deleteList').find('.' + deleteAno).remove();
    			}
    		})
    	})
    		/*
    		$('#deleteSubmit').click(function(){
    			var filePath = $(this).parent().siblings().eq(-1).children('.filePath').val();
    			var deleteList = [];
    			var deleteLength = $('#deleteList>li').length;
    			for(var i = 0; i < deleteLength; i++){
    				deleteList.push(filePath);
    		}
    			$('#deleteSubmit').attr("action", "picDeleteAd.main").submit();
    			location.href='picDeleteAd.main?changeName=' + deleteList;
    		})
    	})
    	
    	function postFormSubmit(){
    		$('#postForm').attr("action", "picDeleteAd.main").submit();
    	}
    	*/
    	
    	
 
    </script>
    
    
    
    
</body>
</html>