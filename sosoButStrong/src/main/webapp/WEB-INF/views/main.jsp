<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>위메샐</title>
<link rel="stylesheet" href="resources/css/user/main/main.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>

	<div class="wrap">
		<div class="mainPic">
			<div id="demo" class="carousel slide" data-ride="carousel">
		
			  <!-- Indicators -->
			  <!-- 메인페이지 사진 페이징바 -->
			  <ul class="carousel-indicators">
			  	
			  </ul>
			
			  <!-- The slideshow -->
			  <!-- 메인페이지 사진 영역 -->
			  <div class="carousel-inner">
				
			  </div>
			
			  <!-- Left and right controls -->
			  <a class="carousel-control-prev" href="#demo" data-slide="prev">
				<span class="carousel-control-prev-icon"></span>
			  </a>
			  <a class="carousel-control-next" href="#demo" data-slide="next">
				<span class="carousel-control-next-icon"></span>
			  </a>
			</div>
		</div>

		<div class="bestRecipe">
			<b>TOP3 RECIPE</b>
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
		</div>

		<div class="vanner">
			<div class="point">
				<b>회원가입시 2,000원 적립금 증정</b><br>
				즉시사용 가능
			</div>
		</div>

		<div class="seller">
			<div class="newHeader">
				<div class="newTitle">
					<b>TOP3 Seller</b>
				</div>
			</div>
			<div class="outer">
				<div class="content2">
					<div class="content2_1">
						<div class="imgDiv2">
							<img src="resources/images/루꼴라샐러드.jpg" class="salImg" alt="1등">
						</div>
						<div class="icons">
							<a href="#">
								<img src="resources/images/돋보기.png" alt="더보기">
								<input type="hidden" value="${ co.comNo }">
							</a>
						</div>
					</div>
					<div class="content2_2">
						<div class="title">
							SYS'S의 레시피
						</div>
						<div>
							<p>
								천지는 얼마나 기쁘며 얼마나 아름다우냐? 
								이것을 얼음 속에서 불러 내는 것이 따뜻한 봄바람이다 
								인생에 따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 
							</p>
						</div>
					</div>
				</div>
				<div class="content2">
					<div class="content2_1">
						<div class="imgDiv2">
							<img src="resources/images/루꼴라샐러드.jpg" class="salImg" alt="1등">
						</div>
						<div class="icons">
							<a href="#">
								<img src="resources/images/돋보기.png" alt="더보기">
								<input type="hidden" value="${ co.comNo }">
							</a>
						</div>
					</div>
					<div class="content2_2">
						<div class="title">
							SYS'S의 레시피
						</div>
						<div>
							<p>
								천지는 얼마나 기쁘며 얼마나 아름다우냐? 
								이것을 얼음 속에서 불러 내는 것이 따뜻한 봄바람이다 
								인생에 따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 
							</p>
						</div>
					</div>
				</div>
				<div class="content2">
					<div class="content2_1">
						<div class="imgDiv2">
							<img src="resources/images/루꼴라샐러드.jpg" class="salImg" alt="1등">
						</div>
						<div class="icons">
							<a href="#">
								<img src="resources/images/돋보기.png" alt="더보기">
								<input type="hidden" value="${ co.comNo }">
							</a>
						</div>
					</div>
					<div class="content2_2">
						<div class="title">
							SYS'S의 레시피
						</div>
						<div>
							<p>
								천지는 얼마나 기쁘며 얼마나 아름다우냐? 
								이것을 얼음 속에서 불러 내는 것이 따뜻한 봄바람이다 
								인생에 따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	
	<jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>	


	<div>
		<a href="picListAd.main">메인페이지 관리자</a><br>
	</div>
	
	
	
	
	
	<script>
		$(function(){
			selectMainCount();
			selectMain();
		})
		
		function selectMain(){
			$.ajax({
				url : "picList.main",
				success : function(data){
					
					let value = "";
					for(let i in data){
						
						value += "<div class='carousel-item'>"
								+ "<img src='" + data[i].changeName +"' class='img_src' alt='salad' >" 
								+ "</div>";
								
					}
					$("#demo>.carousel-inner").html(value);
					$("#demo>.carousel-inner").find('div.carousel-item').eq(0).addClass('active');
				}
			})
		}
		
		function selectMainCount(){
			$.ajax({
				url : "picListCount.main",
				success : function(data){
					
					let count = "";
					for(var i = 0; i < data; i++){
						count += "<li data-target='#demo' class='pbar' data-slide-to='" + i + "'></li>";
					}
					$("#demo>.carousel-indicators").html(count);
					$("#demo>.carousel-indicators").find('.pbar').eq(0).addClass('active');
					
				}
			})
		}
			
	</script>
	
	
	
	
	
	
	
	
	

	
</body>
</html>