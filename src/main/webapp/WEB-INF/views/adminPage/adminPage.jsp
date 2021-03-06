<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/mypagemenubar.jsp"></jsp:include>
	<!-- <aside>
		<div class="aside-area">
			<div claass="top-btn">위로</div>
			<div class="bottom-btn">아래로</div>
		</div>
	</aside> -->
	<main>
		<div class="header-admin-nick-area">
				관리자님 안녕하세요!
		</div>
		<!-- 	<div class="admin-menu">
				<ul>
					<li>포인트관리</li>
					<li>사업자관리</li>
					<li>회원관리</li>
					<li>게시판관리</li>
					<li>관리자프로필</li>
				</ul>
			</div> -->
			
        <!-- 포인트관리 -->
        <div class="point-area">
            <div class="point-center">
                <div class="my-title">
					<span>포인트관리</span>
					<div class="more-btn-frame">
						<a class="more-btn b-btn" href="adminPointList.dz">더보기</a>
					</div>
				</div>
                <div class="point-chart">
				   <canvas id="myChart" style="height: inherit; width: inherit; margin: 0 auto;"></canvas>
                </div>
				<div class="point-count-area">
					<c:if test="${ ! empty YearDon }">
							<div class="all-point point-ck"><span>총 기부금액 : </span> <span> ${ YearDon } 원</span></div>
					</c:if>
					<c:if test="${ empty YearDon }">
						${ Dmsg }
					</c:if>
				</div>

            </div>
        </div>
        
        <!-- 사업자관리 -->
        <div class="partner-area">
			<div class="center-area">
				<div class="my-title">
					<span>사업자관리</span>
					<div class="more-btn-frame">
						<a class="more-btn b-btn" href="adminShopList.dz">더보기</a>
					</div>
				</div>
				<div class="center-table-area" id="shop-list-table">
					<table>
						<thead>
							<tr>
								<th width=100>No</th>
								<th>업체명</th>
								<th>사업자아이디</th>
								<th>업체등록번호</th>
								<th>승인상태</th>
								<th>탈퇴</th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${ !empty shopList }">
							<c:forEach items="${ shopList }" var="shop" varStatus="status" end="2">
							
								<tr>
									<td>${ status.count }</td>
									<td><a class="table-link-title" href="shopDetail.dz?shopNo=${shop.shopNo}"><span>${ shop.shopName }</span></a></td>
									<td>${ shop.userId }</td>
									<td>${ shop.partnerVerify }</td>
									<c:if test="${ shop.showShopYN eq 'Y' or shop.showShopYN eq 'y' }">
										<td>승인</td>
									</c:if>
									<c:if test="${ shop.showShopYN eq 'N' or shop.showShopYN eq 'n' }">
										<td>미승인</td>
									</c:if>
									<c:if test="${ shop.partnerWithdraw eq 'y' or shop.partnerWithdraw eq 'Y' }">
										<td><div class="btn btn-secondary reserv-btn" onclick="deleteUser(${shop.userNo})">탈퇴</div></td>
									</c:if>		
									<c:if test="${ shop.partnerWithdraw eq 'n' or shop.partnerWithdraw eq 'N' }">
										<td><div class="done-btn">탈퇴</div></td>
									</c:if>		
									<!-- 사업자 탈퇴는 사업자 상세페이지에서 이루어지도록 하자.... 사업자는 중요한데... -->
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${ empty shopList }">
							<tr>
								<td colspan="7">${ Smsg }</td>
							</tr>
						</c:if>
							
						</tbody>
					</table>
				</div>
			</div>
        </div>
        
        <!-- 회원관리 -->
        <div class="user-area">
            <div class="center-area">
				<div class="my-title">
					<span>회원관리</span>
					<div class="more-btn-frame">
						<a class="more-btn b-btn" href="adminUserList.dz?type=1">더보기</a>
					</div>
				</div>
				<div class="center-table-area" id="user-list-table">
					<table>
						<thead>
							<tr>
								<th width=100>No</th>
								<th>회원이름</th>
								<th>회원아이디</th>
								<th>전화번호</th>
								<th>구분</th>
								<th width=200px>탈퇴</th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${!empty userList }">
						
							<c:forEach items="${ userList }" var="user" end="2" varStatus="status">
								<tr>
									<td>${ status.count }</td>
									<td>${ user.userName }</td>
									<td><a class="table-link-title" href="adminUserInfo.dz?userNo=${user.userNo}"><span>${ user.userId }</span></a></td>
									<c:if test="${ user.userType eq '1' || user.userType eq '2' || user.userType eq '3' }">
										<td>${ user.userPhone }</td>
									</c:if>
									<c:if test="${ user.userType eq '5' }">
										<td>-</td>
									</c:if>
									<c:if test="${ user.userType eq '1' }">
										<td>꿈나무</td>
									</c:if>
									<c:if test="${ user.userType eq '2' || user.userType eq '5' }">
										<td>일반</td>
									</c:if>
									<c:if test="${ user.userType eq '3' }">
										<td>사업자</td>
									</c:if>
									<c:if test="${ user.userType eq '1' || user.userType eq '2' }">
										<td><div class="btn btn-secondary reserv-btn" onclick="deleteUser('${user.userNo}')">탈퇴</div></td>
									</c:if>
									<c:if test="${ user.userType eq '3' || user.userType eq '5' }">
										<td><div class="btn done-btn">탈퇴</div></td>
									</c:if>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${ empty userList }">
							<tr>
								<td colspan="6">${ Umsg }</td>
							</tr>
						</c:if>
						</tbody>
					</table>
				</div>
			</div>
        </div>
        
        <!-- 게시판관리 -->
        <div class="board-area">
            <div class="center-area">
				<div class="my-title">
					<span>게시판관리</span>
					<div class="more-btn-frame">
						<a class="more-btn b-btn" href="adminMReviewList.dz">더보기</a>
					</div>
				</div>
				<div class="center-table-area"  id="board-list-table">
					<table>
						<thead>
							<tr>
								<th width=100px>No</th>
								<th width=500px>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${ !empty nList }">
							<c:forEach items="${ nList }" var="notice" varStatus="status">
								<tr>
									<td>${ status.count }</td>
									<td><a class="table-link-title" href="noticeDetail.dz?noticeNo=${notice.noticeNo }"><span>${ notice.noticeTitle }</span></a></td>
									<td>관리자</td>
									<td>${ notice.noticeCreateDate }</td>
									<td><div class="btn btn-secondary reserv-btn" onclick="deleteNotice('${notice.noticeNo}')">삭제</div></td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${ empty nList }">
							<tr>
								<td colspan="5">${ Nmsg }</td>
							</tr>
						</c:if>
							
						</tbody>
					</table>
				</div>
			</div>
        </div>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
<link rel="stylesheet" href="/resources/css/adminpage/adminHeader.css"> 
<link rel="stylesheet" href="/resources/css/adminpage/adminpage.css"> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.3.0/chart.min.js" integrity="sha512-yadYcDSJyQExcKhjKSQOkBKy2BLDoW6WnnGXCAkCoRlpHGpYuVuBqGObf3g/TdB86sSbss1AOP4YlGSb6EKQPg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
	var ctx = document.getElementById('myChart');
	var dataArr = [];
	<c:forEach items="${ monthSum }" var="month" varStatus="status">
		var test = '${month}';
		console.log('test : ' + test)
		dataArr['${status.index}'] = test.substring(test.indexOf('=', 1)+1, test.length);
	</c:forEach>
		console.log("오이잉 : " + dataArr);
	var myChart = new Chart(ctx, {
		type: 'bar',
		data: {
			labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			datasets: [{
				label: '2021년 돈쭐포인트',
				data: [
					dataArr[0], dataArr[1], dataArr[2], dataArr[3], dataArr[4], dataArr[5], dataArr[6], dataArr[7], dataArr[8], dataArr[9], dataArr[10], dataArr[11]
				],
				backgroundColor: [
					'rgba(255, 99, 132, 0.2)',
					'rgba(54, 162, 235, 0.2)',
					'rgba(255, 206, 86, 0.2)',
					'rgba(75, 192, 192, 0.2)',
					'rgba(153, 102, 255, 0.2)',
					'rgba(255, 159, 64, 0.2)'
				],
				borderColor: [
					'rgba(255, 99, 132, 1)',
					'rgba(54, 162, 235, 1)',
					'rgba(255, 206, 86, 1)',
					'rgba(75, 192, 192, 1)',
					'rgba(153, 102, 255, 1)',
					'rgba(255, 159, 64, 1)'
				],
				borderWidth: 2
			}]
		},
		options: {
			responsive: false,
			<%-- scaleLabel: "<%=new Intl.NumberFormat().format(value) %> 원", --%>
			scales: {
				yAxes: [{
					ticks: {
						beginAtZero: true
					}
				}]
			},
		},
		scaleShowLabelBackdrop : true,
		shopAllTooltips : true,
		tooltips : {
			displayColors : true,
			callbacks : {
				title : function(tooltipItem, data) {
					return;
				},
				label : function(tooltipItem, data) {
// 					return data['labels'] [tooltipItem['index']] + ": " + data['datasets'][0]['data'] [tooltipItem['index']];
				}
			}
		}
	});
	
	
	// 회원관리 - 탈퇴
	function deleteUser(userNo) {
		var result = confirm('회원을 탈퇴시킵니다.');
		if(result) {
			$.ajax({
				url : "adminUserDelete.dz",
				data : {"userNo" : userNo},
				type : "GET",
				success : function(result) {
					if(result == "success") {
						alert('회원을 탈퇴시켰습니다');
						reloadUserList();
					} else if(result == "fail") {
						alert('탈퇴 요청이 실패했습니다');
					}
				}, 
				error : function() {
					
				}
			});
			
		} else {
			reloadUserList();
		}
	}
	
	// 게시판관리 - 삭제
	function deleteNotice(qnaNo) {
		var result = confirm('공지사항을 삭제합니다.');
		if(result) {
			location.href="qaDelete.dz?qnaNo=" + data;
			location.href='adminPage.dz';
		} else {
			reloadBoardList();
		}
	}
	
// 	$.ajax({
// 		url : "qaDelete.dz",
// 		data : {"qnaNo" : qnaNo},
// 		type : "GET",
// 		success : function() {
// 			reloadBoardList();
// 		},
// 		error : function() {
			
// 		}
// 	});
	
	// 사업자관리 리로드
	function reloadShopList() {
	}
	
	// 회원관리 리로드
	function reloadUserList() {
		$("#shop-list-table").load("adminPage.dz #shop-list-table");		
		$("#user-list-table").load("adminPage.dz #user-list-table");
	}
	
	// 게시물관리 리로드
	function reloadBoardList() {
		$("#board-list-table").load("adminPage.dz #board-list-table");
	}
	

</script>
</html>