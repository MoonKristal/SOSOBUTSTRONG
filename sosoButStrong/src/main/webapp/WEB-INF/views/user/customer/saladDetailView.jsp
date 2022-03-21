<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>샐러드 상품 상세보기</title>
<link rel="stylesheet" href="resources/css/user/customer/saladDetailView.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/user/common/header.jsp"/>
	
    <br><br><br><br>
	<div class="outer" align="center">
        <div class="container marketing">
               <div class="row">
           <div class="col-xs-1 col-md-1"></div>
              <div class="col-sm-5">
               <img src="${ c.changeName }" width="350" height="350"> <!-- 상품이미지(썸네일) -->
              </div>
              
              <div class="col-sm-5">
               
               <table class="table table-borderless">
                <tr>
                    <th style="font-size: large;">${ c.productName } &nbsp; ${ c.price } 원</th>
                </tr>
                <tr>
                    <td>${ c.sellerName }</td>
                </tr>
                <tr>
                    <td>${ c.sellerIntro }</td>
                </tr>
                <tr>
                    <td>${ c.sellerLocation }</td>
                </tr>
                <tr>
                    <td>${ c.sellerPhone }</td>
                </tr>
                <tr>
                    <td>
						<select class="form-control" name="options">
                            <option selected disabled>샐러드 재료를 골라주세요 1. (중복선택 가능) </option>
							<c:forEach var="opts" items="${ c.option }">
                                <option value="opts">${opts}</option>
                            </c:forEach>
						</select>
                    </td>
                </tr>
                <tr>
                    <td>
						<select class="form-control" name="options">
                            <option selected disabled>샐러드 재료를 골라주세요 2. (중복선택 가능) </option>
							<c:forEach var="opts" items="${ c.option }">
                                <option value="opts">${opts}</option>
                            </c:forEach>
						</select>
                    </td>
                </tr>
                <tr>
                    <td>
						<select class="form-control" name="options">
                            <option selected disabled>샐러드 재료를 골라주세요 3. (중복선택 가능) </option>
							<c:forEach var="opts" items="${ c.option }">
                                <option value="opts">${opts}</option>
                            </c:forEach>
						</select>
                    </td>
                </tr>
                <tr>
                    <td>
						<select class="form-control" name="options">
                            <option selected disabled>샐러드 재료를 골라주세요 4. (중복선택 가능) </option>
							<c:forEach var="opts" items="${ c.option }">
                                <option value="opts">${opts}</option>
                            </c:forEach>
						</select>
                    </td>
                </tr>
                <tr>
                    <td>
						<select class="form-control" name="options">
                            <option selected disabled>샐러드 재료를 골라주세요 5. (중복선택 가능) </option>
							<c:forEach var="opts" items="${ c.option }">
                                <option value="opts">${opts}</option>
                            </c:forEach>
						</select>
                    </td>
                </tr>
                <tr>
                    <td>
						<select class="form-control" name="options">
                            <option selected disabled>샐러드 재료를 골라주세요 6. (중복선택 가능) </option>
							<c:forEach var="opts" items="${ c.option }">
                                <option value="opts">${opts}</option>
                            </c:forEach>
						</select>
                    </td>
                </tr>
                <tr>
                    <td><a href="#" class="btn btn-outline-success" style="font-weight: bolder;">주문하기</a> &nbsp;&nbsp;
                        <a href="#" class="btn btn-outline-info" style="font-weight: bolder;">장바구니</a>
                    </td>
                </tr>
               </table>
              </div>
          </div>      
          
          <hr class="divider">

          <!-- 상품리뷰 영역 -->
          <div id="review">
            <table align="center">
                <thead>
    
                </thead>
                <tbody>
    
                </tbody>
              </table>
          </div>
          
          <hr class="divider">

            <div id="detail-img-text-box">
                <pre cols="120" rows="25">${ c.description }</pre> <!-- 상품 상세페이지 영역-->
            </div>

            <table class="pInfo" align="center"> <!-- 상품정보고시 영역-->
                <tr class="pInfoTitle">
                    <th>필수표기정보</th>
                    <th>&nbsp;허위사실 기재 및 정보 오류로 인한 문제 발생시 관련법에 의거 처벌 받을 수 있습니다.&nbsp;</th>
                </tr>
                <tr>
                    <td style="text-align: center;">제품명</td>
                    <td>&nbsp;&nbsp;${ c.productName }</td>
                </tr>
                <tr>
                    <td style="text-align: center;">생산자 및 소재지</td>
                    <td>&nbsp;&nbsp;${ c.sellerName } / ${ c.sellerLocation }</td>
                </tr>
                <tr>
                    <td style="text-align: center;">&nbsp;제조일자 / 유통기한&nbsp;</td>
                    <td>&nbsp;&nbsp;상세페이지 참조</td>
                </tr>
                <tr>
                    <td style="text-align: center;">원재료명 및 함량</td>
                    <td>&nbsp;&nbsp;상세페이지 참조</td>
                </tr>
            </table>
	</div>

    <script>
        $(function(){



        })

    </script>
	
    <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>	
</body>
</html>


