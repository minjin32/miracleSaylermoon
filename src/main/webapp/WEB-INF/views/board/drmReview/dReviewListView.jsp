<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <link rel="stylesheet" href="resources/css/board/drmReview/dReviewListView.css"> -->
<link rel="stylesheet" href="resources/css/board/common/mainList.css">
<title>감사후기</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/menubar.jsp"></jsp:include>
	<main align="center">
		<div class="header-background-area">
        	<img src="/resources/images/board/board-banner.png" alt="뒷배경이미지">
	   	</div>
		<div id="main-title">감사후기</div>
		<div class="frame">
			<jsp:include page="/WEB-INF/views/board/common/boardNavi.jsp"></jsp:include>
			
			<c:if test="${ drList.size() > 0 }">
	            <table class="board-list-table">
	                <thead class="board-thead">
	                    <tr class="board-thead-tr">
	                        <td width=110>No</td>
	                        <td width=450 style="word-break: break-all;">제목</td>
	                        <td width=160>작성자</td>
	                        <td width=160>날짜</td>
	                        <td width=100>조회수</td>
	                    </tr>
	                </thead>
	                <tbody>
		                <c:forEach items="${ drList }" var="drmReview" varStatus="status">
		                <c:set var="num" value="${ pi.listCount - ((pi.currentPage - 1) * 10) - status.index }"/>
		                <c:if test="${ drmReview.drmReviewPublicYN eq 'y' or drmReview.drmReviewPublicYN eq 'Y' }">
		                	<tr onclick="location.href='dReviewDetail.dz?drmReviewNo=${drmReview.drmReviewNo}'" style="cursor: pointer;">
		                        <td>${ num }</td>
		                        <td>${ drmReview.drmReviewTitle }</td>
		                        <td>${ drmReview.drmReviewWriter }</td>
	                        	<td>${ drmReview.drmReviewCreateDate }</td>
	                        	<td>${ drmReview.drmRviewHit }</td>
	                    	</tr>
		                </c:if>
		                <c:if test="${ drmReview.drmReviewPublicYN eq 'N' or drmReview.drmReviewPublicYN eq 'n'}">
		                	<tr onclick="location.href='dReviewDetail.dz?drmReviewNo=${drmReview.drmReviewNo}'" style="cursor: pointer;">
		                        <td>${ num }</td>
		                        <c:if test="${ drmReview.userNo != sessionScope.loginUser.userNo && drmReview.shopName != sessionScope.loginUser.partnerName &&  sessionScope.loginUser.userType ne '4' }">
			                        <td>비공개글입니다</td>
			                        <td>비공개</td>
		                        </c:if>
		                        <c:if test="${ drmReview.userNo == sessionScope.loginUser.userNo || drmReview.shopName == sessionScope.loginUser.partnerName || sessionScope.loginUser.userType eq '4' }">
			                         <td>${ drmReview.drmReviewTitle } (사장님만 공개)</td>
			                         <td>${ drmReview.drmReviewWriter }</td>
		                        </c:if>
	                        	<td>${ drmReview.drmReviewCreateDate }</td>
	                        	<td>${ drmReview.drmRviewHit }</td>
	                    	</tr>
		                </c:if>
		                </c:forEach>
	                </tbody>
	            </table>
	            
                <!-- 페이징 -->
	            <table class="board-page-table">
	                <tbody>
	                    <tr>
	                    <!-- 이전시작 -->
	                    	<c:url var="before" value="dReviewMain.dz"> 
	                    		<c:param name="page" value="${ pi.currentPage -1 }"></c:param>
	                    	</c:url>
	                    	<c:if test="${ pi.currentPage <= 1 }">
		                        
	                    	</c:if>
	                    	<c:if test="${ pi.currentPage >1 }">
		                        <td class="page-td" width=35px><a href="${ before }">&lt;</a></td>
	                    	</c:if>
	                    <!-- 이전끝 -->
	                    <!-- 페이지 -->
	                    	<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
	                    		<c:url var="pagination" value="dReviewMain.dz">
	                    			<c:param name="page" value="${ p }"></c:param>
	                    		</c:url>
	                    		<c:if test="${ p eq pi.currentPage }">
			                        <td class="page-td page-selected" width=35px>${ p }</td>
	                    		</c:if>
								<c:if test="${ p ne pi.currentPage }">
			                        <td class="page-td" width=35px><a href="${ pagination }">${ p }</a></td>
								</c:if>	                    	
	                    	</c:forEach>
	                    <!-- 페이지 끝 -->
	                    <!-- 다음 -->
	                    	<c:url var="after" value="dReviewMain.dz">
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
            <!-- 게시물이 없는 경우 -->
            <c:if test="${ empty  drList.size()}">
               	<table class="board-list-table">
	                <thead class="board-thead">
	                    <tr class="board-thead-tr">
	                        <td width=110>No</td>
	                        <td width=450 style="word-break: break-all;">제목</td>
	                        <td width=160>작성자</td>
	                        <td width=160>날짜</td>
	                        <td width=100>조회수</td>
	                    </tr>
	                </thead>
	                <tbody>
		                <tr>
	                		<td colspan="5">${msg}</td>
	                	</tr>
	                </tbody>
	            </table>
	               <!-- 페이징 -->
	            <table class="board-page-table">
	                
	            </table>
            </c:if>
    
 
	        
        </div>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>