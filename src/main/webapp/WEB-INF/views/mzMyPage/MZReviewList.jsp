<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/mzmypage/mzreviewlist.css">
<title>일반회원 마이페이지</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/mypagemenubar.jsp"></jsp:include>
	<main>
		<div id="main-title">내가 쓴 후기</div>
		<div class="frame">
			<div class="my-info">
				<div class="info-btn-frame">
					<a class="info-btn" href="mzMyPage.dz">돌아가기</a>
				</div>
			</div>
		</div>
		<div class="my-list review-list w-list">
			<div class="frame">
				<table id="review-list-table">
					<thead>
						<tr>
							<th>No</th>
							<th>제목</th>
							<th>가게이름</th>
							<th>작성날짜</th>
							<th>수정</th>
							<th>삭제</th>
						</tr>
					</thead>
					<c:if test="${ !empty mList }">
					<tbody class="mzreview-tbody">
					<c:forEach items="${mList }" var="mzreviewList" varStatus="status">
						<tr>
							<td>${status.count}</td>
								<td><a class="table-link-title" href="mReviewDetail.dz?mzReviewNo=${ mzreviewList.mReviewNo }"><p>${ mzreviewList.mReviewTitle }</p></a></td>
								<td>${ mzreviewList.shopName }</td>
								<td>${ mzreviewList.mReviewUploadDate }</td>
								<td><a class="modify-btn modify-btn-mzreview" href="mReviewUpdateView.dz?mReviewNo=${ mzreviewList.mReviewNo }">수정</a></td>
								<td>
									<a class="delete-btn delete-btn-mzreview" href="#">삭제</a>
									<input type="hidden" class="mReviewNo" value="${ mzreviewList.mReviewNo }">
									<input type="hidden" class="page-ajax" value="${ pi.currentPage }">
								</td>
						</tr>
					</c:forEach>
					</tbody>
				
				
						<!-- 페이징 처리 -->
						<tbody class="paging-navi">
							
						<tr align="center" height="20">
							<td colspan="6">
								<!-- 이전 -->
								<c:url var="before" value="printMZReviewAllListToMyPage.dz">
									<c:param name="page" value="${pi.currentPage - 1 }"></c:param>
								</c:url>
								<c:if test="${pi.currentPage <= 1 }">
									[이전]&nbsp;
								</c:if>
								<c:if test = "${pi.currentPage > 1 }">
									<a href="${before }">[이전]</a>&nbsp;
								</c:if>
								<!-- 페이지 -->
								<c:forEach var="p" begin="${pi.startPage }" end="${pi.endPage }">
									<c:url var="pagination" value="printMZReviewAllListToMyPage.dz">
										<c:param name="page" value="${p }"></c:param>
									</c:url>
									<c:if test="${p eq pi.currentPage }">
										<font color="red" size="4">[${p }]</font>								
									</c:if>
									<c:if test="${p ne pi.currentPage }">
										<a href="${pagination }">${p }</a>&nbsp;
									</c:if>
								</c:forEach>
								<!-- 다음 -->
								<c:url var="after" value="printMZReviewAllListToMyPage.dz">
									<c:param name="page" value="${pi.currentPage + 1 }"></c:param>
								</c:url>
								<c:if  test="${pi.currentPage >= pi.maxPage }">
									[다음]&nbsp;
								</c:if>
								<c:if test="${pi.currentPage < pi.maxPage }">
									<a href="${after }">[다음]</a>&nbsp;
								</c:if>
							</td>
						</tr> 
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
	$(document).on('click','a[href="#"]', function(ignore) {
	    ignore.preventDefault();
	});
	
	// 내가쓴후기 삭제 aJax
	$(document).on('click','.delete-btn-mzreview', function() {
		var mReviewNo = $(this).next().val();
		var page = $(this).next().next().val();
		$.ajax({
			url : "mReviewDelete.dz",
			data : { "mReviewNo" : mReviewNo },
			success : function(data){ 
				if(data == "success"){
					reloadReviewList();
				}else { // 남은 데이터 없을때
					alert("삭제 실패했습니다");
				}
			}, //end of success
			error : function() {
				console.log("전송실패");
			}
		});//end of ajax
		
		function reloadReviewList() {
			$("#review-list-table").load("printMZReviewAllListToMyPage.dz?page="+page+" #review-list-table");
			// $("특정 #id").load("해당페이지주소  특정#id") 
		}
	});
</script>
</html>