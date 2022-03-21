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

    <div class="wrap">
        <div class="vanner">
            <div class="point">
                <b>베스트 레시피에 선정되신 분께는 적립금 5,000원을 드립니다.</b><br>
                즉시사용 가능
            </div>
        </div>
        <div class="bestRecipe">
            <b>BEST RECIPE</b>
            <div class="topRecipe">
                <div class="imgDiv1">
                    <img src="resources/images/루꼴라샐러드.jpg" class="salImg" alt="1등">
                </div>
                <div class="content1_1">
                    <div class="imgs">
                        <div class="No1">
                            <img src="resources/images/1등.png" class="medal" alt="1등">
                        </div>
                        <div class="icons">
                        	<a href="#">
	                            <img src="resources/images/돋보기.png" alt="더보기">
                        	</a>
                        	<a href="#">
	                            <img src="resources/images/빈하트.png" alt="좋아요">
                        	</a>
                        </div>
                    </div>
                    <div class="content1_2">
                        <div class="title">
                            SYS'S의 레시피
                        </div>
                        <div>
                            <p>
                                천지는 얼마나 기쁘며 얼마나 아름다우냐? 
                                이것을 얼음 속에서 불러 내는 것이 따뜻한 봄바람이다 
                                인생에 따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 
                                청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="topRecipe">
                <div class="imgDiv1">
                    <img src="resources/images/루꼴라샐러드.jpg" class="salImg" alt="2등">
                </div>
                <div class="content1_1">
                    <div class="imgs">
                        <div class="No1">
                            <img src="resources/images/2등.png" class="medal" alt="2등">
                        </div>
                        <div class="icons">
                            <a href="#">
	                            <img src="resources/images/돋보기.png" alt="더보기">
                        	</a>
                        	<a href="#">
	                            <img src="resources/images/하트.png" alt="좋아요">
                        	</a>
                        </div>
                    </div>
                    <div class="content1_2">
                        <div class="title">
                            SYS'S의 레시피
                        </div>
                        <div>
                            <p>
                                천지는 얼마나 기쁘며 얼마나 아름다우냐? 
                                이것을 얼음 속에서 불러 내는 것이 따뜻한 봄바람이다 
                                인생에 따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 
                                청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="topRecipe">
                <div class="imgDiv1">
                    <img src="resources/images/루꼴라샐러드.jpg" class="salImg" alt="3등">
                </div>
                <div class="content1_1">
                    <div class="imgs">
                        <div class="No1">
                            <img src="resources/images/3등.png" class="medal" alt="3등">
                        </div>
                        <div class="icons">
                            <a href="#">
	                            <img src="resources/images/돋보기.png" alt="더보기">
                        	</a>
                        	<a href="#">
	                            <img src="resources/images/빈하트.png" alt="좋아요">
                        	</a>
                        </div>
                    </div>
                    <div class="content1_2">
                        <div class="title">
                            SYS'S의 레시피
                        </div>
                        <div>
                            <p>
                                천지는 얼마나 기쁘며 얼마나 아름다우냐? 
                                이것을 얼음 속에서 불러 내는 것이 따뜻한 봄바람이다 
                                인생에 따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 
                                청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <br clear="both">

        <div class="newRecipe">
            <div class="newHeader">
                <div class="newTitle">
                    <b>신규 Recipe</b>
                </div>
                <div class="insertBtn">
                    <a class="btn btn-outline-warning" href="communityInsertForm.co">레시피 등록</a>
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
                                <a href="#">
                                    <img src="resources/images/빈하트.png" alt="좋아요">
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
                    
                    $(".icons>a>img").click(function(){
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




</body>
</html>