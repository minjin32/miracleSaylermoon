<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/adminpage/ListPagination.css">
<link rel="stylesheet" href="/resources/css/adminpage/listdetail.css">
<title>전체회원 목록 페이지</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/mypagemenubar.jsp"></jsp:include>
	<main>
		<div id="main-title">회원 목록</div>
		<div class="frame">
			<div class="my-info">
				<jsp:include page="/WEB-INF/views/adminPage/common/listTopNavi.jsp"></jsp:include>
				<div class="info-btn-frame">
					<a class="info-btn" href="adminPage.dz">돌아가기</a>
				</div>
			</div>
		</div>
		<div class="my-list reserv-list">
			<div class="frame">
				<table class="list-table" id="user-list-table">
					<thead>
						<tr>
							<th>No</th>
							<th>
								<Select class="user-select">
									<option value="1">전체</option>
									<option value="2">꿈나무</option>
									<option value="3">일반</option>
									<option value="4">사업자</option>
								</select>
							</th>
							<th>이름</th>
							<th>아이디</th>
							<th>핸드폰 번호</th>
							<th>이메일</th>
							<th>탈퇴</th>
						</tr>
					</thead>
					<tbody>
					<c:if test="${ !empty userList }">
					<c:forEach items="${userList }" var="user" varStatus="status">
					 <c:set var="num" value="${ pi.listCount - ((pi.currentPage - 1) * 10) - status.index }"/>
						<tr>
							<td>${ num }</td>
							<c:if test="${ user.userType eq '1' }">
								<td>꿈나무</td>							
							</c:if>
							<c:if test="${ user.userType eq '2' || user.userType eq '5' }">
								<td>일반</td>							
							</c:if>
							<c:if test="${ user.userType eq '3' }">
								<td>사업자</td>							
							</c:if>
							<c:if test="${ user.userType eq '4' }">
								<td>관리자</td>							
							</c:if>
							<td>${user.userName }</td>
							<td style="cursor: pointer;" onclick="location.href='adminUserInfo.dz?userNo=${user.userNo}'">${user.userId }</td>
							<!-- 휴대전화 -->
							<c:if test="${ user.userType eq '1' || user.userType eq '2' || user.userType eq '3' }">
								<td>${user.userPhone }</td>
							</c:if>
							<c:if test="${ user.userType eq '5' }">
								<td>-</td>
							</c:if>
							<!-- 이메일 -->
							<c:if test="${ user.userType eq '1' || user.userType eq '2' || user.userType eq '3' }">
								<td>${user.userEmail }</td>
							</c:if>
							<c:if test="${ user.userType eq '5' }">
								<td>-</td>
							</c:if>
							<c:if test="${ user.userType eq '3' || user.userType eq '5' }">
								<td><div class="done-btn" onclick="deleteShopUser()">탈퇴</div></td>
							
							</c:if>
							<c:if test="${ user.userType eq '1' || user.userType eq '2' }">
								<td><div class="delete-btn" onclick="deleteResult('${user.userNo}')">탈퇴</div></td>
							</c:if>
							
						</tr>
					</c:forEach>
						</c:if>
						<c:if test="${ empty userList }">
							<tr>
								<td colspan="6">${ msg }</td>
							</tr>
						</c:if>
					</tbody>
				</table>
				<c:if test="${ !empty userList }">
					<table class="page-table">
							<tbody>
								<tr>
								<!-- 이전 -->
									<c:url value="adminUserList.dz?type=${type }" var="before">
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
			                    		<c:url var="pagination" value="adminUserList.dz?type=${type }">
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
									<c:url var="after" value="adminUserList.dz?type=${type }">
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
<script type="text/javascript">
	
	function deleteResult(userNo) {
        var result = confirm('회원을 탈퇴시킵니다.');
        if(result) {
//             location.href='adminUserDelete.dz?userNo=' + data;
        	$.ajax({
        		url : "adminUserDelete.dz",
        		data : {"userNo":userNo},
        		type : "GET",
        		success : function(data) {
        			if(data == "success") {
        				alert('회원을 탈퇴시켰습니다');
        				reloadUserList();
        			} else if(data == "fail") {
        				alert('탈퇴 요청이 실패했습니다');
        				reloadUserList();
        			}
        		},
        		error : function() {
        			alert('회원 삭제 오류');
        		}
        	});
        } else {
        	reloadUserList();
        }
    }
	
	function deleteShopUser() {
		alert('사업자 회원은 사업자 관리페이지에서 탈퇴 가능합니다.');
	}
	
	function reloadUserList() {
		var page = document.location.href.split("?")[1];
		$("#user-list-table").load("adminUserList.dz"+page + " #user-list-table");
	}
	
	$(".user-select").on("change", function() {
		var selectVal =  $(this).val();
// 		alert(selectVal);
		if(selectVal == "1") {
			location.href="adminUserList.dz?type=1";
			
		} else if(selectVal == "2") {
			location.href="adminUserList.dz?type=2"
			changeSelect(this);
			$(this).parent().css("background", "pink"); // 테스트중
			$(this).parent().eq(1).attr("selected", "selected");
		}else if(selectVal == "3") {
			location.href="adminUserList.dz?type=3"				
			$(this).attr("selected");
		}else if(selectVal == "4") {
			location.href="adminUserList.dz?type=4"				
		}
	});
	
	$(document).ready(function() {
		var allLink = window.location.href;
		var link = document.location.href.split('?');
		var test = link[1].indexOf('type');
		var splitLink = link[1].substring(test, allLink.length);
		var userSelect = $(".user-select"); // select
// 		console.log('으아악' + userSelect);
		
		if(link[1] == 'type=1' || splitLink == 'type=1' ) {
			userSelect.val('1').attr("selected", "selected");
		} else if(link[1] == 'type=2' || splitLink == 'type=2' ) {
			userSelect.val('2').attr("selected", "selected");
		}  else if(link[1] == 'type=3' || splitLink == 'type=3' ) {
			userSelect.val('3').attr("selected", "selected");
		} else if(link[1] == 'type=4' || splitLink == 'type=4' ) {
			userSelect.val('4').attr("selected", "selected");
		}
		
	});
</script>
</html>