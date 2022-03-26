<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 게시글 신고 상세</title>
<link rel="stylesheet" href="resources/css/admin/report/communityReportDetailView.css">
</head>
<body>
    <div class="wrap">
        <div id="menubar">
            <jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>	
        </div>
        <div class="content">
            <div class="content_1">
                <div class="title">
                    <h2>레시피 게시글 신고 상세</h2>
                </div>
                <div class="btn_area">
                    <a class="btn btn-outline-primary"  data-toggle="modal" data-target="#deleteForm2" href="#">반려</a>
                    <a class="btn btn-outline-danger" id="clickModal" data-toggle="modal" data-target="#deleteForm1" href="#">삭제</a>
                	<a class="btn btn-outline-secondary" href="communityReportList.re">목록가기</a>
                </div>
            </div>
            <div class="content_2">
                <div class="content2_1">
                    <div class="contentTitle">
                        ${ coA.comTitle }
                    </div>
                    <div class="writer">
                        ${ coA.userId } 님
                    </div>
                </div>
                <hr>
                <div class="content2_2">
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
                    </div>
                </div>
                <div class="content2_3">
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
            </div>
            
                
        </div>
		
	</div>

    <!-- The Modal : DeleteForm -->
    <div class="modal delete-form fade" id="deleteForm1">
        <div class="modal-dialog">
            <div class="modal-content">
        
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">
                        게시글 삭제
                    </h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
            
                <!-- Modal body -->
                <div class="modal-body">
                    해당 게시글을 삭제하시겠습니까?<br>
                    삭제되면 사용자들이 확인할 수 없습니다.
                </div>
            
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                    <form method="post" action="deleteCommunityReport.re" id="postForm">
                    	<input type="hidden" name="reportCom" value="${ coA.comNo }">
                    	<input type="hidden" name="userNo" value="${ coA.userNo }">
                    	<input type="hidden" name="reportUserNo" value="${ coA.reportUserNo }">
                        <button type="submit" id="deleteSubmit" class="btn btn-danger">삭제</button>
                    </form>
                </div>
            
            </div>
        </div>
    </div>

    <!-- The Modal : DeleteForm -->
    <div class="modal delete-form fade" id="deleteForm2">
        <div class="modal-dialog">
            <div class="modal-content">
        
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">
                        게시글 반려
                    </h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
            
                <!-- Modal body -->
                <div class="modal-body">
                    반려 하시겠습니까?<br>
                    반려하면 사용자들이 확인할 수 있습니다.
                </div>
            
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                    <form method="post" action="rejectCommunityReport.re" id="postForm">
                    	<input type="hidden" name="reportUserNo" value="${ coA.reportUserNo }">
                    	<input type="hidden" name="reportCom" value="${ coA.comNo }">
                        <button type="submit" id="deleteSubmit" class="btn btn-danger">반려</button>
                    </form>
                </div>
            
            </div>
        </div>
    </div>








</body>
</html>