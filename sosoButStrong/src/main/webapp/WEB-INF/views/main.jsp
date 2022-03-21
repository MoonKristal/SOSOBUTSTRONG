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

			<div class="recipe">

			</div>

			<div clas="vanner">

			</div>

			<div class="seller">

			</div>

			<div class="chatting">

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