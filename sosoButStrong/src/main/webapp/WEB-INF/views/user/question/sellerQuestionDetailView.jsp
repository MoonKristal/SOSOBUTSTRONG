<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자 1:1 문의 상세 조회 + 답변하기</title>
<link rel="stylesheet" href="resources/css/user/question/sellerQuestionDetailView.css">
</head>
<body>
    <!--2022.3.25(금) 10h40-->

    <jsp:include page="/WEB-INF/views/user/common/header.jsp"/>

    <div class="outer"> <!--header 아래 모든 부분 감싸는 div-->

        <!--판매자 마이페이지 좌측 메뉴바-->
        <jsp:include page="/WEB-INF/views/user/seller/sellerMyMenu.jsp"/>

        <div class="content">
            <c:choose>
                <c:when test="${ q.answer eq 'N' }">
                    <h2>1:1문의 상세 조회 + 답변하기</h2>
                </c:when>
                <c:otherwise>
                    <h2>1:1문의 상세 조회</h2>
                </c:otherwise>
            </c:choose>
            <br>

            <table class="table table-bordered questionDetail" align="center">
            	<tr>
                    <th class="label">글 번호</th>
                    <td>${ q.questionNo }</td>
                    <th class="label">문의 날짜</th>
                    <td>${ q.createDate }</td>
            	</tr>

                <tr>
                    <th class="label">구매자</th>
                    <td>${ q.userId }(이름: ${ q.userName })</td>
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
                    <td>${ q.questionTitle }</td>
                    <th class="label">답변 수신 방법</th>
                    <td>
                        <c:choose>
                      		<c:when test="${ q.answerMode ne null }">
                                ${ q.answerMode }
                      		</c:when>
                      		<c:otherwise>
                      			-
                      		</c:otherwise>
                      	</c:choose>
                    </td>
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

            <!--현재 조회 중인 1:1문의 내역(Question 객체)의 answer 필드 값이 'Y'인 경우, 답변 내역 보여주기 vs 'N'인 경우, '답변하기 양식' 보여주기-->
            <c:choose>
            	<c:when test="${ q.answer eq 'Y' }">
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
	                    <tr>
		                    <th class="label">구매자 답변 만족도</th>
		                    <td>
	                            <c:choose>
	                                <c:when test="${ a.score ne 999 }">
	                                    ${ a.score }점
	                                </c:when>
	                                <c:otherwise>
	                                    -
	                                </c:otherwise>
	                            </c:choose>
	                        </td>
		                </tr>
		            </table> <!--답변 영역 끝-->

                    <div align="center" style="float: right;">
                        <button type="button" onclick="location.href='sellerList.qu'">문의 목록으로 돌아가기</button> <!--나의 질문 = 최근에 보고 있던 currentPage로 어떻게 돌아가지?-->        
                    </div>
            	</c:when>
            	<c:otherwise>
                    <form id="answerForm" action="sellerInsert.qu" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="answerWriter" value="${ loginUser.userNo }">
                        <input type="hidden" name="questionNo" value="${ q.questionNo }">
                        <input type="hidden" name="answerMode" value="${ q.answerMode }">

                        <table class="table table-bordered" align="center">                            
                            <tr>
                                <th class="label">답변 내용</th>
                                <td><textarea name="answerContent" cols="90" rows="10" style="resize: none;" placeholder="답변 내용을 입력해 주세요" required></textarea></td>
                            </tr>
                            <tr>
                                <th class="label">이미지</th>
                                <td>
                                    <input type="file" name="upfile">
                                    <p>- 파일은 1개 업로드가 가능합니다.</p>
                                </td>
                            </tr>                          
                        </table> <!--답변 양식 표 끝-->

                        <div align="center" style="float: right;">
                            <button type="button" onclick="location.href='sellerList.qu'">취소(문의 목록으로 돌아가기)</button>
                            <button type="reset" class="grayBtn">초기화</button>
                            <button type="submit" class="orangeBtn">답변 등록</button>					
                        </div>
                    </form>
            	</c:otherwise>
            </c:choose>

        </div> <!--div class="content" 영역 끝-->

    </div> <!--header 아래 모든 부분 감싸는 div 'outer' 영역 끝-->

</body>
</html>