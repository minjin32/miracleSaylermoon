<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/adminpage/ListPagination.css">
<link rel="stylesheet" href="/resources/css/adminpage/listdetail.css">
<title>포인트 목록 페이지</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/mypagemenubar.jsp"></jsp:include>
	<main>
		<div id="main-title">포인트 관리</div>
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
				<table class="list-table">
					<thead>
						<tr>
							<th width=287px>총돈쭐금액</th>
							<th width=287px>회원포인트</th>
							<th width=287px>돈쭐수수료</th>
							<th width=287px>잔액</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${ yearDonPriceSum }</td>
							<td>${ yearDonUserPoint }</td>
							<td>${ yearDonJjul }</td>
							<td>${ yearDonPartnerPoint }</td>
						</tr>
					</tbody>
				</table>
				
				<table class="list-table" id="monthTable">
					<thead>
						<tr>
							<th width=100px>월</th>
							<th width=287px>돈쭐금액</th>
							<th width=287px>회원포인트</th>
							<th width=287px>돈쭐수수료</th>
							<th width=287px>잔액</th>
						</tr>
						
					</thead>
				</table>
				
			</div>
		</div>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
	
	console.log('테스트 : ' + '${monthSum}');
	var donPriceSum = [];
	var donUserPoint = [];
	var donJjul = [];
	var donPartnerPoint = [];
	
	var monthArr = [];
	<c:forEach items="${ monthSum }" var="month" varStatus="status">
		var test = '${month}';
		console.log("포문속 데이터" + '${month}');
		monthArr['${status.index}'] = test.substring(0, test.indexOf('=', 0));
		
		donPriceSum['${status.index}'] = test.substring(test.indexOf('=', 5)+1, test.indexOf(',', 1));
		donUserPoint['${status.index}'] = test.substring(test.indexOf('=', 55)+1, test.indexOf(',', 55));
		donJjul['${status.index}'] = test.substring(test.indexOf('=', 70)+1, test.indexOf(',', 75));
		donPartnerPoint['${status.index}'] = test.substring(test.indexOf('=', 90)+1, test.length-1);
	</c:forEach>
	console.log("donPriceSum : " + donPriceSum);
	console.log("donUserPoint : " + donUserPoint);
	console.log("donJjul : " + donJjul);
	console.log("donPartnerPoint : " + donPartnerPoint);
	console.log("날짜 : " + monthArr);
	
	for(var i = monthArr.length-1; i >= 0; i--) 
	{
		var html = null;
		html += '<tbody>';
		html +=  '<tr>';
		html += '<td>' +monthArr[i].replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '</td>';
		html += '<td>' +donPriceSum[i].replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '</td>';
		html += '<td>' +donUserPoint[i].replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '</td>';
		html += '<td>' +donJjul[i].replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '</td>';
		html += '<td>' +donPartnerPoint[i].replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '</td>';
		html +=  '</tr>';
		html += '</tbody>';
		$('#monthTable').append(html);
		
	}
	
</script>
</html>