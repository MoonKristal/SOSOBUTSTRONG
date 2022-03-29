<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>샐러드 판매리스트</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/5.1/examples/album/">


    <!-- Bootstrap core CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <!-- Favicons -->
<link rel="apple-touch-icon" href="/docs/5.1/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
<link rel="manifest" href="/docs/5.1/assets/img/favicons/manifest.json">
<link rel="mask-icon" href="/docs/5.1/assets/img/favicons/safari-pinned-tab.svg" color="#7952b3">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon.ico">
<meta name="theme-color" content="#7952b3">

<style>
  .bd-placeholder-img {
    font-size: 1.125rem;
    text-anchor: middle;
    -webkit-user-select: none;
    -moz-user-select: none;
    user-select: none;
  }
  @media (min-width: 768px) {
    .bd-placeholder-img-lg {
      font-size: 3.5rem;
    }
  }
  .salad:hover{
      cursor: pointer;
      opacity:0.5;
      }
</style>

  </head>
  <body>
    <jsp:include page="/WEB-INF/views/user/common/header.jsp"/>

<br>
<main>
  <div class="album py-5 bg-light">
    <div class="container">
      <h2 style="font-weight: bolder; color:rgb(182, 238, 86);">SALAD LIST</h2>
      <br>
      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3">
        
        <c:if test="${not empty list}">
            <c:forEach var="c" items="${ list }">
                <div class="col salad">
                    <input type="hidden" value="${ c.productNo }"> <!-- 상품번호 -->
                    <div class="card shadow-sm">
                        <svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false">
                            <image href="${ c.changeName }" alt="이건 샐러드 썸녤" height="225" width="253"/>
                        </svg>

                        <div class="card-body">
                            <p class="card-text" style="text-align: center;">
                              <span style="font-style: italic; color: gray;">[${ c.sellerName }]</span> <br>
                              <span style="font-weight: bold;">${ c.productName }</span> <br>
                              <span style="font-weight: bolder; color: green;">${ c.price } 원</span>
                            </p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>

      </div>
        <br>
        <p class="btn btn-secondary">
            <a href="#" style="color:white">TOP</a>
        </p>
    </div>
  </div>
</main>

    <script>
		$(function(){
			$(".salad").click(function(){ // 상품 썸네일 클릭 시 상세보기 요청

				var pno = $(this).children().eq(0).val();

				location.href = "saladDetailView.cmm?pno=" + pno;
			})
		})
	</script>

    <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>	

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
      
  </body>
</html>