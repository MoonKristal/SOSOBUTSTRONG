<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 수정</title>
<link rel="stylesheet" href="resources/css/user/community/communityUpdateForm.css">
<script type="text/javascript" src="resources/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
</head>
<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>
    <div class="wrap">
        <div class="content1">
            <div class="title">
                <h3>나만의 레시피 수정</h3>
            </div>
        </div>
        <div class="content2">
            <form action="recipeUpdate.co" method="post" enctype="multipart/form-data">
                <div class="content2_1">
                    <div class="content_wrap1">
                        <div class="content_title">
                            게시글 제목<br>
                            나만의 샐러드 명<br>
                            샐러드 재료<br>
                            샐러드 소스<br>
                            샐러드 이미지<br>
                            샐러드 소개<br>
                        </div>
                        <div class="content_input">
                            <input type="hidden" name="userNo" value="${ loginUser.userNo }"><br>
                            <input type="hidden" name="comNo" value="${coA.comNo }">
                            <input type="text" name="comTitle" class="input_tag" value="${ coA.comTitle }" required><br>
                            <input type="text" name="saladName" class="input_tag" value="${ coA.saladName }" maxlength="15" placeholder="15자 이내로 작성해주세요." required><br>
                            <input type="text" name="saladMaterial" class="input_tag" value="${ coA.saladMaterial }" placeholder="( , )로 구분하여 작성해주세요." required><br>
                            <input type="text" name="saladSauce" class="input_tag" value="${ coA.saladSauce }"><br>
                            <input type="file" id="upfile" name="reupfile"><br>
                            <c:if test="${ not empty coA.originName }">
                            	현재 업로드된 파일 : 
                            	<a href="${ coA.changeName }" download="${ coA.originName }">${ coA.originName }</a>
                            	<input type="hidden" name="fileNo" value="${ coA.fileNo }">
                            	<input type="hidden" name="originName" value="${ coA.originName }">
                            	<input type="hidden" name="changeName" value="${ coA.changeName }">
                            </c:if>
                        </div>
                    </div> 
                    <br clear="both">
                    <div class="content_wrap2">
                        <div class="content_input">
                            <textarea name="saladComment" id="editorTxt" rows="18" cols="94">${ coA.saladComment }</textarea>
                        </div>
                    </div>
                </div>
                <div class="insertBtn">
                    <a class="btn btn-outline-secondary" href="myRecipeListView.co">목록가기</a>
                    <button type="reset" class="btn btn-outline-danger">취소하기</button>
                    <button type="submit" class="btn btn-outline-primary submitBtn">수정하기</button>
                </div>
            </form>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>

    <script> 
	    // 스마트에디터 사용
	    let oEditors = [];
	    
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: oEditors,
	        elPlaceHolder: "editorTxt",
	        sSkinURI: "resources/smarteditor2/SmartEditor2Skin.html",
	        fCreator: "createSEditor2"
	     })
		 
	     // submit버튼을 클릭하면 해당 내용 #editorTxt value값으로 입력
	     $(".submitBtn").on("click", function() {
			oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", []);
			var value = document.getElementById("editorTxt").value;
			console.log(value);
			
			$("#editorTxt").val(value);
			// $("#realBtn").click();
		});
	    
		     
    </script>

</body>
</html>