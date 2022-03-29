<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정산 내역 상세 조회</title>
<link rel="stylesheet" href="resources/css/user/seller/settlementDetailList.css">
</head>
<body>
	<!--2022.3.29(화) 2h-->

    <jsp:include page="/WEB-INF/views/user/common/header.jsp"/>

    <div class="outer"> <!--header 아래 모든 부분 감싸는 div-->
        
        <!--판매자 마이페이지 좌측 메뉴바-->
        <jsp:include page="/WEB-INF/views/user/seller/sellerMyMenu.jsp"/>

        <div class="content">
            <h2>정산 내역 상세 조회</h2>
            <br>

            
            <br><br>

            <h3>정산 내역 및 목록</h3>

            <button class="greenBtn" onclick="location.href='downloadExcel.st'" style="float:right;">엑셀 다운</button>
			<br><br>

            <div class="settle-summary">
                <table class="table table-borderless" style="background-color: rgb(238, 238, 238);">
                    <tr>
                        <td>결제 금액</td>
                        <td>결제 내역 합계</td>
                        <td><fmt:formatNumber value="${ o.orderPrice }"/> 원</td>
                    </tr>
                    <tr>
                        <td>수수료</td>
                        <td>위메샐 매출연동 수수료<span><img src="resources/images/questionMark.png" alt="물음표" width="14" height="14"></span></td>
                        <td><fmt:formatNumber value="${ o.fee }"/> 원</td>
                    </tr>
                    <tr>
                        <th>최종 정산 금액</th>
                        <th>결제 금액 - 수수료</th>
                        <th><fmt:formatNumber value="${ o.settlementAmount }"/> 원</th>
                    </tr>                
                </table>

                <div>
                    <span><img src="resources/images/questionMark.png" alt="물음표" width="20" height="20"></span>
                    <span>위메샐 매출 연동 수수료 : 구매자 결제 금액의 5%</span>                    
                </div>
            </div> <!--div class="settle-summary" 영역 끝-->
            <br><br>

            <div class="listView">
                <table class="table table-bordered" align="center">
                    <thead class="thead-light">
                        <tr>
                            <th>주문번호</th>
                            <th>상품명</th>
                            <th>구매자</th>
                            <th>주문상태</th>
                            <th>정산기준일</th>
                            <th>정산예정일</th>
                            <th>정산상태</th>
                            <th>결제금액(원)</th>
                            <th>매출연동수수료(원)</th>
                            <th>정산금액(원)</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:choose>
                    		<c:when test="${ empty list }">
                    			<tr>
                    				<td colspan="10">정산 내역이 없습니다.</td>
                    			</tr>
                    		</c:when>
                    		<c:otherwise>
                    			<c:forEach var="o" items="${ list }">
                    				<tr>
                    					<td>${ o.orderNo }</td>
                                        <td>${ o.productName }</td>
                                        <td>${ o.orderer }</td>
                                        <td>${ o.status }</td>
                                        <td>
                                        	<fmt:parseDate value="${ o.deliveryCompleteDate }" var="parseDeliveryCompleteDate" pattern="yyyy-MM-dd HH:ss" />
                                        	<fmt:formatDate value="${ parseDeliveryCompleteDate }" pattern="yyyy-MM-dd" />
                                        </td>
                                        <td>
                                        	<fmt:parseDate value="${ o.settlementExpectedDate }" var="parseSettlementExpectedDate" pattern="yyyy-MM-dd HH:ss" />
                                        	<fmt:formatDate value="${ parseSettlementExpectedDate }" pattern="yyyy-MM-dd" />
                                        </td>
                                        <td>${ o.settlementStatus }</td>
                                        <td><fmt:formatNumber value="${ o.orderPrice }"/></td>
                                        <td><fmt:formatNumber value="${ o.fee }"/></td>
                                        <td><fmt:formatNumber value="${ o.settlementAmount }"/></td> 
                    				</tr>
                    			</c:forEach>                    			
                    		</c:otherwise>
                    	</c:choose>
                    </tbody>
                </table>
            </div> <!--div class="listView" 영역 끝-->

            <div id="paging-area">
                <ul class="pagination justify-content-center" style="margin:20px 0">
                
                	<c:choose>
                		<c:when test="${ pi.currentPage eq 1 }">
                			<li class="page-item disabled"><a class="page-link" href="#">&lt;&lt;</a></li>
                   			<li class="page-item disabled"><a class="page-link" href="#">&lt;</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item"><a class="page-link" href="detail.st">&lt;&lt;</a></li>
                    		<li class="page-item"><a class="page-link" href="detail.st?cpage=${ pi.currentPage - 1 }">&lt;</a></li>
                		</c:otherwise>
                	</c:choose>
                	
                	<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                		<c:choose>
                			<c:when test="${ p eq pi.currentPage }">
                				<li class="page-item disabled"><a class="page-link" href="#">${ p }</a></li>
                			</c:when>
                			<c:otherwise>
                				<li class="page-item"><a class="page-link" href="detail.st?cpage=${ p }">${ p }</a></li>
                			</c:otherwise>
                		</c:choose>
                	</c:forEach>
                	
                	<c:choose>
                		<c:when test="${ pi.currentPage eq pi.maxPage }">
                			<li class="page-item disabled"><a class="page-link" href="#">&gt;</a></li>
                    		<li class="page-item disabled"><a class="page-link" href="#">&gt;&gt;</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item disabled"><a class="page-link" href="detail.st?cpage=${ pi.currentPage + 1 }">&gt;</a></li>
                    		<li class="page-item disabled"><a class="page-link" href="detail.st?cpage=${ pi.maxPage }">&gt;&gt;</a></li>
                		</c:otherwise>
                	</c:choose>
                </ul>
            </div> <!--div id="paging-area" 영역 끝-->

        </div> <!--div class="content" 영역 끝-->

    </div> <!--div class="outer" 영역 끝-->

</body>
</html>