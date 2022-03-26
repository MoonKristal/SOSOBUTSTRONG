<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 목록/배송 조회</title>
<!-- css -->
<link rel="stylesheet" href="resources/css/user/order/orderListForm.css">
<!-- 돋보기, 아이콘 CDN-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>

    <jsp:include page="/WEB-INF/views/user/common/header.jsp"/>

    <div class="list_outer">

        <jsp:include page="/WEB-INF/views/user/common/buyerMyPageMenuBar.jsp"/>
    
        <div class="content">
            <h3 style="margin: 20px 0px; font-weight: bold; color: rgb(255, 163, 63);">주문목록/배송조회</h3>
            
            <!-- 검색어 키워드로 주문목록 검색하기 -->
            <form action="search.od" name="searchForm" id="searchForm">
                <input type="hidden" name="cpage" value="1">
	            <input type="search" name="keyword" class="form-control form-control-sm keyword" style="width: 300px; margin-bottom: 10px; display: inline-block;" placeholder="주문한 마켓을 검색할 수 있습니다." value="${keyword}">
            	<button type="submit" style="color: #ccc; background: none; border-style:none;"><i class="fa-solid fa-magnifying-glass fa-lg"></i></button> <br>	
            </form>
            <a href="search.od?month=-6"><span class="badge badge-pill badge-success">최근 6개월</span></a>
            <a href="search.od?cpage=1&year=2021"><span class="badge badge-pill badge-success">2021</span></a>

            <div class="orderList">
                <c:choose>
                    <c:when test="${empty list}">
                        <div class="nothing">
                            <table>
                                <tr>
                                    <td height="580" align="center" style="font-size: 25px;">주문하신 내역이 없습니다.</td>
                                </tr>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="c" items="${list}">
                            <table>
                                <tr>
                                    <td width="80%" colspan="2" style="font-weight: bold; font-size: 22px; border-top-style: solid; border-left-style: solid; border-right-style: solid; border-right-color:#ccc;">
                                        &nbsp;${c.orderDate} 주문 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size: 17px; font-weight: bold;"><b style="color: white; background: rgb(255, 163, 63);">주문번호</b> ${c.orderNo}</span>
                                    </td>                        
                                    <td align="right" style=" font-weight: bold; font-size: 18px; border-top-style: solid; border-right: solid;"><a class="detail" href="orderDetail.od?orderNo=${c.orderNo}">주문 상세보기></a></td>                            
                                </tr>
                                <tr>
                                    <td colspan="2" style="font-weight: bold; border-left: solid; border-right-style: solid; border-right-color:#ccc; font-size: 20px;"><span style="color: rgb(255, 163, 63);">&nbsp;${c.status}</span></td>       
                                    <td style="border-right-style: solid;"></td>                 
                                </tr>
                                <tr>
                                    <td align="center" width="18%" style="padding: 10px; border-left-style: solid; border-bottom-style: solid;"><img style="width: 135px; height: 110px;" src="${c.sellerImage}"></td>
                                    <td style="border-right-style: solid; border-right-color:#ccc; border-bottom-style: solid;"><b>${c.sellerName} 외 ${c.sellerCount - 1}개</b><br>
                                        ${c.quantity}개 / <fmt:formatNumber value="${c.orderPrice}"/>원
                                    </td>
                                    <td style="border-bottom-style: solid; border-right-style: solid;">
                                        <c:choose>
                                            <c:when test="${c.status eq '결제완료'}">
                                                <input type="button" id="btn_orderNo" class="order-btn cancel" value="주문 취소" style="background: rgb(255, 163, 63);" data-orderNo="${c.orderNo}" onclick="cancle(this);"> <br>
                                            </c:when>   
                                            <c:otherwise>
                                                <input type="button" class="order-btn cancel" value="주문 취소" style="background: #ccc;" disabled> <br>
                                            </c:otherwise>
                                        </c:choose> 			               
                                    </td>
                                </tr>
                            </table>               
                        </c:forEach>
                    </c:otherwise>
                </c:choose>

                
            </div>

            <br><br>   

            <!-- 페이징 바 -->
                <ul class="pagination justify-content-center">      

                    <c:choose>                                      
                        <c:when test="${ pi.currentPage eq 1 or empty list}">                            
                            <li class="page-item disabled"><a class="page-link" href="#">이전</a></li>
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${not empty keyword}">
                                    <li class="page-item"><a class="page-link" href="search.od?cpage=${pi.currentPage - 1}&keyword=${keyword}">이전</a></li>
                                </c:when>
                                <c:when test="${ not empty year}">
                                    <li class="page-item"><a class="page-link" href="search.od?cpage=${pi.currentPage - 1}&year=${year}">이전</a></li>
                                </c:when>
                                <c:when test="${ not empty month}">
                                    <li class="page-item"><a class="page-link" href="search.od?cpage=${pi.currentPage - 1}&month=${month}">이전</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item"><a class="page-link" href="orderList.od?cpage=${pi.currentPage - 1}">이전</a></li>
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>

                    </c:choose>

                    <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">   
                        <c:if test="${p eq pi.currentPage}">
                            <li class="page-item disabled"><a class="page-link" href="orderList.od?cpage=${p}">${p}</a></li> 
                        </c:if>
                        <c:if test="${p ne pi.currentPage}">
                            <c:choose>
                                <c:when test="${ not empty keyword}">
                                    <li class="page-item"><a class="page-link" href="search.od?cpage=${p}&keyword=${keyword}">${p}</a></li>
                                </c:when>
                                <c:when test="${ not empty year}">
                                    <li class="page-item"><a class="page-link" href="search.od?cpage=${p}&year=${year}">${p}</a></li>
                                </c:when>
                                <c:when test="${ not empty month}">
                                    <li class="page-item"><a class="page-link" href="search.od?cpage=${p}&month=${month}">${p}</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item"><a class="page-link" href="orderList.od?cpage=${p}">${p}</a></li> 
                                </c:otherwise>    
                            </c:choose>
                        </c:if>
                    </c:forEach>

                    <c:choose>                                      
                        <c:when test="${pi.currentPage eq pi.maxPage or empty list}">
                            <li class="page-item disabled"><a class="page-link" href="#">다음</a></li>
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${not empty keyword}">
                                    <li class="page-item"><a class="page-link" href="search.od?cpage=${pi.currentPage + 1}&keyword=${keyword}">다음</a></li>
                                </c:when>
                                <c:when test="${not empty year}">
                                    <li class="page-item"><a class="page-link" href="search.od?cpage=${pi.currentPage + 1}&year=${year}">다음</a></li>
                                </c:when>
                                <c:when test="${ not empty month}">
                                    <li class="page-item"><a class="page-link" href="search.od?cpage=${pi.currentPage + 1}&month=${month}">다음</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item"><a class="page-link" href="orderList.od?cpage=${pi.currentPage + 1}">다음</a></li>
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                </ul> 

        </div>    

    
    </div>

    <script>  
        // 주문 취소하기 팝업창
        function cancle(e){
            //주문번호 가져오기
            var $orderNo = $(e).attr('data-orderNo');
            window.open('orderCancelForm.od?orderNo=' + $orderNo,'주문 취소','width=550,height=505,location=no,status=no,scrollbars=yes');
        }
        
        $(function(){
            // 키워드 검색 이벤트 일어날때
            $('#searchForm').submit(function(){
                if($('.keyword').val() == false){
                    alert('마켓 이름을 입력해 주세요.');
                    return false;
                }
                return true;
            })

            // 현재 해당 메뉴바 CSS효과주기 
            $('#orderList').addClass('current');           

		})
	
    </script>

 
    <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>	
	<br><br>

</body>
</html>