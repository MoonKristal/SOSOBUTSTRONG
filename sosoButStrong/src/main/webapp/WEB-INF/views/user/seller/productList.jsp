<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자 상품/조회 수정 화면</title>
<link rel="stylesheet" href="resources/css/user/seller/productList.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>
    <div class="outer" style="height: 1000px;">
        <jsp:include page="/WEB-INF/views/user/seller/sellerMyMenu.jsp"/>
        <br><br>
        <h2 style="font-weight: bolder; margin-left: 230px;" >&nbsp;&nbsp;상품조회/수정</h2>
        <br>
        <table align="center" class="list-area">
            <thead>
                <tr style="background-color: lightgray;">
                    <th width="70">수정</th>
                    <th width="70">삭제</th>
                    <th width="100">상품번호</th>
                    <th width="250">상품명</th>
                    <th width="80">판매상태</th>
                    <th width="65">판매가</th>
                    <th width="120">상품등록일</th>
                    <th width="120">최종수정일</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${ !empty list }">
                        <c:forEach var="p" items="${ list }">
                                <tr>
                                    <td><a href="updateProductForm.se?pno=${ p.productNo }&filePath=${ p.changeName }" onclick="return confirm('상품을 수정 하시겠습니까?')" class="btn btn-outline-warning btn-sm" style="font-weight: bolder;">수정</a></td>
                                    <td><a href="deleteProduct.se?pno=${ p.productNo }&filePath=${ p.changeName }" onclick="return confirm('상품을 삭제 하시겠습니까?')" class="btn btn-outline-danger btn-sm" style="font-weight: bolder;">삭제</a></td>
                                    <td>${ p.productNo }</td>
                                    <td>${ p.productName }</td>
                                    <td>${ p.sellStatus }</td>
                                    <td>${ p.price }</td>
                                    <td>${ p.createDate }</td>
                                    <td>${ p.modifyDate }</td>
                                </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan='9' style='pointer-events: none; width:600px; text-align: center;'>등록된 상품이 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <!-- 페이징 영역-->
        <div id="pagingArea" style="margin-left: 680px;">
            <ul class="pagination">
                <c:choose>
                <c:when test="${ pi.currentPage eq 1 }">
                    <li class="page-item" style="display: none;"><a class="page-link" href="#">이전</a></li>
                </c:when>
                <c:otherwise>
                    <li class="page-item"><a class="page-link" href="sellerProductList.se?pPage=${ pi.currentPage - 1 }">이전</a></li>
                </c:otherwise>
                </c:choose>
                <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                        <li class="page-item"><a class="page-link" href="sellerProductList.se?pPage=${ p }">${ p }</a></li>
                </c:forEach>
                <c:choose>
                    <c:when test="${ pi.currentPage eq pi.endPage }">
                <li class="page-item" style="display: none;"><a class="page-link" href="#">다음</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item"><a class="page-link" href="sellerProductList.se?pPage=${ pi.currentPage + 1 }">다음</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>

    </div>
    <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>	
</body>
</html>