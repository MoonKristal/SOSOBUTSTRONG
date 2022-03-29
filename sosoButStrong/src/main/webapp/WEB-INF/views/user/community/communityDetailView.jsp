<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 상세</title>
<link rel="stylesheet" href="resources/css/user/community/communityDetailView.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/user/common/header.jsp"/>
    <div class="wrap">
        <div class="content1">
            <div class="content1_1">
                <div class="title">
                    ${ coA.comTitle }
                </div>
                <div class="writer">
                    ${ coA.userId } 님
                </div>
            </div>
            <hr>
            <div class="content1_2">
                <div class="imgDiv">
                    <div class="salPic">
                        <c:choose>
                           	<c:when test="${ empty coA.changeName }">
                           		<div>NO IMAGE</div>
                           	</c:when>
                           	<c:otherwise>
                               	<img src="${ coA.changeName }" class="salImg">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="likes">
                        <a onclick="saladLike()" id="saladLike">
                            <c:choose>
                                <c:when test="${ like.myLike eq 'Y'}">
                                    <img src="resources/images/하트.png" class="like fullHeart" id="fullHeart" alt="좋아요">
                                </c:when>
                                <c:otherwise>
                                    <img src="resources/images/빈하트.png" class="like emptyHeart" id="emptyHeart" alt="좋아요">
                                </c:otherwise>
                            </c:choose>
                        </a>
                       	<b>${ like.likeCount }</b>
                    </div>
                </div>
            </div>
            <br clear="both">
            <div class="content1_3">
                <div class="content_header">
                    샐러드명 : <br>
                    샐러드 재료 : <br>
                    샐러드 소스 : <br>
                    샐러드 소개 : <br>
                </div>
                <div class="content_input">
                    <div class="contents1">
                        ${ coA.saladName } <br>
                        ${ coA.saladMaterial } <br>
                        ${ coA.saladSauce } <br>
                    </div>
                    <div class="contents2">
                        <p>
                            ${ coA.saladComment }
                        </p>
                    </div>
                </div>
            </div>
            <br clear="both">
            <div class="createDate">
                ${ coA.createDate }
            </div>
            <hr>
            <div class="btnArea">
                <div class="btnAreaDiv">
                    <c:choose>
                        <c:when test="${ loginUser.userId eq coA.userId }">
                            <a type="submit" class="btn btn-outline-secondary" onclick="postFormSubmit(1);">수정하기</a>
                            <button type="submit" class="btn btn-outline-danger" onclick="postFormSubmit(2);">삭제하기</button>
                        </c:when>
                        <c:when test="${ not empty loginUser }">
                            <button type="submit" class="btn btn-outline-secondary" data-toggle="modal" data-target="#myModal">신고하기</button>
                        </c:when>
                    </c:choose>
                    <a class="btn btn-outline-warning" href="communityList.co">목록가기</a>
                </div>
            </div>
        </div>

        <form action="post" action="" id="postForm">
            <input type="hidden" name="cno" value="${coA.comNo}">
            <input type="hidden" name="filePath" value="${coA.changeName}">
        </form>

        <div class="content2">
            <div class="content2_1">
                <c:choose>
                    <c:when test="${ empty loginUser }">
                        <!-- 로그인 전-->
                        <input type="text" name="replyContent" id="replyContent" placeholder="로그인 후 이용해주세요." readonly>
                        <button class="btn btn-warning disabled" onclick="addReply();">댓글등록</button>
                    </c:when>
                    <c:otherwise>
                        <!-- 로그인 후 -->
                        <input type="text" name="replyContent" id="replyContent" placeholder="댓글을 입력해주세요.">
                        <button class="btn btn-warning" onclick="addReply();">댓글등록</button>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="content2_2">
                <table class="replyArea" align="center">
                    <tbody>
                        
                    </tbody>
                </table>
            </div>
        </div>
        <div style="height: 200px;"></div>
    </div>

    <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>
    
    <!-- 게시글 신고 모달창 -->
	<!-- The Modal -->
	<div class="modal fade" id="myModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">
                    <b>게시글 신고하기</b>
                </h4>
                <hr>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            
            <form action="reportCommunity.re" method="post">
                <!-- Modal body -->
                <div class="modal-body">
                    글제목 |  ${ coA.comTitle }<br>
                    작성자 |  ${ coA.userId } <br>
                    <hr>
                    <h5>사유선택</h5>
                    <input type="radio" name="reason" id="reason1" value="duplicate writing"><label for="reason1"> 스팸홍보 / 도배글입니다.</label><br>
                    <input type="radio" name="reason" id="reason2" value="illegality"><label for="reason2"> 불법정보를 포함하고 있습니다.</label><br>
                    <input type="radio" name="reason" id="reason3" value="harmful"><label for="reason3"> 청소년에게 유해한 내용입니다.</label><br>
                    <input type="radio" name="reason" id="reason4" value="badWord"><label for="reason4"> 욕설 / 생명경시 / 혐오 / 차별적 표현입니다.</label><br>
                    <input type="radio" name="reason" id="reason5" value="personal infomation"><label for="reason5"> 개인정보 노출 개시물입니다.</label><br>
                    <input type="radio" name="reason" id="reason6" value="unpleasant expression"><label for="reason6"> 불쾌한 표현이 있습니다.</label><br>
                    <br>
                    <input type="hidden" name="userNo" value="${loginUser.userNo}">
                    <input type="hidden" name="reportCom" value="${coA.comNo}">
                </div>
            
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</button>
                    <button type="submit" class="btn btn-danger">신고하기</button>
                </div>
            </form>
	    </div>
	  </div>
	</div>

    <!-- 댓글 신고 모달창 -->
	<!-- The Modal -->
	<div class="modal fade" id="myModal2">
        <div class="modal-dialog">
          <div class="modal-content">
              <!-- Modal Header -->
              <div class="modal-header">
                  <h4 class="modal-title">
                      <b>댓글 신고하기</b>
                  </h4>
                  <hr>
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
              </div>
              
              <form action="reportReply.re" method="post">
                  <!-- Modal body -->
                  <div class="modal-body">
                      <h5>사유선택</h5>
                      <input type="radio" name="reason" id="replyReason1" value="duplicate writing"><label for="replyReason1"> 스팸홍보 / 도배글입니다.</label><br>
                      <input type="radio" name="reason" id="replyReason2" value="illegality"><label for="replyReason2"> 불법정보를 포함하고 있습니다.</label><br>
                      <input type="radio" name="reason" id="replyReason3" value="harmful"><label for="replyReason3"> 청소년에게 유해한 내용입니다.</label><br>
                      <input type="radio" name="reason" id="replyReason4" value="badWord"><label for="replyReason4"> 욕설 / 생명경시 / 혐오 / 차별적 표현입니다.</label><br>
                      <input type="radio" name="reason" id="replyReason5" value="personal infomation"><label for="replyReason5"> 개인정보 노출 개시물입니다.</label><br>
                      <input type="radio" name="reason" id="replyReason6" value="unpleasant expression"><label for="replyReason6"> 불쾌한 표현이 있습니다.</label><br>
                      <br>
                      <input type="hidden" name="reportCom" value="${coA.comNo}">
                      <input type="hidden" name="userNo" value="${coA.userNo}">
                      <input type="hidden" name="reportRep">
                  </div>
              
                  <!-- Modal footer -->
                  <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</button>
                      <button type="submit" class="btn btn-danger">신고하기</button>
                  </div>
              </form>
          </div>
        </div>
      </div>
    
    
    <script>
    	$(function(){
    		selectReplyList();
            
    	})
    	
    	function addReply(){
    		if($("#replyContent").val().trim() != 0){
    			$.ajax({
    				url : "replyInsert.co",
    				data : {
    					refComNo : '${ coA.comNo }',
    					replyContent : $("#replyContent").val(),
			    		userNo : '${ loginUser.userNo}'
    				}, success : function(status){
    					console.log(status);
    					if(status == "success"){
    						selectReplyList();
    						$("#replyContent").val("");
    					}
   					}, error : function(){
   						console.log("댓글 작성 실패");
    				}
    			})
    		} 
    		else{
    			alert("댓글을 작성해주세요.");
    		}
    	}
    	
    	function selectReplyList(){
    		$.ajax({
    			url : "replyList.co",
    			data : {
    				refComNo : '${ coA.comNo }'
    			},
    			success : function(list){
                    let value = "";
                    for(let i in list){
                        value += "<tr style='height: 50px'>"
                                    + "<td style='width: 120px'>" + list[i].userId + "</td>"
                                    + "<td style='width: 300px'>" + list[i].replyContent + "</td>"
                                    + "<td style='width: 200px'>" + list[i].createDate + "</td>"
                                    + "<td style='width: 100px'>" + "<button type='submit' class='rebutton btn btn-outline-secondary' data-replyNo='" + list[i].replyNo + "' data-login='${loginUser.userNo}' data-toggle='modal' data-target='#myModal2'>신고</button>" + "</td>"
                                + "</tr>";
                    }
                    $(".replyArea tbody").html(value);
                    var rebuttonVal = $('.rebutton').attr('data-replyNo');
                    $('input[name=reportRep]').val(rebuttonVal);

    			}, error : function(){
    				console.log("댓글 조회 실패");
    			}
    		})
    	}
	
    	function saladLike(){
            var status = $("#saladLike").children().eq(0).attr('id');

    		if(status == "fullHeart"){
    			isLike = "Y";
    		} else {
                isLike = "N"; 
            }
    		
            if(${ not empty loginUser}){
                $.ajax({
                    url : 'like.he',
                    data : {
                        'isLike' : isLike,
                        'comNo' : '${ coA.comNo}'
                    }, success : function(result){
                    	console.log(result);
                        if(result > 0){
                            if(isLike == 'Y'){
                                $("#saladLike").children().eq(0).replaceWith($('img.emptyHeart'));
                                $("#saladLike>b").text(Number($('#saladLike>b').text())-1);
                                location.reload();
                            } else{
                                $("#saladLike").children().eq(0).replaceWith($('img.fullHeart'));
                                $("#saladLike>b").text(Number($('#saladLike>b').text())+1);
                                location.reload();
                            }
                        }
                    }

                })
            }
    	}

        function postFormSubmit(num){
            if(num == 1){
                $("#postForm").attr("action", "recipeUpdateForm.co").submit();
            } else {
                $("#postForm").attr("action", "recipeDelete.co").submit();

            }

        }
    	

       
        

    </script>
    
    
    
    
    
    
    

</body>
</html>