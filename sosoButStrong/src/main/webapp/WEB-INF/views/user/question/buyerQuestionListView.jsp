<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매자 1:1문의 내역</title>
<link rel="stylesheet" href="resources/css/user/question/buyerQuestionListView.css">
</head>
<body>

	<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>
	
	<!--2022.3.7(월) 14h25
		http://localhost:8765/wemasal/WEB-INF/views/user/question/buyerQuestionListView.jsp-->
    <div class="outer">
        
        <!--구매자 마이페이지 좌측 메뉴바-->
        <jsp:include page="/WEB-INF/views/user/common/buyerMyPageMenuBar.jsp"/>

        <div class="content">
			<!-- 여기는 content div입니다 -->
            <h2>1:1문의 내역</h2>

            <br>
            <button class="orangeBtn" onclick="location.href='enrollForm.qu'" style="float:right;">문의 글 등록</button>

            <div id="search-area"> 
                <form action="buyerSearch.bo">




                </form>


            </div>




            <form action="">
                <div id="search-area">
                    <form action="search.bo">
                        <input type="hidden" name="currentPage" value="1">
                        <select name="condition">
                            <option value="writer">작성자</option>
                            <option value="title">제목</option>
                            <option value="content">내용</option>
                        </select>
                        <input type="text" name="keyword" value="${ keyword }"> <!--사용자가 검색하고자 입력했던 keyword가 input 입력난에 남아있도록 함-->
                        <button type="submit">검색</button>
                    </form>
                </div>






            </form>
            <input type="text">
        



        </div>

    </div>

</body>
</html>