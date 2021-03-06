<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/adminpage/ListPagination.css">
<link rel="stylesheet" href="/resources/css/adminpage/listdetail.css">
<title>게시판 목록 페이지</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/mypagemenubar.jsp"></jsp:include>
	<main>
		<div id="main-title">감사후기</div>
		<div class="frame">
			<div class="my-info">
				<jsp:include page="/WEB-INF/views/adminPage/common/listTopNavi.jsp"></jsp:include> <!--  -->
				<jsp:include page="/WEB-INF/views/adminPage/common/boardListNavi.jsp"></jsp:include> <!-- 게시판별 네비 -->
				<div class="info-btn-frame">
					<a class="info-btn" href="adminPage.dz">돌아가기</a>
				</div>
			</div>
		</div>
		<div class="my-list">
			<div class="frame reserv-list">
				<table class="list-table">
					<thead>
						<tr>
							<th>No</th>
							<th>제목</th>
							<th>작성자</th>
							<th>공개</th>
							<th>날짜</th>
							<th width=150px>삭제</th>
						</tr>
					</thead>
					<tbody>
					<c:if test="${ !empty dRList }">
					<c:forEach items="${dRList }" var="drReview" varStatus="status">
					 <c:set var="num" value="${ pi.listCount - ((pi.currentPage - 1) * 10) - status.index }"/>
						<tr>
							<td>${ num }</td>
							<td style="cursor: pointer;" onclick="location.href='dReviewDetail.dz?drmReviewNo=${drReview.drmReviewNo}'">${drReview.drmReviewTitle }</td>
							<td>${drReview.drmReviewWriter }</td>
							<c:if test="${drReview.drmReviewPublicYN eq 'y' or drReview.drmReviewPublicYN eq 'Y' }">
								<td>공개</td>
							</c:if>
							<c:if test="${drReview.drmReviewPublicYN eq 'n' or drReview.drmReviewPublicYN eq 'N' }">
								<td>비공개</td>
							</c:if>
							<td>${drReview.drmReviewCreateDate }</td>
							<td><div class="delete-btn" onclick="deleteResult('${ drReview.drmReviewNo }')">삭제</div></td>
							
						</tr>
					</c:forEach>
						</c:if>
						<c:if test="${ empty dRList }">
							<tr>
								<td colspan="6">${ msg }</td>
							</tr>
						</c:if>
					</tbody>
				</table>
				<c:if test="${ !empty dRList }">
					<table class="page-table">
							<tbody>
								<tr>
								<!-- 이전 -->
									<c:url value="adminDrmReviewList.dz" var="before">
										<c:param name="page" value="${ pi.currentPage-1 }"></c:param>
									</c:url>
									<c:if test="${ pi.currentPage <= 1 }">
									</c:if>
									<c:if test="${ pi.currentPage > 1 }">
										<td class="page-td" width=35px><a href="${ before }">&lt;</a></td>
									</c:if>
									<!-- 이전끝 -->
									<!-- 페이징 -->
									<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
			                    		<c:url var="pagination" value="adminDrmReviewList.dz">
			                    			<c:param name="page" value="${ p }"></c:param>
			                    		</c:url>
			                    		<c:if test="${ p eq pi.currentPage }">
					                        <td class="page-td page-selected" width=35px>${ p }</td>
			                    		</c:if>
										<c:if test="${ p ne pi.currentPage }">
					                        <td class="page-td" width=35px><a href="${ pagination }">${ p }</a></td>
										</c:if>	                    	
			                    	</c:forEach>
									<!-- 페이징 끝 -->
									<c:url var="after" value="adminDrmReviewList.dz">
			                    		<c:param name="page" value="${ pi.currentPage+1 }"></c:param>
			                    	</c:url>
			                    	<c:if test="${ pi.currentPage >= pi.maxPage }">
			                    	</c:if>
			                    	<c:if test="${ pi.currentPage < pi.maxPage }">
			                    		<td class="page-td" width=35px><a href="${ after }">&gt;</a></td>
			                    	</c:if>
									<!-- 다음 끝 -->
								</tr>
							</tbody>
						</table>
				</c:if>
			</div>
		</div>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
<script>
	$('.board-menu-btn').eq(1).css('background','#0160ff').css('color','white');
	
	function deleteResult(data) {
        var result = confirm('게시글을 삭제합니다.');
        if(result) {
        	$.ajax({
        		url : "dReviewDelete.dz",
        		data : { "drmReviewNo" : data },
        		success : function(data){ 
    				if(data == "success"){
    					reloadReviewList();					
    				}else { // 남은 데이터 없을때
    					alert("게시글 삭제를 실패했습니다");
    				}
    			}, //end of success
    			error : function() {
    				console.log("전송실패");
    			}
        	});
        } else {
			reloadReviewList();					
        }
    }
	
	function reloadReviewList() {
		var page = document.location.href.split("?")[1];
		$(".reserv-list").load("adminDrmReviewList.dz?"+page+" .reserv-list");
	}
</script>
</html>