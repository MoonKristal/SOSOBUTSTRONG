<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매자 1:1문의 상세 조회</title>
<link rel="stylesheet" href="resources/css/user/question/buyerQuestionDetailView.css">
</head>
<body>
	<!--2022.3.18(금) 10h50-->

    <jsp:include page="/WEB-INF/views/user/common/header.jsp"/>

    <div class="outer"> <!--header 아래 모든 부분 감싸는 div-->

        <!--구매자 마이페이지 좌측 메뉴바-->
        <jsp:include page="/WEB-INF/views/user/common/buyerMyPageMenuBar.jsp"/>

        <div class="content">
            <h2>1:1문의 상세 조회</h2>
            <br>
            
            <!--2022.3.24(목) 21h55-->
            <table class="table table-bordered questionDetail" align="center">
            	<tr>
                    <th class="label">글 번호</th>
                    <td>${ q.questionNo }</td>
                    <th class="label">문의 날짜</th>
                    <td>${ q.createDate }</td>
            	</tr>

                <tr>
                    <th class="label">판매자</th>
                    <td>${ q.sellerName }(연락처: ${ q.sellerPhone })</td> <!--나의 idea = 판매자가 연락처 공개를 희망했을 경우에만 표시 vs 그렇지 않으면 1:1문의 글을 통해서만 연락-->
                    <th class="label">처리 상태</th>
                    <td>
                    	<!--처리 상태(answer)가 "N"인 경우 '미처리' vs "Y"인 경우 '처리 완료' 배지 표시-->
                        <c:choose>
                        	<c:when test="${ q.answer eq 'N' }">
                        		<span class="badge badge-danger">미처리</span>
                        	</c:when>
                        	<c:otherwise>
                        		<span class="badge badge-success">처리 완료</span>
                        	</c:otherwise>
                        </c:choose>
                    </td>
            	</tr>

                <tr>
                    <th class="label">카테고리</th>
                    <td>${ q.category }</td>
                    <th class="label">주문 번호</th>
                    <td>
                    	<c:choose>
                      		<c:when test="${ q.orderNo eq null }">
                      			-
                      		</c:when>
                      		<c:otherwise>
                      			${ q.orderNo }
                      		</c:otherwise>
                      	</c:choose>
                    </td>
            	</tr>

                <tr>
                    <th class="label">제목</th>
                    <td colspan="3">${ q.questionTitle }</td>
                </tr>

                <tr>
                    <th class="label">내용</th>
                    <td colspan="3">
                        <p>${ q.questionContent }</p>
                    </td>
                </tr>                

                <tr>
                    <th class="label">이미지</th>
                    <td colspan="3">
                        <!--첨부 파일 있는 경우 vs 없는 경우 '첨부된 이미지가 없습니다.' 표시-->
                        <c:choose>
                      		<c:when test="${ q.originName eq null }">
                      			첨부된 이미지가 없습니다.
                      		</c:when>
                      		<c:otherwise>
                      			<div><img src="${ q.changeName }" alt="구매자 문의 이미지" width="500" height="300"></div>
                        		<div><a download="${ q.originName }" href="${ q.changeName }">${ q.originName }</a></div>
                      		</c:otherwise>
                      	</c:choose>
                    </td>
                </tr>            
            </table> <!--1:1문의 내역 상세 보기 영역 끝-->

            <!--현재 조회 중인 1:1문의 내역(Question 객체)의 answer 필드 값이 'Y'인 경우, 답변 내역 보여주기 vs 'N'인 경우, '수정' 및 '삭제' 버튼 보여주기-->
            <c:if test="${ q.answer eq 'Y' }">
            	<table class="table table-bordered answerDetail" align="center">
	                <tr>
	                    <th class="label" width="127.38px">답변 시각</th>
	                    <td>${ a.createDate }</td>
	                </tr>
	                <tr>
	                    <th class="label">답변 내용</th>
	                    <td>${ a.answerContent }</td>
	                </tr>
	                <tr>
	                    <th class="label">이미지</th>
	                    <td>
	                        <!--첨부 파일 있는 경우 vs 없는 경우 '첨부된 이미지가 없습니다.' 표시-->
	                        <c:choose>
	                        	<c:when test="${ empty a.originName }">
	                        		첨부된 이미지가 없습니다.
	                        	</c:when>
	                        	<c:otherwise>
	                        		<div><img src="${ a.changeName }" alt="판매자 답변 이미지" width="500" height="300"></div>
                        			<div><a download="${ a.originName }" href="${ a.changeName }">${ a.originName }</a></div>
	                        	</c:otherwise>
	                        </c:choose>
	                    </td>
	                </tr>
	            </table> <!--답변 영역 끝-->
	
	            <div id="answerRatingArea">
	                <span>답변에 만족하셨나요? 더 나은 서비스를 위해 만족도를 평가해 주세요.</span>
	                <!--참고: https://gurtn.tistory.com/80, https://stackoverflow.com/questions/2124351/setting-width-as-a-percentage-using-jquery-->              
	                <span class="star">                    
	                   	 ★★★★★
	                    <span id="colorStar">★★★★★</span>
	                    <input type="range" oninput="drawStar(this.value)" value="1" step="1" min="0" max="10">                   
	                </span>
	                <br><br>
	            </div>
            </c:if>

            <div align="center" style="float: right;">
                <button type="button" onclick="location.href='buyerList.qu'">문의 목록으로 돌아가기</button> <!--나의 질문 = 최근에 보고 있던 currentPage로 어떻게 돌아가지?-->

                <!--현재 조회 중인 1:1문의 내역(Question 객체)의 answer 필드 값이 'N'인 경우, '수정' 및 '삭제' 버튼 보여주기-->
                <c:if test="${ q.answer eq 'N' }">           
	                
	                <!--post 방식으로 요청 보내면서 name 속성 값을 보낼 수 있는 방법-->
	                <form method="post" action="" id="postForm">
	                    <input type="hidden" name="qno" value="${ q.questionNo }">
	                    <input type="hidden" name="filePath" value="${ q.changeName }"> <!--23h30 나의 질문 = 글 수정 양식 요청 시, 첨부파일 경로는 왜 필요하지? -> 나의 생각 = 필요 없는 듯-->
	                </form>
                </c:if>
            </div>

        </div> <!--div class="content" 영역 끝-->

    </div> <!--header 아래 모든 부분 감싸는 div 'outer' 영역 끝-->

    <script>
        function postFormSubmit(num) {
            if (num == 1) {
                $("#postForm").attr("action", "updateForm.qu").submit();
            }
            else {
                if (window.confirm("이 1:1문의 내역을 정말로 삭제하시겠습니까??")) {
                    $("#postForm").attr("action", "delete.qu").submit();
                }                
            }
        }
        
        function drawStar(score) {
        	console.log(score);
        	$("#colorStar").width((score * 10) + '%');
        	
        	$.ajax({
        		url : "answerRating.qu",
        		data : {
        			answerNo : ${ a.answerNo },
        			score : score
        		},
        		success : function(result) {
        			console.log(result);
        		},
        		error : function() {
        			console.log("답변 만족도 저장을 위한 AJAX 통신 실패");
        		}
        	})

        }
    </script>

</body>
</html>