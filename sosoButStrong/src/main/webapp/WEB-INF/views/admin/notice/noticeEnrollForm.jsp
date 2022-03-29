<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 등록</title>
<link rel="stylesheet" href="resources/css/admin/notice/noticeEnrollForm.css">
<link rel="shortcut icon" href="#">
<script type="text/javascript" src="resources/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
</head>
<body>
	<!--2022.3.29(화) 5h50-->

    <div class="wrap">
        <div id="menubar">
            <jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>	
        </div>

        <div class="content">
            <div class="content_1">
                <div class="title">
                    <h2>공지사항 등록</h2>
                </div>
            </div>
            <div>
                <form id="enrollForm" action="insert.no" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="noticeWriter" value="${ loginUser.userNo }">

                    <table class="table table-bordered" align="center" width="800px" margin-left="20px">
                        <tr>
                            <th class="label">카테고리*</th>
                            <td>
                                <select name="category" required>
                                    <option selected disabled>선택해 주세요</option> <!--해당 항목은 콤보박스 리스트에 보여지지만, 선택은 할 수 없게 됨-->
                                    <option>공통</option>
                                    <option>구매자 관련</option>
                                    <option>판매자 관련</option>
                                    <option>이벤트</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th class="label">제목*</th>
                            <td>                                
                                <input type="text" name="title" size="70" required>
                            </td>
                        </tr>
                        <tr>
                            <th class="label">중요도</th>
                            <td>
                                <input type="checkbox" name="show" value="Y" id="show" checked> <label for="show">게시 여부</label>
                                <input type="checkbox" name="top" value="Y" id="top"> <label for="top">중요 여부</label>
                            </td>                            
                        </tr>
                        <tr>
                            <th class="label">내용*</th>
                            <td><textarea name="content" id="editorTxt" rows="25" cols="120" required></textarea></td>
                        </tr>
                        <tr>
                            <th class="label">첨부파일</th>
                            <td>
                                <input type="file" name="upfile">
                                <p>- 파일은 1개 업로드가 가능합니다.</p>
                            </td>
                        </tr>
                    </table>

                    <div align="center" style="float: right;">
                        <button type="button" onclick="location.href='managerList.no'">취소(목록으로 돌아가기)</button>
                        <button type="reset" class="grayBtn">초기화</button>
                        <button type="button" class="orangeBtn submitBtn">공지사항 글 등록</button>
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

                <br><br><br>

            </div> 
        </div>
    </div>	

</body>
</html>