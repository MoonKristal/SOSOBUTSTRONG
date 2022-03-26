<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>샐러드 상세보기-리뷰상세</title>
<link rel="stylesheet" href="resources/css/user/customer/saladDetailView.css">
<link rel="stylesheet" href="resources/css/user/customer/saladDetailViewReviewDetail.css">
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
                    <th style="font-size:x-large;">${ c.productName } &nbsp; ${ c.price } 원</th>
                </tr>
                <tr>
                    <td><img src="${ c.sellerImagePath }" width="70" height="70" alt="판매자대표이미지">&nbsp;&nbsp;<b>${ c.sellerName }</b></td>
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
                    <td>
                        <!-- 주문하기 누르면, 위 6가지 옵션 값 가지고 주문화면으로 넘어갈 것, 옵션 6개 전부 선택해야 주문정보화면으로 넘어가게 제약을 걸어야 함 -->
                        <a href="#" class="btn btn-outline-success" style="font-weight: bolder;">주문하기</a> &nbsp;&nbsp;
                        <a href="#" class="btn btn-outline-info" style="font-weight: bolder;">장바구니</a>
                        <!-- 장바구니 누르면 AJAX(비동기식)으로 , 위 옵션값 장바구니에 저장시키기 중복저장 가능, 단 옵션6개 전부 선택해야함 -->
                    </td>
                </tr>
               </table>
              </div>
          </div>      
          
          <hr class="divider"> <!-- 구분선 / 위는 상품 요약, 옵션선택 주문 영역 아래는 상품 리뷰영역-->

          <!-- 상품리뷰 영역 -->
          <div class="review">
            <table align="center">
                <thead>
                    <tr><th colspan="2">구매자 리뷰 전체보기 (<span id="rcount"></span>)</th><th colspan="3" style="text-align: right;"><a href="javascript:history.back();">상품상세 페이지로</a></th></tr>
                    <tr><th>&nbsp;</th></tr>
                    <tr><th>&nbsp;</th></tr>
    
                </thead>
              </table>
          </div>

            <!-- 상품리뷰 이미지 원본크기로 보기, 모달 영역 -->
            <div class="modal fade" id="myModal" role="dialog">
                <div class="modal-dialog">
                
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="title"></h4>
                    </div>
                    <div class="modal-body">
                        <img src="" alt="상품리뷰사진" id="rImage">
                    </div>
                </div>
                
                </div>
            </div>

            <script>
                $(document).on("click", ".img", function(){ // 상품리뷰에 첨부된 이미지를 클릭하면
        
                    $("#rImage").attr('src', this.src); // 클릭한 이미지의 src 속성을 모달창 속 이미지 태그의 src 속성의 밸류값으로 변경
        
                    $("#myModal").modal('show'); // 모달 창 띄우기
                })
            </script>


          <hr class="divider"> <!-- 구분선 -->

	</div>

    <script>

        $(function(){ // 문서가 로드되면

            selectProductReviewList(); // 상품리뷰 조회해오는 메소드를 실행

        })
        
            function selectProductReviewList(){ // 상품 리뷰 조회 AJAX
				
				$.ajax({
					url : "reviewList.cmm", // 요청 URL
					data : {pno : '${ c.productNo }'}, // 상품번호 값으로 비동기식 요청
					success : function(list){

	                	let result = ""; // 리뷰내용 저장할 변수 선언

                        let starRate = ""; // 별점 별문양 저장할 변수 선언

                        if(list.length != 0){ // 해당 상품에 등록된 리뷰가 있는 경우

                            for(let i in list){ // for 문 사용 , 최근 리뷰 3건만 나오도록, 전체 리뷰는 리뷰 상세보기로 이동시 열람가능

                                switch(list[i].score){ // 별점 화면상 숫자문양으로 변환하기 위한 조건문
                                    case 0 : starRate = '☆☆☆☆☆'; break;
                                    case 1 : starRate = '⭐☆☆☆☆'; break;
                                    case 2 : starRate = '⭐⭐☆☆☆'; break;
                                    case 3 : starRate = '⭐⭐⭐☆☆'; break;
                                    case 4 : starRate = '⭐⭐⭐⭐☆'; break;
                                    case 5 : starRate = '⭐⭐⭐⭐⭐'; 
                                }
                                // 문자열 누적
                                result += "<tr>"
                                result += "<td style='text-align: center; width: 70px;'><img src='" + list[i].changeName + "' style='width: 130px; height: 100px' class='img' ></td>"    
                                result += "<td style='text-align: center; width:90px;'>" + list[i].userId + "</td>"
                                result += "<td style='text-align: center; width: 150px;'>" + starRate + "</td>"
                                result += "<td style='text-align: left; width:370px;'>" + list[i].reviewContent + "</td>"
                                result += "<td style='text-align: center; width: 150px;'>" + list[i].createDate + "</td>"
                                result += "</tr>"
                            }
                            
                            $(".review thead").append(result); // 리뷰 영역에 삽입
                            $("#rcount").text(list.length); // 리뷰 개수 노출영역에 삽입

                        }
                        else { // 해당 상품에 등록된 리뷰가 없는 경우
                            result += "<tr><td colspan='9' style='pointer-events: none; width:600px; text-align: center;'>등록된 상품 리뷰가 없습니다.</td></tr>"
                            $(".review thead").append(result);
                            $("#rcount").text(list.length);
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