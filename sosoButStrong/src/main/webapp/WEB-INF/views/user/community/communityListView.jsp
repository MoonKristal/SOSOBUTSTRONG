<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티</title>
<link rel="stylesheet" href="resources/css/user/community/communityListView.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/user/common/header.jsp"/>

    <br><br><br>

    <div class="wrap">
       
        <div class="bestRecipe">
            <b>BEST RECIPE</b>
            <c:forEach var="best" items="${ bestRecipe }" varStatus="status">
                <div class="topRecipe">
                    <div class="imgDiv1">
                        <c:choose>
                            <c:when test="${ empty best.changeName }">
                                NO IMAGE
                            </c:when>
                            <c:otherwise>
                                <img src="${ best.changeName}" class="salImg">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="content1_1">
                        <div class="imgs">
                            <div class="No1">
                            	<img src="resources/images/${ status.count}등.png" class="medal" alt="1등">
                            </div>
                            <div class="icons">
                                <a href="#">
                                    <img src="resources/images/돋보기.png" alt="더보기">
                                    <input type="hidden" value="${ best.comNo }">
                                </a>
                            </div>
                        </div>
                        <div class="content1_2">
                            <div class="title">
                                ${ best.saladName}
                            </div>
                            <div class="content_wrap">
                                <p>
                                    ${ best.comTitle}
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <br clear="both">

        <div class="newRecipe">
            <div class="newHeader">
                <div class="newTitle">
                    <b>신규 Recipe</b>
                </div>
                <div class="insertBtn">
                    <c:choose>
                        <c:when test="${ not empty loginUser}">
                            <a class="btn btn-outline-warning" href="communityInsertForm.co">레시피 등록</a>
                        </c:when>
                    </c:choose>
                </div>
            </div>
            <div class="outer">
                <c:forEach var="co" items="${ list }">
                    <div class="content2">
                        <div class="content2_1">
                            <div class="imgDiv2">
                            	<c:choose>
	                            	<c:when test="${ empty co.changeName }">
	                            		NO IMAGE
	                            	</c:when>
	                            	<c:otherwise>
	                                	<img src="${ co.changeName }" class="salImg">
	                                </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="icons">
                                <a href="#">
                                    <img src="resources/images/돋보기.png" alt="더보기">
                                    <input type="hidden" value="${ co.comNo }">
                                </a>
                            </div>
                        </div>
                        <div class="content2_2">
	                        <div class="title">
                                ${ co.saladName }
	                        </div>
	                        <div>
	                            <p>
		                            ${ co.comTitle }
	                            </p>
	                        </div>
                        </div>
                    </div>
                </c:forEach>
                    

            </div>

            <script>
                $(function(){
                    $(".content2").mouseover(function(){
                        $('.content2_1>.icons').show();
                    })
                    $(".content2").mouseleave(function(){
                        $('.content2_1>.icons').hide();
                    })
                    $(".content2_1>.icons>a>img").click(function(){
                    	location.href='communityDetail.co?cno=' + $(this).parent().children().eq(1).val();
                    })
                    $(".content1_1>.imgs>.icons>a>img").click(function(){
                    	location.href='communityDetail.co?cno=' + $(this).parent().children().eq(1).val();
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
                                <li class="page-item"><a class="page-link" href="communityList.co?cpage=${ pi.currentPage - 1 }">Previous</a>
                            </c:otherwise>
                        </c:choose>
                        <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                            <li class="page-item"><a class="page-link" href="communityList.co?cpage=${ p }">${ p }</a></li>
                        </c:forEach>
                        <c:choose>
                            <c:when test="${ pi.currentPage eq pi.maxPage }">	
                                <!-- 마지막 페이지일 경우 -->
                                <li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item"><a class="page-link" href="communityList.co?cpage=${ pi.currentPage + 1 }">Next</a>
                            </c:otherwise>
                        </c:choose>
                    </ul>

                </div>
            </div>
        </div>
        <br clear="both">
        
    </div>
    <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>	
    
    <script>
	    function saladLike(){
	        var status = $("#saladLike").children().eq(0).attr('id');
	
			if(status == "fullHeart"){
				isLike = "Y";
			} else {
	            isLike = "N"; 
	        }
			
	        if(${loginUser != null}){
	            $.ajax({
	                url : 'like.he',
	                data : {
	                    'isLike' : isLike,
	                    'comNo' : '${ coA.comNo}'
	                }, success : function(result){
	                	console.log(result);
	                    if(result > 0){
	                        if(isLike == 'Y'){
	                            $("#saladLike").children().eq(0).replaceWith($('img.emptyHeart'));
	                            $("#saladLike>b").text(Number($('#saladLike>b').text())-1);
	                            location.reload();
	                        } else{
	                            $("#saladLike").children().eq(0).replaceWith($('img.fullHeart'));
	                            $("#saladLike>b").text(Number($('#saladLike>b').text())+1);
	                            location.reload();
	                        }
	                    }
	                }
	
	            })
	        }
		}
    
    </script>




</body>
</html>