<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">



<title>판매자 상품등록 화면</title>
<link rel="shortcut icon" href="#">
<link rel="stylesheet" href="resources/css/user/seller/sellerUploadForm.css">
<script type="text/javascript" src="resources/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/user/common/header.jsp"/>
	<jsp:include page="/WEB-INF/views/user/seller/sellerMyMenu.jsp"/>

    <div class="outer">

        <br><br>
        <h2 style="font-weight: bolder; margin-left: 330px;" >&nbsp;&nbsp;상품등록</h2>
        <form id="enrollForm" action="" method="post" enctype="multipart/form-data">
            <table align="center">
                <tr>
                    <th><div class="cFrame" style="width: 100px;" >대표이미지</div></th>
                    <td><input type="file" style="width: 950px;" class="form-control-file border" name="thumbnail"></td>
                </tr>
                <tr>
                    <th><div class="cFrame">판매상태</div></th>
                    <td>
						<select class="form-control" name="saleStatus">
							<option selected>판매중</option>
							<option>판매중지</option>
							<option>일시품절</option>
						</select>
                    </td>
                </tr>
                <tr>
                    <th><div class="cFrame">판매가</div></th>
                    <td><input type="number" class="form-control" name="price" placeholder="숫자만 입력 (원)" required></td>
                </tr>
                <tr>
                    <th><div class="cFrame">상품명</div></th>
                    <td><input type="text" class="form-control" name="title" placeholder="판매하는 상품과 관련 없는 내용 이거나 스팸성 키워드가 포함될 시 관리자에 의해 판매금지 될 수 있으니 주의하시기 바랍니다." required></td>
                </tr>
                <tr>
                    <th><div class="cFrame">옵션설정</div></th>
                    <td><input type="text" class="form-control" name="options" placeholder="옵션 설정 값을 입력하세요(값마다 , 로 구분)" required></td>
                </tr>
                <tr>
                    <th><div class="cFrame">태그</div></th>
                    <td><input type="text" class="form-control" name="tags" placeholder="상품과 연관 있는 키워드를 입력해 보세요(값마다 , 로 구분)"></td>
                </tr>
                <tr>
                    <th><div class="cFrame">상세페이지</div></th>
                    <td><textarea name="editorTxt" id="editorTxt" rows="25" cols="120" ></textarea></td>
                </tr>
            </table>
            
            <br>

            <div align="center">
                <button type="reset" class="btn btn-secondary">취소</button>
                <button type="submit" class="btn btn-dark">상품등록</button>
            </div>
            
	<script>
	    $(function(){
	    	
		    let oEditors = [];
		    
		    nhn.husky.EZCreator.createInIFrame({
		        oAppRef: oEditors,
		        elPlaceHolder: "editorTxt",
		        sSkinURI: "resources/smarteditor2/SmartEditor2Skin.html",
		        fCreator: "createSEditor2"
		     })
	    })

        submitPost = function() {
            oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", [])
            let content = document.getElementById("editorTxt").value

            if(content == '') {
                alert("내용을 입력해주세요.")
                oEditors.getById["editorTxt"].exec("FOCUS")
                return
            } else {
                console.log(content)
            }
        }             
	</script>
	
        </form>
    </div>
    <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>	
</body>
</html>


