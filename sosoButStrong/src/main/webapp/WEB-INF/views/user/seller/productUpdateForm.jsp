<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품수정 화면</title>
<link rel="shortcut icon" href="#">
<link rel="stylesheet" href="resources/css/user/seller/productUpdateForm.css">
<script type="text/javascript" src="resources/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>
	<jsp:include page="/WEB-INF/views/user/seller/sellerMyMenu.jsp"/>

    <div class="outer" style="height: 1100px;">

        <br><br>
        <h2 style="font-weight: bolder; margin-left: 330px;" >&nbsp;&nbsp;상품수정</h2>
        <form id="enrollForm" action="updateProduct.se" method="post" enctype="multipart/form-data">
            <table align="center">
                <input type="hidden" value="${c.productNo}" name="productNo"> <!-- 상품번호 -->
                <tr>
                    <th><div class="cFrame" style="width: 100px;">대표이미지</div></th>
                    <td>
                        현재 등록된 대표이미지 :
                        <a href="${ c.changeName }" download="${ c.originName }">${ c.originName }</a>
                        <input type="hidden" name="originFilePath" value="${ c.changeName }">
                        <input type="file" style="width: 950px;" class="form-control-file border" name="reThumbnail">
                    </td>
                </tr>
                <tr>
                    <th><div class="cFrame">판매상태</div></th>
                    <td>
						<select class="form-control" name="sellStatus">
							<option>판매중</option>
							<option>판매중지</option>
							<option>일시품절</option>
						</select>
                        <script>
							$(function(){
								$('#enrollForm option').each(function(){ // 현재 상품의 판매상태를 상품수정 시 기본값으로 선택
									console.log("${ c.originName }");
                                    console.log("${ c.changeName }");
									if($(this).text() == "${c.sellStatus}") {
										
										$(this).attr('selected', true);
									}
								})
							})
						</script>
                    </td>
                </tr>
                <tr>
                    <th><div class="cFrame">판매가</div></th>
                    <td><input type="number" class="form-control" name="price" value="${c.price}" placeholder="숫자만 입력 (원)" required></td>
                </tr>
                <tr>
                    <th><div class="cFrame">상품명</div></th>
                    <td><input type="text" class="form-control" name="productName" maxlength="13" value="${c.productName}" placeholder="판매하는 상품과 관련 없는 내용 이거나 스팸성 키워드가 포함될 시 관리자에 의해 판매금지 될 수 있으니 주의하시기 바랍니다." required></td>
                </tr>
                <tr>
                    <th><div class="cFrame">옵션설정</div></th>
                    <td><input type="text" class="form-control" name="option" value="${c.option}" placeholder="옵션 설정 값을 입력하세요(값마다 , 로 구분)" required></td>
                </tr>
                <tr>
                    <th><div class="cFrame">태그</div></th>
                    <td><input type="text" class="form-control" name="pTag" value="${c.pTag}" placeholder="상품과 연관 있는 키워드를 입력해 보세요(값마다 , 로 구분)"></td>
                </tr>
                <tr>
                    <th><div class="cFrame">상세페이지</div></th>
                    <td><textarea name="description" id="editorTxt" rows="25" cols="120">${c.description}</textarea></td>
                </tr>
            </table>
            
            <br>

            <div style="margin-left: 830px;">
                <button type="reset" class="btn btn-secondary">취소</button>
                <button type="button" class="btn btn-dark submitBtn">상품수정</button>
                <button type="submit" style="display:none;" id="realBtn">숨겨진 찐 제출버튼</button>
            </div>
            
	<script>
	  
	    let oEditors = [];
	    
	    nhn.husky.EZCreator.createInIFrame({ // 에디터 편집기형태가 textarea에 씌워짐.
	        oAppRef: oEditors,
	        elPlaceHolder: "editorTxt", // 에디터 편집기를 씌울 textarea의 id값
	        sSkinURI: "resources/smarteditor2/SmartEditor2Skin.html", // 에디터 편집기 화면구성
	        fCreator: "createSEditor2"
	     })
	     
		$(".submitBtn").on("click", function() { // 상품등록 버튼이 눌리면 에디터편집기에 있는 값이 textarea의 value로 들어가도록 함.
			oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", []); // *에디터 편집기의 값을 가져오기 위한 처리
			var value = document.getElementById("editorTxt").value; // 텍스트 편집기의 값을 변수에 담음
			console.log(value);
			
			$("#editorTxt").val(value); // 변수에 담긴 편집기의 값을 textarea의 밸류에 입력
			$("#realBtn").click(); // 찐 submit 버튼 클릭
			
		});
	</script>
        </form>
         
    </div>
    
    <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>	
</body>
</html>