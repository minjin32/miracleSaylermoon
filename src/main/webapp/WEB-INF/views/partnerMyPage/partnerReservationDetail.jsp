<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/partnermypage/partnerReservationDetail.css">
<link rel="stylesheet" href="/resources/css/adminpage/ListPagination.css">
<title>사업자회원 예약관리 페이지</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/mypagemenubar.jsp"></jsp:include>
	<main>
		<div id="main-title">예약 관리</div>
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
							<th>회원닉네임</th>
							<th>예약인원</th>
							<th>예약날짜</th>
							<th>예약상태</th>
							<th>후기작성</th>
						</tr>
					</thead>
					<tbody>
					<c:if test="${ !empty rList }">
					<c:forEach items="${rList }" var="reservation" varStatus="status">
						<tr>
							<td>${status.count }</td>
							<input type="hidden" name="reservationNo" value="${reservation.reservationNo }">
							<input type="hidden" name="shopNo" value="${reservation.shopNo }">
							<c:if test="${ reservation.userType eq '1' || reservation.userType eq '2' }">
								<td><a class="table-link-title" href="#"><p>${reservation.userNick }</p></a></td>
							</c:if>
							<c:if test="${ reservation.userType eq '5' }">
								<td><a class="table-link-title" href="#"><p>${reservation.userName }</p></a></td>
							</c:if>
<%-- 							<td><a class="table-link-title" href="#"><p>${reservation.userNick }</p></a></td> --%>
							<td>${reservation.reserveCount }명</td>
							<td>${reservation.reserveDate }</td>
							
							<td>
								<c:choose>
									<c:when test="${reservation.rState eq 'O'}">
											<select name="rState" class="select-rstate" id="rState">
												<option value="O" selected disabled >대기</option>
												<option value="Y" ${reservation.rState eq 'Y' ? 'selected="selected"' : '' } >승인</option>
																	<!-- reservation.rState eq 'Y' 결과값이 true일때 실행되는 구간 : false일때 실행되는 구간(false일때는 아무 액션도 없기때문에 빈칸) -->
												<option value="X" ${reservation.rState eq 'X' ? 'selected="selected"' : '' }>거부</option>
											</select>
									</c:when>
									<c:otherwise>
										${reservation.rState eq 'Y' ? '예약승인' : reservation.rState eq 'X' ? '예약거부' : reservation.rState eq 'C' ? '완료된 예약' : reservation.rState eq 'H' ? '후기작성완료' :  '' }
									</c:otherwise>
								</c:choose>	
								
								<c:if test="${reservation.rState eq 'O'}">
										<td>예약대기</td>
									</c:if>
									<c:if test="${reservation.rState eq 'X'}">
										<td>취소된예약</td>
									</c:if>
									<c:if test="${reservation.rState eq 'Y'}">
										<td><a class="reserv-btn" href="completeReservation.dz?reservationNo=${reservation.reservationNo }&rState=${reservation.rState }&mainPage=N&shopNo=${reservation.shopNo}" >방문완료</a></td>
									</c:if>
									<c:if test="${reservation.rState eq 'C'}">
										<td>완료된 예약</td>
									</c:if>
									<c:if test="${reservation.rState eq 'H'}">
										<td>후기작성완료</td>
									</c:if>
							</td> 
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
										<c:url value="partnerReserveList.dz" var="before">
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
				                    		<c:url var="pagination" value="partnerReserveList.dz">
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
										<c:url var="after" value="partnerReserveList.dz">
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

<script>
		$(".select-rstate").on("change", function(){
	        var rState = $(this).val();
	        var reservationNo = parseInt($(this).closest("tr").find("input[name='reservationNo']").val());
	        var shopNo = parseInt($(this).closest("tr").find("input[name='shopNo']").val());
	        console.log(rState)
	        $.ajax({
	            url : "updateReservation.dz",
	            type : "POST",
	            data : {"rState" : rState, "reservationNo" :reservationNo, "shopNo" :shopNo},
	            success : function() {
	            	location.reload();
	            },
	            error : function() {
	            	alert('예약 상태 변경이 실패하였습니다...');

	            }
	        });
	    });
		
</script>

</body>
</html>