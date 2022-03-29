<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 관리</title>
<style>
    .reBtn{
        color: black;
        font-weight: bolder;
    }
    .reBtn:hover{color: rgb(255, 163, 63);}
</style>
<link rel="stylesheet" href="resources/css/user/customer/myReviewList.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>
	
	
   
	<div class="outer" align="center" style="height: 1000px;">

        <jsp:include page="/WEB-INF/views/user/common/buyerMyPageMenuBar.jsp"/>

        <br><br>
        <h2 style="font-weight: bolder;" >&nbsp;&nbsp;리뷰 관리</h2>
        <br>
        <h6 style="font-weight: bolder;" >&nbsp;&nbsp;내가 작성한 리뷰(<span id="rcount"></span>)</h6>

          <hr class="divider"> <!-- 구분선 / 위는 상품 요약, 옵션선택 주문 영역 아래는 상품 리뷰영역-->

          <!-- 상품리뷰 영역 -->
          <div class="review" style="margin-left: 260px;">
            <table align="center">
                <thead>

                </thead>
              </table>
          </div>

          <hr class="divider"> <!-- 구분선 -->

	</div>

    <!-- 리뷰 수정용 모달 -->
    <div class="modal" id="myModal">
        <div class="modal-dialog">
        <div class="modal-content">
        
            <div class="modal-header">
            <h4 class="modal-title">리뷰 수정</h4>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            
            <div class="modal-body">
                <form id="" action="updateReview.cs" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="reviewNo" id="rNo"> <!-- 리뷰번호 -->
                    <table align="center">
                        <tr>
                            <td><!-- 별점 -->
                                <span class="star">
                                    ★★★★★
                                    <span>★★★★★</span>
                                    <input type="range" name="score" id="rStar" oninput="drawStar(this)" value="" step="1" min="0" max="5">
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td><!-- 리뷰내용 -->
                                <textarea name="reviewContent" id="rCon" cols="40" rows="6" style="resize: none;" class="form-control"></textarea> 
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="file" name="reThumbnail" class="form-control-file border"> <!-- 리뷰이미지 -->
                                <input id="oImg" type="hidden" name="originFilePath"> <!-- 기존 등록한 이미지 저장경로 -->
                            </td>
                        </tr>
                        <tr>
                            <td>
                                기존 이미지 : <a id="rImg" href="" download=""></a> <!-- 기존에 등록한 이미지원본명 보여주기 -->
                            </td>
                        </tr>
                    </table>
                        <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">수정</button> <!-- 리뷰수정 버튼 -->
                        </div>
                </form>
            </div>
            
        </div>
        </div>
    </div>

    <script>
        const drawStar = (target) => { // 리뷰작성 폼에서 사용자가 클릭 or 드래그 한 만큼 별점 보여지도록 함
            document.querySelector('.star span').style.width = $('#rStar').val() * 20 + '%';
        }
    </script>


    <script>
        $(document).on("click", ".img", function(){ // 리뷰 이미지를 클릭하면 해당 상품상세 페이지로 이동

            location.href = 'saladDetailView.cmm?pno='+ this.alt;

        })
    </script>


    <script>

        $(function(){ // 문서가 로드되면

            selectMyReviewList();

        })
        
            function selectMyReviewList(){ // 상품 리뷰 조회 AJAX
				
				$.ajax({
					url : "myReviewList.cs", // 요청 URL
					data : {mno : '${ loginUser.userNo }'}, // 상품번호 값으로 비동기식 요청
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
                                result += "<td style='text-align: center; width: 70px;'><img src='" + list[i].changeName + "' style='width: 130px; height: 100px' class='img' alt=" + list[i].refPno + "></td>"    
                                result += "<td style='text-align: center; width:90px;'>" + list[i].userId + "</td>"
                                result += "<td style='text-align: center; width: 150px;'>" + starRate + "</td>"
                                result += "<td style='text-align: left; width:320px;'>" + list[i].reviewContent + "</td>"
                                result += "<td style='text-align: center; width: 150px;'>" + list[i].createDate + "</td>"
                                result += "<td style='width:60px'><a onclick='updateReviewForm(" + list[i].reviewNo + ");' data-toggle='modal' data-target='#myModal' class='reBtn' style='text-decoration: none;'>수정 &nbsp; |</a></td>" 
                                result += "<td style='width:60px'><a onclick='deleteReview(" + list[i].reviewNo + ");' class='reBtn' style='text-decoration: none;'>삭제</a></td>"
                                result += "</tr>"
                            }                            
                            $(".review thead").html(result); // 리뷰 영역에 삽입
                            $("#rcount").text(list.length); // 리뷰 개수 노출영역에 삽입

                        }
                        else { // 해당 상품에 등록된 리뷰가 없는 경우
                            result += "<tr><td colspan='9' style='pointer-events: none; width:600px; text-align: center;'>작성한 상품 리뷰가 없습니다.</td></tr>"
                            $(".review thead").html(result);
                            $("#rcount").text(list.length);
                        }
	                },
	                error : function(){
	                    console.log("상품리뷰 조회 AJAX 실패")
	                }
				})
			}
    </script>

    <script>

        function deleteReview(rno){ // 리뷰 삭제

            if(confirm('리뷰를 삭제 하시겠습니까?')){
                $.ajax({
                    url : "deleteReview.cs",
                    data : { rno : rno}, // 리뷰 번호
                    success : function(result){
                        
                        if(result > 0){

                            selectMyReviewList();
                        }
                    },
                    error : function(){

                        console.log("상품리뷰 삭제 AJAX 실패")
                    }
                })
            }
        }
        function updateReviewForm(rno){ // 리뷰 수정 폼 띄우기 (모달)

            $.ajax({
                    url : "selectReview.cs",
                    data : { rno : rno  // 리뷰 번호          
                    },
                    success : function(result){ 
                        
                        // 조회 해온 리뷰내용을 수정 폼에 값을 넣어 보여주도록 함
                        $('#rNo').val(result.reviewNo);
                        $('#rCon').text(result.reviewContent);
                        $('#rStar').val(result.score);
                        drawStar(result.score);
                        $('#rImg').attr('href', result.changeName).attr('download',result.originName).text(result.originName);
                        $('#oImg').val(result.changeName);
                    },
                    error : function(){

                        console.log("상품리뷰 조회 AJAX 실패")
                    }
                })
        }

        function updateReview(rno){ // 리뷰 수정

            if(confirm('리뷰를 수정 하시겠습니까?')){
                $.ajax({
                    url : "",
                    data : { rno : rno // 리뷰 번호  /  별점, 사진, 내용
                             
                    },
                    success : function(result){
                        
                        if(result > 0){

                            selectMyReviewList();
                        }
                    },
                    error : function(){

                        console.log("상품리뷰 삭제 AJAX 실패")
                    }
                })
            }
        }
        
    </script>
	
	<jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>	
</body>
</html>