<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/payment/paymentForm.css">
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<title>돈쭐내기</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/menubar.jsp"></jsp:include>
	
	<main>
		<div class="header-background-area">
	        <img src="/resources/images/payment/donjjulmainbanner.jpg" alt="뒷배경이미지">
	    </div>
		<div id="main-title">돈쭐내기&nbsp;&nbsp;<span id="main-title-shop">${shop.shopName }</span></div>
		
		<c:if test="${ empty loginUser }">
			<script>
				alert("잘못된 접근입니다. \n로그인 이후 사용 가능합니다.");
				location.href="loginView.dz";
			</script>
		</c:if>
		<c:if test="${ ! empty loginUser }">
			<c:if test="${loginUser.userType == 1 }">
				<script>
					alert("잘못된 접근입니다. \n일반 회원만 사용가능한 돈쭐 페이지입니다.");
					location.href="/";
				</script>
			</c:if>
			<c:if test="${loginUser.userType == 3 }">
				<script>
					alert("잘못된 접근입니다. \n일반 회원만 사용가능한 돈쭐 페이지입니다.");
					location.href="/";
				</script>
			</c:if>
			<%-- <c:if test="${loginUser.userType == 2 }">
			</c:if> --%>
		</c:if>
		
		
		<div class="frame">
			<form action="" method="post">
			
				<div id="lay1" class="payment lay1">
					<div class="lay-title">
						<span class="title-span">메뉴 선택</span>
					</div>
					<div class="lay1-content">
						<c:if test="${ empty mList }">
							<label class="menu-choice"><input type="hidden" name="menu-price" value=""><input type="radio" name="menu" value="" onclick=""><span>${Dmsg }</span></label>
						</c:if>
						<c:if test="${ !empty mList }">
							<!-- for each문(가게shop/메뉴mainMenu) -->
							<c:forEach items="${mList }" var="menu">
								<label class="menu-choice"><input type="hidden" name="menu-price" value="${menu.mainMenuPrice }"><input type="radio" name="menu" value="${menu.mainMenuName }" onclick="menuChoice(this)"><span>${menu.mainMenuName }&nbsp;&nbsp;${menu.mainMenuPrice }원</span></label>
							</c:forEach>
						</c:if>
					</div>
				</div>
				<div id="lay2" class="payment">
					<div id="lay2-1" class="lay2 amount">
						<div class="lay-title">
							<span class="title-span">수량 선택</span>
						</div>
						<div class="amount-btn-div">
							<!-- 스타일 다시 주기 --><input type="hidden" id="hidden-price"/>
							<label class="amount-btn"><input type="radio" name="amountC" value="1" onclick="amountChoice(this.value)"><span>X 1</span></label><label class="amount-btn"><input type="radio" name="amountC" value="2" onclick="amountChoice(this.value)"><span>X 2</span></label><label class="amount-btn"><input type="radio" name="amountC" value="3" onclick="amountChoice(this.value)"><span>X 3</span></label>
						</div>		
					</div>
					<div id="lay2-2" class="lay2 point" >
						<div class="lay-title">
							<span class="title-span">포인트 사용</span>
						</div>
						<div>
							<div id="lay2-point-div">
								<c:if test="${ empty userPoint }">
									&nbsp;&nbsp;보유 포인트 : <input type="text" id="userPoint" value="0" readonly/>  원 <br>
									&nbsp;&nbsp;가용 포인트 : <input type="text" id="useablePoint" value="" readonly/> 원 <br>
									&nbsp;&nbsp;사용 포인트 : <input type="text" id="usePoint" onkeyup="pointUse()" value="0" placeholder="사용할 포인트 입력"/> 원 <br>
								</c:if>
								<c:if test="${ !empty userPoint }">
									&nbsp;&nbsp;보유 포인트 : <input type="text" id="userPoint" value="${userPoint }" readonly/>  원 <br> <%-- ${userPoint } --%>
									&nbsp;&nbsp;가용 포인트 : <input type="text" id="useablePoint" value="" readonly/> 원 <br>
									&nbsp;&nbsp;사용 포인트 : <input type="text" id="usePoint" onkeyup="pointUse()" value="0" placeholder="사용할 포인트 입력"/> 원 <br>
								</c:if>
								<!-- <input type="text" id="pCount" placeholder="사용할 포인트 입력"/>원 --> 
							</div>
								&nbsp;&nbsp;<button id="pSubmit">포인트 사용하기</button>
						</div>
					</div>
				</div>
				<div id="lay3" class="payment lay3" >
					<div class="lay-title">
						<span class="title-span">결제 정보</span>
					</div>
					<div>
						<div id="lay3-payment-result">
							메 &nbsp; 뉴&nbsp; &nbsp; 명 : &nbsp; &nbsp;<input type="text" name="menuName" value="" readonly/><!-- <input type="text" name="menu-name" read/> --><br>
							수 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 량 : <input type="text" name="amount" value="" readonly/>개<br>
							메뉴 &nbsp; &nbsp;총액 : <input type="text" name="menu-fin-price" value="0" readonly/> 원<br>
							포인트 사용 : <input type="text" name="use-point" value="0" readonly/> 원<br>
							결제&nbsp; &nbsp; 금액 : <input type="text" name="donPrice" value="0" readonly/> 원
							<!-- 위에 폼 넘기려면 vo이름으로 맞춰야함 맞춰주기 | 가격 어쩔 겨-포인트제외or총(donPrice)-->
							
							<input type="hidden" name="userNo" value="${loginUser.userNo }"/>
							<input type="hidden" name="shopNo" value="${shop.shopNo }" />
							<input type="hidden" name="shopName" value="${shop.shopName }" />
						</div>	
						 <br>
						<input type="submit" id="payment-btn" value="돈쭐내러 가기">
					</div>
				</div>
				
			</form>
		</div>
		
		
		
		
	</main>

<script type="text/javascript">

	$(function() {

		//$("#userPoint").val(12);
		console.log($("#usePoint").val());
		
		var userPoint = $("#userPoint").val();
		var useablePoint = $("#useablePoint");
			
		// 가용 포인트
		if(userPoint < 500){
			useablePoint.val(0);
		}else if(userPoint >= 500 && userPoint <= 5000){
			useablePoint.val(userPoint);
		}else if(userPoint > 5000){
			useablePoint.val(5000);
		}
		
	});

	// 돈쭐내기 버튼
	$("#payment-btn").on("click", function(e){
	    e.preventDefault();
	    var usePoint = $("#usePoint").val();
		var userPoint = $("#userPoint").val();
		usePoint = Number(usePoint);
		userPoint = Number(userPoint);

		/* if(usePoint > 5000){
			alert("포인트는 5000원까지 사용 가능합니다!");
			return false;
		}else if(usePoint > 0 && usePoint < 500){
			alert("500원부터 사용 가능합니다!");
			return false;
		}else if(usePoint < 0){
			alert("500원부터 사용 가능합니다!");
			return false;
		}
		 */ 
		if($("#useablePoint").val() == 0){
			// 안 돼 ㅠ^ㅠ - 0일 때 안 넘어가고,, 500과 5000 사이에 넘어가면 안 되는데 넘어감..
			/* if(usePoint == 0){
				alert("왜. 리턴 트루인데..");
				return true;
			}else {
				alert("사용 가능한 포인트가 없습니다.");
				return false;
			} */
			if(usePoint > 5000 || usePoint <= -1){ // 먹히고
				alert("5000보다 크거나 0보다 작음(-)사용 가능한 포인트가 없습니다.");
				return false;
			} else if(usePoint >= 1){ 
				alert("500보다 작거나 0보다 큼사용 가능한 포인트가 없습니다.");
				return false;
			} else if(usePoint == 0) {
				
			} 
			/* 
			if(usePoint > 5000){
				alert("포인트는 5000원까지 사용 가능합니다!");
				return false;
			}else if(usePoint > 0 && usePoint < 500){
				alert("500원부터 사용 가능합니다!");
				return false;
			}else if(usePoint < 0){
				alert("500원부터 사용 가능합니다!");
				return false;
			}
			 */
		}else if($("#useablePoint").val() != 0) {
			if(usePoint > 5000){
				alert("포인트는 5000원까지 사용 가능합니다!");
				return false;
			}else if(usePoint > 0 && usePoint < 500){
				alert("500원부터 사용 가능합니다!");
				return false;
			}else if(usePoint < 0){
				alert("500원부터 사용 가능합니다!");
				return false;
			}
		}
		/* 
		else if(usePoint == 0){
			return true;
		} */
		
		// 돈쭐내기 버튼으로 포인트 까주기
		var sum = $("input[name='menu-fin-price']").val();
		var fin = sum - usePoint;
		$("input[name='donPrice']").val(fin);
	    
		
	    var IMP = window.IMP; // 생략가능
	    IMP.init('imp57766104'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	    
	    // 돈쭐 총금액
	    var donPrice = $("input[name='menu-fin-price']").val();
	    
	    var finPrice = $("input[name='donPrice']").val();
	    var menuName = $("input[name='menuName']").val();
	    var amount = $("input[name='amount']").val();
	    var usePoint = $("input[name='use-point']").val();
	    var shopNo = '${shop.shopNo }';
	    var shopName = '${shop.shopName }';
	    
	    var msg;
	    
	    /* $.ajax({
            url: "insertDonList.dz", //cross-domain error가 발생하지 않도록 주의해주세요
            			// data 보낼 url
            type: 'POST',
            data: {
                //imp_uid : rsp.imp_uid,
                //기타 필요한 데이터가 있으면 추가 전달
                // 가게 이름, 날짜, 내역(얼마)
                "donPrice" : donPrice,
                "menuName" : menuName,
                "amount" : amount,
                "shopNo" : shopNo,
                "shopName" : shopName,
                "use-point" : usePoint
            }
        }); */
        
        // api 떼고 test
        $.ajax({
        	url: "insertDonList.dz", //cross-domain error가 발생하지 않도록 주의해주세요
			// data 보낼 url
	        type: 'POST',
	        data: {
	            //imp_uid : rsp.imp_uid,
	            //기타 필요한 데이터가 있으면 추가 전달
	            // 가게 이름, 날짜, 내역(얼마)
	            "donPrice" : donPrice,
	            "menuName" : menuName,
	            "amount" : amount,
	            "shopNo" : shopNo,
	            "shopName" : shopName,
	            "usePoint" : usePoint
	        },
	        success : function(data) {
	        	console.log(data);
	        	location.href='rouletteView.dz?donNo='+data.donNo+'&donPrice='+data.donPrice+'&shopName='+data.shopName;
	        }
        });
        // 카카오 페이 api
	    /* 
        IMP.request_pay({
	        pg : 'kakaopay',
	        pay_method : 'card',
	        merchant_uid : 'merchant_' + new Date().getTime(),
	        name : '돈쭐내기 결제 : ${shop.shopName }',
	        amount : finPrice, // 최종 결제 금액 
	        buyer_email : '${loginUser.userEmail }',
	        buyer_name : '${loginUser.userName }',
	        buyer_tel : '${loginUser.userPhone }',
	        buyer_addr : '주소컬럼 없음',
	        buyer_postcode : '123-456', // ??
	        //m_redirect_url : 'http://www.naver.com'
	    }, function(rsp) {
	        console.log(rsp);
	 	   if ( rsp.success ) {
	            //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
	            $.ajax({
	            	url: "insertDonList.dz", //cross-domain error가 발생하지 않도록 주의해주세요
        			// data 보낼 url
			        type: 'POST',
			        data: {
			            //imp_uid : rsp.imp_uid,
			            //기타 필요한 데이터가 있으면 추가 전달
			            // 가게 이름, 날짜, 내역(얼마)
			            "donPrice" : donPrice,
			            "menuName" : menuName,
			            "amount" : amount,
			            "shopNo" : shopNo,
			            "shopName" : shopName,
			            "usePoint" : usePoint
			        },
			        success : function(data) {
			        	console.log(data);
			        	location.href='rouletteView.dz?donNo='+data.donNo+'&donPrice='+data.donPrice+'&shopName='+data.shopName;
			        }
	            });
	            //성공시 이동할 페이지 (룰렛페이지인지 중간에 결제 완료창 있는지)
	            //location.href="rouletteView.dz"; // 룰렛 페이지
	        } else {
	            msg = '결제에 실패하였습니다.';
	            msg += '에러내용 : ' + rsp.error_msg;
	            //실패시 이동할 페이지
	            alert(msg);
	            location.href="paymentFormView.dz"; 
	        }
	    });
	     */
	});

	// 메뉴 선택하면
	function menuChoice(menu){
		// 리셋
		
		var menuName = $(menu).val();
		var menuPrice = $(menu).prev().val();
		$("#hidden-price").val(menuPrice);
		console.log("메뉴선택 시 prev" + menuPrice);
		
		console.log("메뉴선택-메뉴이름" + menuName);
		console.log("메뉴선택-메뉴가격" + menuPrice);
		
		$("input[name='menuName']").val(menuName); // lay3-메뉴명
		//$("input[name='menu-fin-price']").val(menuPrice); // lay3-메뉴총액
		
		$(menu).prev().val(menuPrice); // lay3-메뉴총액
		console.log("hidden"+$("input[name='menu-price']").val());
		
	}

	// 수량 선택하면
	function amountChoice(amount){
		$("input[name='amount']").val(amount); // lay3-수량
		console.log("수량선택-수량"+amount);
		
		
		var mName = $("input[name='menuName']").val(); // lay3의 메뉴이름
		console.log("lay3의 메뉴이름" + mName);
		
		//var mPrice = $("input[name='menu-fin-price']").val(); // lay3의 메뉴가격
		var mPrice = $("#hidden-price").val()
		mPrice = Number(mPrice);
		console.log("lay3의 메뉴가격" + mPrice);
		
		var amount = $("input[name='amount']").val(); // lay3의 수량
		amount = Number(amount);
		console.log("lay3의 메뉴수량" +amount);
		
		var priceSum = mPrice * amount; // 가격*수량
		$("input[name='menu-fin-price']").val(priceSum);
		console.log("lay3 가격*수량" + priceSum);
		
		var usePoint = $("#usePoint").val(); // 사용할 포인트
		usePoint = Number(usePoint);
		
		var finPrice = priceSum - usePoint; // 결제할 가격 = (가격*수량) - 포인트
		console.log("lay3 결제할가격(차감)" + finPrice);
		$("input[name='donPrice']").val(finPrice); // 결제 가격 = 총가격 - 사용포인트
	}

	// 포인트 입력시 자동으로(onkeyup)
	function pointUse(){
		var usePoint = $("#usePoint").val(); // 사용할 포인트
		
		$("input[name='use-point']").val(usePoint); // lay3 포인트사용
		
	}
	
	// 포인트 버튼 클릭 시
	$(function() {
		$("#pSubmit").on("click", function(e){
			e.preventDefault(); // submit 버튼으로 작동하는 것을 중단.
			
			console.log("젤 처음 콘솔" + $("input[name='donPrice']").val());
			
			var usePoint = $("#usePoint").val();
			var userPoint = $("#userPoint").val();
			console.log(userPoint);console.log(usePoint);
			usePoint = Number(usePoint);
			userPoint = Number(userPoint);
			console.log(userPoint);console.log(usePoint);
			
			// 가용포인트가 0일 때 - 0 가능, 다른 수 불가능
			if($("#useablePoint").val() == 0){
				if(usePoint == 0){
					alert("왜. 리턴 트루인데..");
					return true;
				}else{
					alert("사용 가능한 포인트가 없습니다.");
					return false;
				}
			}else if($("#useablePoint").val() != 0) {
				if(usePoint > 5000){
					alert("포인트는 5000원까지 사용 가능합니다!");
					return false;
				}else if(usePoint > 0 && usePoint < 500){
					alert("500원부터 사용 가능합니다!");
					return false;
				}else if(usePoint == 0){
					return true;
				}else if(usePoint < 0){
					alert("500원부터 사용 가능합니다!");
					return false;
				}
			}
			
			/* 
			if(usePoint > 5000){
				alert("포인트는 5000원까지 사용 가능합니다!");
				return false;
			}else if(usePoint > 0 && usePoint < 500){
				alert("500원부터 사용 가능합니다!");
				return false;
			}else if(usePoint == 0){
				return true;
			}else if(usePoint < 0){
				alert("500원부터 사용 가능합니다!");
				return false;
			}
			 */
			/* 
			if(usePoint > userPoint) {
				alert("포인트 사용 가능 범위를 넘었습니다!");
				return false;
			}else if(usePoint <= 500){
				alert("포인트는 500원부터 사용 가능합니다!");
				return false;
			}else if(usePoint >= 5000){
				alert("포인트는 5000원까지 사용 가능합니다!");
				return false;
			}
			 */
			/* 
			// 가용 포인트
			if($("#userPoint").val() < 500){
				$("#useablePoint").val(0);
			}else if($("#userPoint").val() >= 1 || $("#userPoint").val() <= 4900){
				$("#useablePoint").val() = $("#userPoint").val();
			}else if($("#userPoint").val() > 5000){
				$("#useablePoint").val(5000);
			}
			 */
			
			// 포인트 사용 클릭 시 
			// lay3 이 보여야하며
			// lay3의 내용 - 총가격(가격*수량), 포인트, 결제 금액 나타내야하고
			// 
			//$("#lay3").show(500);
			//$("input[name='menu-price']").val(); // 총가격 = 메뉴가격 * 수량
			
			var mName = $("input[name='menuName']").val(); // lay3의 메뉴이름
			console.log("lay3의 메뉴이름" + mName);
			
			//var mPrice = $("input[name='menu-fin-price']").val(); // lay3의 메뉴가격
			var mPrice = $("#hidden-price").val()
			mPrice = Number(mPrice);
			console.log("lay3의 메뉴가격" + mPrice);
			
			var amount = $("input[name='amount']").val(); // lay3의 수량
			amount = Number(amount);
			console.log("lay3의 메뉴수량" +amount);
			
			var priceSum = mPrice * amount; // 가격*수량
			$("input[name='menu-fin-price']").val(priceSum);
			console.log("lay3 가격*수량" + priceSum);
			
			var usePoint = $("#usePoint").val(); // 사용할 포인트
			usePoint = Number(usePoint);
			
			var finPrice = priceSum - usePoint; // 결제할 가격 = (가격*수량) - 포인트
			console.log("lay3 결제할가격(차감)" + finPrice);
			$("input[name='donPrice']").val(finPrice); // 결제 가격 = 총가격 - 사용포인트
			
		});
	});

</script>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>