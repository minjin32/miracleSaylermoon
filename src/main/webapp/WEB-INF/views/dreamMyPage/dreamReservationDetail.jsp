<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/dreammypage/drmreservationdetail.css">
<link rel="stylesheet" href="/resources/css/adminpage/ListPagination.css">
<title>꿈나무회원 예약목록 페이지</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/mypagemenubar.jsp"></jsp:include>
	<main>
		<div id="main-title">예약 목록</div>
		<div class="frame">
			<div class="my-info">
				<div class="info-btn-frame">
					<a class="info-btn" href="javascript:history.back();">돌아가기</a>
				</div>
			</div>
		</div>
		<div class="my-list reserv-list">
			<div class="frame">
				<table class="list-table">
					<thead>
						<tr>
							<th>No</th>
							<th>가게이름</th>
							<th>예약일시</th>
							<th>예약인원</th>
							<th>예약취소</th>
							<th>후기작성</th>
						</tr>
					</thead>
					<tbody>
					<c:if test="${ !empty rList }">
					<c:forEach items="${rList }" var="reservation" varStatus="status">
						<tr>
							<td>${status.count }</td>
							<td><a class="table-link-title" href="shopDetail.dz?shopNo=${reservation.shopNo }"><p>${reservation.shopName }</p></a></td>
							<td>${reservation.reserveDate }</td>
							<td>${reservation.reserveCount }명</td>
							
							<c:if test="${reservation.rState eq 'O' }">
							<td><a id="cancle-btn" href="cancelReservation.dz?reservationNo=${ reservation.reservationNo }&mainPage=N">예약취소</a></td>
							<td><a id="review-btn">후기작성</a></td>
							</c:if>
							
							<c:if test="${reservation.rState eq 'X' }">
							<td><a id="cancle-complete">취소완료</a></td>
							<td><a id="review-btn">후기작성</a></td>
							</c:if>
							
							
							<c:if test="${reservation.rState eq 'Y' }">
							<td><a class="confirm-btn" >예약확정</a></td>
							<td><a id="review-btn">후기작성</a></td>
							</c:if>
							
								
							<c:if test="${reservation.rState eq 'C' }">
							<td><a class="confirm-btn" >방문완료</a></td>
							<td><a id="visiti-comfirm" href="dReviewWriteView.dz?shopNo=${ reservation.shopNo }&reservationNo=${ reservation.reservationNo }">후기작성</a></td>
							</c:if>
							
							<c:if test="${reservation.rState eq 'H' }">
							<td><a class="confirm-btn" >방문완료</a></td>
							<td><a>후기작성완료</a></td>
							</c:if>
						</tr>
					</c:forEach>
						</c:if>
						<c:if test="${ empty rList }">
							<tr>
								<td colspan="6">${ msg }</td>
							</tr>
						</c:if>
						<c:if test="${ !empty rList }">
						
							<table class="page-table">
							<tbody>
								<tr>
								<!-- 이전 -->
									<c:url value="allRListDetailByDream.dz" var="before">
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
			                    		<c:url var="pagination" value="allRListDetailByDream.dz">
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
									<c:url var="after" value="allRListDetailByDream.dz">
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
					</tbody>
				</table>
			</div>
		</div>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>