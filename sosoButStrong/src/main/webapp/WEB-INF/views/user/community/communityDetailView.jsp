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
                        <a href="#">
                            <img src="resources/images/하트.png" class="like" alt="좋아요">
                        </a>
                        1356
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
                <button type="submit" class="btn btn-outline-secondary">신고하기</button>
                <a class="btn btn-outline-warning" href="communityList.co">목록가기</a>
            </div>
        </div>

        <div class="content2">
            <form action="" method="post">
                <div class="content2_1">
                    <input type="text" placeholder="댓글을 입력해주세요.">
                    <button type="submit" class="btn btn-warning">댓글등록</button>
                </div>
            </form>
            <div class="content2_2">
                <table align="center">
                    <tr style="height: 50px;">
                        <th style="width: 120px;">few*** 님</th>
                        <td style="width: 300px;">엥 이조합이 맛있다구요?</td>
                        <td style="width: 150px;">2022-02-02 16:06</td>
                        <td style="width: 100px;"><button type="submit" class="btn btn-outline-secondary">신고</button></td>
                    </tr>
                    <tr style="height: 50px;">
                        <th style="width: 120px;">few*** 님</th>
                        <td style="width: 300px;">엥 이조합이 맛있다구요?</td>
                        <td style="width: 150px;">2022-02-02 16:06</td>
                        <td style="width: 100px;"><button type="submit" class="btn btn-outline-secondary">신고</button></td>
                    </tr>
                    <tr style="height: 50px;">
                        <th style="width: 120px;">few*** 님</th>
                        <td style="width: 300px;">엥 이조합이 맛있다구요?</td>
                        <td style="width: 150px;">2022-02-02 16:06</td>
                        <td style="width: 100px;"><button type="submit" class="btn btn-outline-secondary">신고</button></td>
                    </tr>
                    <tr style="height: 50px;">
                        <th style="width: 120px;">few*** 님</th>
                        <td style="width: 300px;">엥 이조합이 맛있다구요?</td>
                        <td style="width: 150px;">2022-02-02 16:06</td>
                        <td style="width: 100px;"><button type="submit" class="btn btn-outline-secondary">신고</button></td>
                    </tr>
                </table>
            </div>
        </div>
        <div style="height: 200px;"></div>
    </div>


    <jsp:include page="/WEB-INF/views/user/common/footer.jsp"/>

</body>
</html>