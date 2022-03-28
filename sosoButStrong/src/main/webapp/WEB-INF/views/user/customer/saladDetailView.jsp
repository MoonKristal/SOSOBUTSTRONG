<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>샐러드 상세보기</title>
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
               
               <form method="post" onsubmit="return checkLogin();"> <!-- 주문/장바구니 영역 -->
                    <table class="table table-borderless">
                        <tr>
                            <th style="font-size:x-large;">${ c.productName } &nbsp; <span style="color: green;">${ c.price } 원</span></th>
                            <input type="hidden" name="productNo" value="${ c.productNo }"> <!-- 상품번호 -->
                            <input type="hidden" name="userNo" value="${ loginUser.userNo }"> <!-- 구매자(유저번호) -->
                            <input type="hidden" name="productName" value="${ c.productName }"> <!-- 상품번호 -->
                            <input type="hidden" name="price" value="${ c.price }"> <!-- 상품가격 -->
                            <input type="hidden" name="quantity" value="1"> <!-- 수량 -->
                        </tr>
                        <tr>
                            <td><img src="${ c.sellerImagePath }" width="70" height="70" alt="판매자대표이미지">&nbsp;&nbsp;<b style="font-style: italic; color: gray;">[${ c.sellerName }]</b></td>
                        </tr>
                        <tr class="sellerInfo">
                            <td>사업자 등록번호 : ${ c.sellerBrn }</td>
                        </tr>
                        <tr class="sellerInfo">
                            <td>${ c.sellerIntro }</td>
                        </tr>
                        <tr class="sellerInfo">
                            <td>${ c.sellerLocation }</td>
                        </tr>
                        <tr class="sellerInfo">
                            <td>TEL. ${ c.sellerPhone }</td>
                        </tr>

                        <!-- 상품 구매 옵션 영역, 6가지 -->
                        <tr>
                            <td>
                                <select class="form-control" name="option" required>
                                    <option value="" selected disabled>샐러드 재료를 골라주세요 1. (중복선택 가능) </option>
                                    <c:forEach var="opts" items="${ c.option }">
                                        <option value="${opts}">${opts}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <select class="form-control" name="option" required>
                                    <option value="" selected disabled>샐러드 재료를 골라주세요 2. (중복선택 가능) </option>
                                    <c:forEach var="opts" items="${ c.option }">
                                        <option value="${opts}">${opts}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <select class="form-control" name="option" required>
                                    <option value="" selected disabled>샐러드 재료를 골라주세요 3. (중복선택 가능) </option>
                                    <c:forEach var="opts" items="${ c.option }">
                                        <option value="${opts}">${opts}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <select class="form-control" name="option" required>
                                    <option value="" selected disabled>샐러드 재료를 골라주세요 4. (중복선택 가능) </option>
                                    <c:forEach var="opts" items="${ c.option }">
                                        <option value="${opts}">${opts}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <select class="form-control" name="option" required>
                                    <option value="" selected disabled>샐러드 재료를 골라주세요 5. (중복선택 가능) </option>
                                    <c:forEach var="opts" items="${ c.option }">
                                        <option value="${opts}">${opts}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <select class="form-control" name="option" required>
                                    <option value="" selected disabled>샐러드 재료를 골라주세요 6. (중복선택 가능) </option>
                                    <c:forEach var="opts" items="${ c.option }">
                                        <option value="${opts}">${opts}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><!-- 로그인한 회원유형이 판매자가 아니면 아래 주문,장바구니 버튼이 노출 , 단 비로그인 유저는 주문,장바구니 버튼 누르면 로그인페이지로 넘김-->
                                <c:if test="${loginUser.userType ne 2}"> 
                                    <button type="submit" formaction="orderNow.cs" style="font-weight: bolder; width: 200px;" class="btn btn-outline-success">주문하기</button> &nbsp;&nbsp;
                                    <button type="submit" formaction="addCart.cs" style="font-weight: bolder; width: 200px;" class="btn btn-outline-info">장바구니</button>
                                </c:if>
                            </td>
                        </tr>
                    </table>
                </form>

              </div>
          </div>      
          
          <hr class="divider"> <!-- 구분선 / 위는 상품 요약, 옵션선택 주문 영역 아래는 상품 리뷰영역-->

          <!-- 상품리뷰 영역 -->
          <div class="review">
            <table align="center">
                <thead>
                    <tr><th colspan="2">구매자 리뷰(<span id="rcount"></span>)</th><th colspan="3" style="text-align: right;"><a class="moreReview" href="reviewDetailView.cmm?pno=${c.productNo}">MORE</a></th></tr>
                    <tr><th>&nbsp;</th></tr>
    
                </thead>
                <tbody>
    
                </tbody>
              </table>
          </div>
          
          <hr class="divider"> <!-- 구분선 / 위는 상품 리뷰영역 아래는 상품상세 및 상품정보고시 영역-->
          
            <img src="resources/uploadFiles/delivery_Info.jpg" alt="배송정보_이미지"><!-- 배송정보 이미지-->
            <br>
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
            <a href="loginPage.me" id="pleaseLogin" style="display: none;"></a>
	</div>

    <script>

        function checkLogin(){ // 비로그인 상태에서 주문 & 장바구니 사용 시 로그인 요청 알림 후 로그인 화면으로 보내기

            var loginUser = '${loginUser}';

            if(loginUser == ""){
                alert('로그인 후 이용하시기 바랍니다.');
                location.href = 'loginPage.me';
                return false;
            }
            return true;
        }

        $(function(){ // 문서가 로드되면

            selectProductReviewList(); // 상품리뷰 조회해오는 메소드
        })

            function selectProductReviewList(){ // 상품 리뷰 조회 AJAX
				
				$.ajax({
					url : "reviewList.cmm", // 요청 URL
					data : {pno : '${ c.productNo }'}, // 상품번호 값으로 비동기식 요청
					success : function(list){

	                	let result = ""; // 리뷰내용 저장할 변수 선언

                        let starRate = ""; // 별점 별문양 저장할 변수 선언

                        if(list.length != 0){ // 해당 상품에 등록된 리뷰가 있는 경우
                             
                            if(list.length == 1 || list.length == 2){

                                for(let i in list){ // for 문 사용 , 최근 리뷰 3건만 나오도록, 전체 리뷰는 리뷰 상세보기로 이동 시 열람가능
                                
                                switch(list[i].score){ // 별점 화면상 숫자 -> 별문양으로 변환하기 위한 조건문
                                    case 0 : starRate = '☆☆☆☆☆'; break;
                                    case 1 : starRate = '⭐☆☆☆☆'; break;
                                    case 2 : starRate = '⭐⭐☆☆☆'; break;
                                    case 3 : starRate = '⭐⭐⭐☆☆'; break;
                                    case 4 : starRate = '⭐⭐⭐⭐☆'; break;
                                    case 5 : starRate = '⭐⭐⭐⭐⭐';
                                }
                                // 문자열 누적
                                result += "<tr>"
                                result += "<td style='text-align: center; width:60px;'>" + list[i].userId + "</td>"
                                result += "<td style='text-align: center; width: 150px;'>" + starRate + "</td>"
                                result += "<td style='text-align: left; width:370px;'>" + list[i].reviewContent + "</td>"
                                result += "<td style='text-align: center; width: 150px;'>" + list[i].createDate + "</td>"
                                result += "<td style='text-align: center; width: 70px;'><img src='" + list[i].changeName + "' style='width: 100px; height:60px;' class='img' ></td>"
                                result += "</tr>"
                            }
                            
                            $(".review thead").append(result); // 리뷰 영역에 삽입
                            $("#rcount").text(list.length); // 리뷰 개수 노출영역에 삽입

                            }
                            else{

                                for(let i = 0; i < 3; i++){ // for 문 사용 , 최근 리뷰 3건만 나오도록, 전체 리뷰는 리뷰 상세보기로 이동 시 열람가능
                                
                                switch(list[i].score){ // 별점 화면상 숫자 -> 별문양으로 변환하기 위한 조건문
                                    case 0 : starRate = '☆☆☆☆☆'; break;
                                    case 1 : starRate = '⭐☆☆☆☆'; break;
                                    case 2 : starRate = '⭐⭐☆☆☆'; break;
                                    case 3 : starRate = '⭐⭐⭐☆☆'; break;
                                    case 4 : starRate = '⭐⭐⭐⭐☆'; break;
                                    case 5 : starRate = '⭐⭐⭐⭐⭐';
                                }
                                // 문자열 누적
                                result += "<tr>"
                                result += "<td style='text-align: center; width:60px;'>" + list[i].userId + "</td>"
                                result += "<td style='text-align: center; width: 150px;'>" + starRate + "</td>"
                                result += "<td style='text-align: left; width:370px;'>" + list[i].reviewContent + "</td>"
                                result += "<td style='text-align: center; width: 150px;'>" + list[i].createDate + "</td>"
                                result += "<td style='text-align: center; width: 70px;'><img src='" + list[i].changeName + "' style='width: 100px; height:60px;' class='img' ></td>"
                                result += "</tr>"
                            }
                            
                            $(".review thead").append(result); // 리뷰 영역에 삽입
                            $("#rcount").text(list.length); // 리뷰 개수 노출영역에 삽입
                                
                            }

                        }
                        else { // 해당 상품에 등록된 리뷰가 없는 경우
                            result += "<tr><td colspan='9' style='pointer-events: none; width:600px; text-align: center;'>등록된 상품 리뷰가 없습니다.</td></tr>"
                            $(".review thead").append(result); // 리뷰 영역에 윗줄 내용(리뷰없음) 삽입
                            $("#rcount").text(list.length);
                            $(".moreReview").attr('style', "display:none;"); // 리뷰 더보기 버튼 안보이도록 설정
                        }
	                },
	                error : function(){
	                    console.log("상품리뷰 조회 AJAX 실패")
	                }
				})
			}
    </script>
	
    <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>	
</body>
</html>


