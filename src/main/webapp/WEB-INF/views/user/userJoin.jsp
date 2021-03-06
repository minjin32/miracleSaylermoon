<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/user/join.css"> 
<!-- <link href="/static/bootstrap.min.css" rel="stylesheet"> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>돈쭐 회원가입</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/menubar.jsp"></jsp:include>
	<main>
		<div class="header-background-area">
        	<img src="/resources/images/mapListMain.png" alt="뒷배경이미지">
   		</div>	
		<div id="main-title">회원가입</div>
		<div class="frame">
			<h4>회원타입을 선택하세요</h4>
			<ul class="tab">
				<li data-tab="dreamEnrollView" class="tabmenu" id="default">
					꿈나무회원
				</li>
				<li data-tab="mzEnrollView" class="tabmenu">
					일반회원
				</li>
				<li data-tab="partnerEnrollView" class="tabmenu">
					사업자회원
				</li>
			</ul>
			<div class="tabcontent">
				<div class="content-body">
					<div id="dreamEnrollView" class="tab-content current">
						<form action="dreamRegister.dz" method="post">
							<div class="form-head">
								아이디&nbsp;
								<span class="required">*</span>&nbsp;&nbsp;
								<div class="form-noti idnoti userid-noti-0">아이디를 입력해 주세요.</div>
								<div class="form-noti idnoti userid-noti-1">영문소문자로 시작, 영문소문자, 숫자 포함 6~20자</div>
								<div class="form-noti idnoti userid-noti-2">이미 사용중인 아이디입니다.</div>
								<div class="form-noti idnoti userid_suc">사용가능한 아이디입니다.</div>
							</div>
							<div class="form-body">
								<input name="userId" class="form-elem idelem" type="text" maxlength="20" placeholder="영문소문자, 숫자 포함 6~20자">
							</div>
							
							<div class="form-head form-head2">
								비밀번호&nbsp;
								<span class="required">*</span>&nbsp;&nbsp;
								<div class="form-noti pwnoti password_noti_0">비밀번호를 입력해 주세요.</div>
								<div class="form-noti pwnoti password_noti_1">영문소문자, 숫자 포함 6~20자</div>
								<div class="form-noti pwnoti password_noti_2">비밀번호가 일치하지 않습니다.</div>
							</div>
							<div class="form-body">
								<input name="userPw" class="form-elem pwdelem" type="password" maxlength="20" placeholder="영문, 숫자 또는 혼합 6~20자">
								<input name="re_pwd" class="form-elem pwdelem re_pwd" type="password" maxlength="20" placeholder="비밀번호 재입력">
							</div>
							
							<div class="form-head form-head2">
								이름&nbsp;
								<span class="required">*</span>&nbsp;&nbsp;
								<div class="form-noti namenoti name_noti_0">이름을 입력해 주세요.</div>
								<div class="form-noti namenoti name_noti_1">한글 2자 이상 입력</div>
							</div>
							<div class="form-body">
								<input name="userName" class="form-elem nameelem" type="text" maxlength="20" placeholder="한글 2자 이상 입력">
							</div>
							
							<div class="form-head form-head2">
								카드번호&nbsp;
								<span class="required">*</span>&nbsp;&nbsp;
								<div class="form-noti cardnoti card_noti_0">카드번호를 입력해주세요.</div>
								<div class="form-noti cardnoti card_noti_1">유효하지 않은 카드번호입니다.</div>
								<div class="form-noti cardnoti card_noti_2">이미 등록된 카드번호입니다.</div>
								<div class="form-noti cardnoti card_suc">본인인증성공</div>
							</div>
							<div class="form-body">
								<input name="dreamCardno" id="cardelem" class="form-elem cardelem" type="text" maxlength="20" placeholder="숫자만 입력">
							</div>
							
							<div class="form-head form-head2">
								닉네임&nbsp;
								<span class="required">*</span>&nbsp;&nbsp;
								<div class="form-noti nicknoti nick_noti_0">닉네임을 입력해 주세요.</div>
								<div class="form-noti nicknoti nick_noti_1">한글 2자 이상 입력</div>
								<div class="form-noti nicknoti nick_noti_2">이미 사용중인 닉네임입니다.</div>
							</div>
							<div class="form-body">
								<input name="userNick" class="form-elem nickelem" type="text" maxlength="20" placeholder="한글 2자 이상 입력">
							</div>
							
							<div class="form-head form-head2">
								휴대폰번호&nbsp;
								<span class="required">*</span>&nbsp;&nbsp;
								<div class="form-noti phonenoti phone_noti_0">휴대폰번호를 입력해 주세요.</div>
								<div class="form-noti phonenoti phone_noti_2">이미 등록된 번호입니다.</div>
							</div>
							<div class="form-body">
								<input name="userPhone" id="phoneelem" class="form-elem phoneelem" type="text" maxlength="13" placeholder="숫자만 입력">
							</div>
							
							<div class="form-head form-head2">
								이메일&nbsp;
								<span class="required">*</span>&nbsp;&nbsp;
								<div class="form-noti emailnoti email_noti_0">이메일을 입력해 주세요.</div>
								<div class="form-noti emailnoti email_noti_1">이메일 형식이 올바르지 않습니다.</div>
								<div class="form-noti emailnoti email_noti_2">이미 사용중인 이메일입니다.</div>
							</div>
							<div class="form-body">
								<input name="userEmail" class="form-elem emailelem" type="text" maxlength="50" placeholder="아이디@도메인으로 입력">
							</div>
							<button class="submit-btn" type="submit">가입하기</button>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</form>
					</div>
					
					<!-- 일반회원 -->
					<div id="mzEnrollView" class="tab-content">
						<form action="mzRegister.dz" method="post">
							<div class="form-head">
								아이디&nbsp;
								<span class="required">*</span>&nbsp;&nbsp;
								<div class="form-noti idnoti userid-noti-0">아이디를 입력해 주세요.</div>
								<div class="form-noti idnoti userid-noti-1">영문소문자로 시작, 영문소문자, 숫자 포함 6~20자</div>
								<div class="form-noti idnoti userid-noti-2">이미 사용중인 아이디입니다.</div>
								<div class="form-noti idnoti userid_suc">사용가능한 아이디입니다.</div>
							</div>
							<div class="form-body">
								<input name="userId" class="form-elem idelem" type="text" maxlength="20" placeholder="영문소문자, 숫자 포함 6~20자">
							</div>
							
							<div class="form-head form-head2">
								비밀번호&nbsp;
								<span class="required">*</span>&nbsp;&nbsp;
								<div class="form-noti pwnoti password_noti_0">비밀번호를 입력해 주세요.</div>
								<div class="form-noti pwnoti password_noti_1">영문소문자, 숫자 포함 6~20자</div>
								<div class="form-noti pwnoti password_noti_2">비밀번호가 일치하지 않습니다.</div>
							</div>
							<div class="form-body">
								<input name="userPw" class="form-elem pwdelem" type="password" maxlength="20" placeholder="영문, 숫자 또는 혼합 6~20자">
								<input name="re_pwd" class="form-elem pwdelem re_pwd" type="password" maxlength="20" placeholder="비밀번호 재입력">
							</div>
							
							<div class="form-head form-head2">
								이름&nbsp;
								<span class="required">*</span>&nbsp;&nbsp;
								<div class="form-noti namenoti name_noti_0">이름을 입력해 주세요.</div>
								<div class="form-noti namenoti name_noti_1">한글 2자 이상 입력</div>
							</div>
							<div class="form-body">
								<input name="userName" class="form-elem nameelem" type="text" maxlength="20" placeholder="한글 2자 이상 입력">
							</div>
							
							<div class="form-head form-head2">
								닉네임&nbsp;
								<span class="required">*</span>&nbsp;&nbsp;
								<div class="form-noti nicknoti nick_noti_0">닉네임을 입력해 주세요.</div>
								<div class="form-noti nicknoti nick_noti_1">한글 2자 이상 입력</div>
								<div class="form-noti nicknoti nick_noti_2">이미 사용중인 닉네임입니다.</div>
							</div>
							<div class="form-body">
								<input name="userNick" class="form-elem nickelem" type="text" maxlength="20" placeholder="한글 2자 이상 입력">
							</div>
							
							<div class="form-head form-head2">
								휴대폰번호&nbsp;
								<span class="required">*</span>&nbsp;&nbsp;
								<div class="form-noti phonenoti phone_noti_0">휴대폰번호를 입력해 주세요.</div>
								<div class="form-noti phonenoti phone_noti_2">이미 등록된 번호입니다.</div>
							</div>
							<div class="form-body">
								<input name="userPhone" id="mzphoneelem" class="form-elem phoneelem" type="text" maxlength="13" placeholder="숫자만 입력">
							</div>
							
							<div class="form-head form-head2">
								이메일&nbsp;
								<span class="required">*</span>&nbsp;&nbsp;
								<div class="form-noti emailnoti email_noti_0">이메일을 입력해 주세요.</div>
								<div class="form-noti emailnoti email_noti_1">이메일 형식이 올바르지 않습니다.</div>
								<div class="form-noti emailnoti email_noti_2">이미 사용중인 이메일입니다.</div>
							</div>
							<div class="form-body">
								<input name="userEmail" class="form-elem emailelem" type="text" maxlength="50" placeholder="아이디@도메인으로 입력">
							</div>
							<button class="submit-btn" type="submit">가입하기</button>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</form>
					</div>
					
					<!-- 사업자회원 -->
					<div id="partnerEnrollView" class="tab-content">
						<form action="partnerRegister.dz" method="post">
							<div class="form-head">
								아이디&nbsp;
								<span class="required">*</span>&nbsp;&nbsp;
								<div class="form-noti idnoti userid-noti-0">아이디를 입력해 주세요.</div>
								<div class="form-noti idnoti userid-noti-1">영문소문자로 시작, 영문소문자, 숫자 포함 6~20자</div>
								<div class="form-noti idnoti userid-noti-2">이미 사용중인 아이디입니다.</div>
								<div class="form-noti idnoti userid_suc">사용가능한 아이디입니다.</div>
							</div>
							<div class="form-body">
								<input name="userId" class="form-elem idelem" type="text" maxlength="20" placeholder="영문소문자, 숫자 포함 6~20자">
							</div>
							
							<div class="form-head form-head2">
								비밀번호&nbsp;
								<span class="required">*</span>&nbsp;&nbsp;
								<div class="form-noti pwnoti password_noti_0">비밀번호를 입력해 주세요.</div>
								<div class="form-noti pwnoti password_noti_1">영문소문자, 숫자 포함 6~20자</div>
								<div class="form-noti pwnoti password_noti_2">비밀번호가 일치하지 않습니다.</div>
							</div>
							<div class="form-body">
								<input name="userPw" class="form-elem pwdelem" type="password" maxlength="20" placeholder="영문, 숫자 또는 혼합 6~20자">
								<input name="re_pwd" class="form-elem pwdelem re_pwd" type="password" maxlength="20" placeholder="비밀번호 재입력">
							</div>
							
							<div class="form-head form-head2">
								사업자명&nbsp;
								<span class="required">*</span>&nbsp;&nbsp;
								<div class="form-noti pnamenoti pname_noti_0">사업자명을 입력해 주세요.</div>
								<div class="form-noti pnamenoti pname_noti_1">한글 2자 이상 입력</div>
							</div>
							<div class="form-body">
								<input name="userName" class="form-elem pnameelem" type="text" maxlength="20" placeholder="한글 2자 이상 입력">
							</div>
							
							<div class="form-head form-head2">
								간이사업자명&nbsp;
								<span class="required">*</span>&nbsp;&nbsp;
								<div class="form-noti simplenamenoti simplename_noti_0">간이사업자명을 입력해 주세요.</div>
								<div class="form-noti simplenamenoti simplename_noti_1">한글 2자 이상 입력</div>
							</div>
							<div class="form-body">
								<input name="partnerName" class="form-elem simplenameelem" type="text" maxlength="20" placeholder="한글 2자 이상 입력">
							</div>
							
							<div class="form-head form-head2">
								연락처&nbsp;
								<span class="required">*</span>&nbsp;&nbsp;
								<div class="form-noti phonenoti phone_noti_0">연락처를 입력해 주세요.</div>
								<div class="form-noti phonenoti phone_noti_2">이미 등록된 번호입니다.</div>
							</div>
							<div class="form-body">
								<input name="userPhone" id="pphoneelem" class="form-elem phoneelem" type="tel" maxlength="13" placeholder="숫자만 입력">
							</div>
							
							<div class="form-head form-head2">
								사업자등록번호&nbsp;
								<span class="required">*</span>&nbsp;&nbsp;
								<div class="form-noti pverinoti pveri_noti_0">사업자등록번호를 입력해주세요.</div>
								<div class="form-noti pverinoti pveri_noti_1">형식이 올바르지 않습니다.</div> 
								<div class="form-noti pverinoti pveri_noti_2">이미 등록된 번호입니다.</div>
								<div class="form-noti pverinoti pveri_suc">본인인증성공</div>
								<div class="form-noti pverinoti pveri_success">유효한 사업자등록번호입니다.</div>
								<div class="form-noti pverinoti pveri_noti_3">유효하지 않은 사업자등록번호입니다.</div>
							</div>
							
							<div class="form-body">
								<input name="partnerVerify" id="pverielem" class="form-elem pverielem" type="text" maxlength="12" placeholder="숫자만 입력">
							</div>
							
							
							<div class="form-head form-head2">
								이메일&nbsp;
								<span class="required">*</span>&nbsp;&nbsp;
								<div class="form-noti emailnoti email_noti_0">이메일을 입력해 주세요.</div>
								<div class="form-noti emailnoti email_noti_1">이메일 형식이 올바르지 않습니다.</div>
								<div class="form-noti emailnoti email_noti_2">이미 사용중인 이메일입니다.</div>
							</div>
							<div class="form-body">
								<input name="userEmail" class="form-elem emailelem" type="text" maxlength="50" placeholder="아이디@도메인으로 입력">
							</div>
							<button class="submit-btn" type="submit">가입하기</button>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</form>
					</div>
				</div>
			</div>
		</div>
	</main>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
<script>
	$(function() {
		// 탭별로 양식 다르게 출력
		$('.tabmenu').click(function() {
			var activeTab = $(this).attr('data-tab');
			$('.tabmenu').css('background-color', '#f4f4f4');
			$('.tabmenu').css('color', '#333');
			$(this).css('background-color', '#0160ff');
			$(this).css('color', '#fff');
			$('.ul.tabs li').removeClass('current');
			$('.tab-content').removeClass('current');
			$(this).addClass('current');
			$("#"+activeTab).addClass('current');
		
			// 아이디 유효성검사@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
			var userId = $(".current .idelem");
			var regExp = /^[a-z][a-z0-9]{5,11}$/;
			$('.current .idelem').keyup(function() {
				$('.current .idnoti').css('display', 'none');
				/* var userId = $(".current .idelem").val(); */
				$.ajax({
					url : "dupId.dz",
					data : { "userId" : userId.val() },
					success : function(result) {
						//2이미 사용중인 아이디입니다.
						if(result != 0){
							$('.current .idnoti').css('display', 'none');
							$('.current .userid-noti-2').css('color', '#ff5442');
							$('.current .userid-noti-2').css('display', 'block');
							$('.current .idelem').css('border', '1px solid #ff5442');
						} else if (!regExp.test(userId.val())) {
								$('.current .userid-noti-1').css('color', '#ff5442');
								$('.current .userid-noti-1').css('display', 'block');
								$('.current .idelem').css('border', '1px solid #ff5442');
						}else{
							$('.current .idnoti').css('display', 'none');
							$('.current .userid_suc').css('display', 'block');
							$('.current .userid_suc').css('color', '#0160ff');
							$('.current .idelem').css('border', '0');
						}
					},
					error : function() {
						console.log("전송실패");
					}
				});
			});
			$(".current .idelem").on("blur", function() {
				if(userId.val() ==""){ 
					$('.current .idnoti').css('display', 'none'); 
					$('.current .userid-noti-0').css('color', '#ff5442');
					$('.current .userid-noti-0').css('display', 'block');
					$('.current .idelem').css('border', '1px solid #ff5442');
				}
		 });  
			
			///비밀번호 찾기 유효성검사@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
			var userPwd = $(".current .pwdelem");
			var regExpPw = /^[a-z0-9][a-z0-9]{5,11}$/;
			userPwd.keyup(function() {
				$('.current .pwnoti').css('display', 'none');
				if (!regExpPw.test(userPwd.val())) {
					$('.current .password_noti_1').css('color', '#ff5442');
					$('.current .password_noti_1').css('display', 'block');
					$('.current .pwdelem').css('border', '1px solid #ff5442');
				}else{
					$('.current .pwnoti').css('display', 'none');
					$('.current .pwdelem').css('border', '0');
				}
			});
			$(".current .re_pwd").keyup(function() {
				$('.current .pwnoti').css('display', 'none');
				if($(".current .re_pwd").val()!=userPwd.val()){
					$('.current .pwnoti').css('display', 'none');
					$('.current .password_noti_2').css('color', '#ff5442');
					$('.current .password_noti_2').css('display', 'block');
					$('.current .re_pwd').css('border', '1px solid #ff5442');
				}else{
					$('.current .pwnoti').css('display', 'none');
					$('.current .pwdelem').css('border', '0');
				}
			});
			/////비밀번호 입력해주세요
			userPwd.on("blur", function() {
				$('.current .pwnoti').css('display', 'none');
				if (userPwd.val() =="") {
					$('.current .password_noti_0').css('color', '#ff5442');
					$('.current .password_noti_0').css('display', 'block');
					$('.current .pwdelem').css('border', '1px solid #ff5442');
				}else if(!regExpPw.test(userPwd.val())){
					$('.current .pwnoti').css('display', 'none');
					$('.current .password_noti_1').css('color', '#ff5442');
					$('.current .password_noti_1').css('display', 'block');
					$('.current .pwdelem').css('border', '1px solid #ff5442');
				}else if($(".current .re_pwd").val()==""){
					$('.current .re_pwd').css('border', '1px solid #ff5442');
				}else if($(".current .re_pwd").val()!=userPwd.val()){
					$('.current .pwnoti').css('display', 'none');
					$('.current .password_noti_2').css('color', '#ff5442');
					$('.current .password_noti_2').css('display', 'block');
					$('.current .re_pwd').css('border', '1px solid #ff5442');
				}else{
					$('.current .pwnoti').css('display', 'none');
					$('.current .pwdelem').css('border', '0');
				}
			});
			
			//이름 유효성 검사@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
			var userName = $(".current .nameelem");
			var regExpName = /^[가-힣]{2,11}$/;
			userName.keyup(function() {
				$('.current .namenoti').css('display', 'none');
				if (!regExpName.test(userName.val())) {
					$('.current .name_noti_1').css('color', '#ff5442');
					$('.current .name_noti_1').css('display', 'block');
					$('.current .nameelem').css('border', '1px solid #ff5442');
				}else{
					$('.current .namenoti').css('display', 'none');
					$('.current .nameelem').css('border', '0');
				}
			});
			userName.on("blur", function() {
				$('.current .namenoti').css('display', 'none');
				if (userName.val() =="") {
					$('.current .name_noti_0').css('color', '#ff5442');
					$('.current .name_noti_0').css('display', 'block');
					$('.current .nameelem').css('border', '1px solid #ff5442');
				}else if(!regExpName.test(userName.val())){
					$('.current .namenoti').css('display', 'none');
					$('.current .name_noti_1').css('color', '#ff5442');
					$('.current .name_noti_1').css('display', 'block');
					$('.current .nameelem').css('border', '1px solid #ff5442');
				}else{
					$('.current .namenoti').css('display', 'none');
					$('.current .nameelem').css('border', '0');
				}
			});
			
			//간이사업자명 영어허용@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
			userSimpleName = $(".current .simplenameelem");
			var regExpSimpleName = /^[가-힣,a-z,A-Z]{2,11}$/; //undefind를 소문자로 받아들인다
			userSimpleName.keyup(function() {
				$('.current .simplenamenoti').css('display', 'none');
				if (!regExpSimpleName.test(userSimpleName.val())) {
					$('.current .simplename_noti_1').css('color', '#ff5442');
					$('.current .simplename_noti_1').css('display', 'block');
					$('.current .simplenameelem').css('border', '1px solid #ff5442');
				}else{
					$('.current .simplenamenoti').css('display', 'none');
					$('.current .simplenameelem').css('border', '0');
				}
			});
			userSimpleName.on("blur", function() {
				$('.current .simplenamenoti').css('display', 'none');
				if (userSimpleName.val() =="") {
					$('.current .simplename_noti_0').css('color', '#ff5442');
					$('.current .simplename_noti_0').css('display', 'block');
					$('.current .simplenameelem').css('border', '1px solid #ff5442');
				}else if(!regExpSimpleName.test(userSimpleName.val())){
					$('.current .simplenamenoti').css('display', 'none');
					$('.current .simplename_noti_1').css('color', '#ff5442');
					$('.current .simplename_noti_1').css('display', 'block');
					$('.current .simplenameelem').css('border', '1px solid #ff5442');
				}else{
					$('.current .siplenamenoti').css('display', 'none');
					$('.current .simplenameelem').css('border', '0');
				}
			});
			
			//사업자명-(주)괄호 들어가도 됨, 영어허용 유효성 검사@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
			var userPName = $(".current .pnameelem");
			var regExpPName = /^[가-힣,a-z,A-Z()]{2,11}$/;
			userPName.keyup(function() {
				$('.current .pnamenoti').css('display', 'none');
				if (!regExpPName.test(userPName.val())) {
					$('.current .pname_noti_1').css('color', '#ff5442');
					$('.current .pname_noti_1').css('display', 'block');
					$('.current .pnameelem').css('border', '1px solid #ff5442');
				}else{
					$('.current .pnamenoti').css('display', 'none');
					$('.current .pnameelem').css('border', '0');
				}
			});
			$(".current .pnameelem").on("blur", function() {
				$('.current .pnamenoti').css('display', 'none');
				if (userPName.val() =="") {
					$('.current .pname_noti_0').css('color', '#ff5442');
					$('.current .pname_noti_0').css('display', 'block');
					$('.current .pnameelem').css('border', '1px solid #ff5442');
				}else if(!regExpPName.test(userPName.val())){
					$('.current .pnamenoti').css('display', 'none');
					$('.current .pname_noti_1').css('color', '#ff5442');
					$('.current .pname_noti_1').css('display', 'block');
					$('.current .pnameelem').css('border', '1px solid #ff5442');
				}else{
					$('.current .pnamenoti').css('display', 'none');
					$('.current .pnameelem').css('border', '0');
				}
			});
			
			///카드번호@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
			var userCard = $(".current .cardelem");
			var dreamCardno = $(".current .cardelem");
			//자동 - 생성
			var autoHypenCard = function(str){
			      str = str.replace(/[^0-9]/g, '');
			      var tmp = '';
			      if( str.length < 5){
			          return str;
			      }else if(str.length < 9){
			          tmp += str.substr(0, 4);
			          tmp += '-';
			          tmp += str.substr(4);
			          return tmp;
			      }else if(str.length < 12){
			          tmp += str.substr(0, 4);
			          tmp += '-';
			          tmp += str.substr(4, 4);
			          tmp += '-';
			          tmp += str.substr(8);
			          return tmp;
			      }else{              
			          tmp += str.substr(0, 4);
			          tmp += '-';
			          tmp += str.substr(4, 4);
			          tmp += '-';
			          tmp += str.substr(8, 4);
			          tmp += '-';
			          tmp += str.substr(12, 4);
			          return tmp;
			      }
			}
			var cardNum = document.getElementById('cardelem');
			cardNum.onkeyup = function(){
			  console.log(this.value);
			  this.value = autoHypenCard( this.value ) ;  
			}
			
			// 카드데이터와 일치여부 - 유효하지 않은카드번호입니다.
			$('.current .cardelem').keyup(function() {
				$('.current .cardnoti').css('display', 'none');
				$.ajax({
					url : "dupCard.dz",
					type : "get",
					data : { "userName" : userName.val(), "dreamCardno" : dreamCardno.val() },
					success : function(result) {
						if(result == 0){
							$('.current .cardnoti').css('display', 'none');
							$('.current .card_noti_1').css('color', '#ff5442');
							$('.current .card_noti_1').css('display', 'block');
							$('.current .cardelem').css('border', '1px solid #ff5442');
						}else if(result == 1){
							$('.current .cardnoti').css('display', 'none');
							$('.current .card_noti_2').css('color', '#ff5442');
							$('.current .card_noti_2').css('display', 'block');
							$('.current .cardelem').css('border', '1px solid #ff5442');
						}else if(result == 2){
							$('.current .cardnoti').css('display', 'none');
							$('.current .card_suc').css('display', 'block');
							$('.current .card_suc').css('color', '#0160ff');
							$('.current .cardelem').css('border', '0');
						}
					},
					error : function() {
						console.log("전송실패");
					}
				});
			});
			// 안적었을때 - 카드번호를입력해주세요
			$(".current .cardelem").on("blur", function() {
				//$('.current .cardnoti').css('display', 'none');
				if (userCard.val() =="") {
					$('.current .card_noti_0').css('color', '#ff5442');
					$('.current .card_noti_0').css('display', 'block');
					$('.current .cardelem').css('border', '1px solid #ff5442');
				}else{
					/* $('.current .cardnoti').css('display', 'none');
					$('.current .cardelem').css('border', '0'); */
				}
			});
			
			//닉네임 유효성 검사@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
			var userNick = $(".current .nickelem");
			var regExpNick = /^[가-힣,a-z,A-Z]{2,11}$/;
			userNick.keyup(function() {
				$('.current .nicknoti').css('display', 'none');
				$.ajax({
					url : "dupNick.dz",
					type : "get",
					data : { "userNick" : userNick.val()},
					success : function(result) {
						if(result != 0){
							$('.current .nick_noti_2').css('color', '#ff5442');
							$('.current .nick_noti_2').css('display', 'block');
							$('.current .nickelem').css('border', '1px solid #ff5442');
						}else if(!regExpNick.test(userNick.val())){
							$('.current .nick_noti_1').css('color', '#ff5442');
							$('.current .nick_noti_1').css('display', 'block');
							$('.current .nickelem').css('border', '1px solid #ff5442');
						}else{
							$('.current .nicknoti').css('display', 'none');
							$('.current .nickelem').css('border', '0');
						}
					},
					error : function() {
						console.log("전송실패");
					}
				});
				
			});
			$(".current .nickelem").on("blur", function() {
				if (userNick.val() =="") {
					$('.current .nicknoti').css('display', 'none');
					$('.current .nick_noti_0').css('color', '#ff5442');
					$('.current .nick_noti_0').css('display', 'block');
					$('.current .nickelem').css('border', '1px solid #ff5442');
				}
			});
			
			///휴대폰번호@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
			//자동 - 생성
			var autoHypenPhone = function(str){
			      str = str.replace(/[^0-9]/g, '');
			      var tmp = '';
			      if( str.length < 4){
			          return str;
			      }else if(str.length < 7){
			          tmp += str.substr(0, 3);
			          tmp += '-';
			          tmp += str.substr(3);
			          return tmp;
			      }else if(str.length < 11){
			          tmp += str.substr(0, 3);
			          tmp += '-';
			          tmp += str.substr(3, 3);
			          tmp += '-';
			          tmp += str.substr(6);
			          return tmp;
			      }else{              
			          tmp += str.substr(0, 3);
			          tmp += '-';
			          tmp += str.substr(3, 4);
			          tmp += '-';
			          tmp += str.substr(7);
			          return tmp;
			      }
			      return str;
			}
	
			var phoneNum = document.getElementById('phoneelem');
	
			phoneNum.onkeyup = function(){
			  console.log(this.value);
			  this.value = autoHypenPhone( this.value ) ;  
			}
			
			//mz휴대폰번호
			var mzphoneNum = document.getElementById('mzphoneelem');
			
			mzphoneNum.onkeyup = function(){
			  console.log(this.value);
			  this.value = autoHypenPhone( this.value ) ;  
			}
			////////////////mz휴대폰번호끝
			
			// 중복(2) - 이미 등록된 번호입니다
			var userPhone = $(".current .phoneelem");
			userPhone.keyup(function() {
				$('.current .phonenoti').css('display', 'none');
				$.ajax({
					url : "dupPhone.dz",
					data : { "userPhone" : userPhone.val() },
					success : function(result) {
						if(result != 0){
							//$('.current .phonenoti').css('display', 'none');
							$('.current .phone_noti_2').css('color', '#ff5442'); // 에러메시지:이미 등록된 휴대폰번호
							$('.current .phone_noti_2').css('display', 'block');
							$('.current .phoneelem').css('border', '1px solid #ff5442');
						}else {
							$('.current .phonenoti').css('display', 'none');
							$('.current .phoneelem').css('border', '0');
						}
					},
					error : function() {
						console.log("전송실패");
					}
				});
			});
			// 안적었을때(0) - 휴대폰번호를입력해주세요
			$(".current .phoneelem").on("blur", function() {
				if (userPhone.val() =="") {
					$('.current .phonenoti').css('display', 'none');
					$('.current .phone_noti_0').css('color', '#ff5442');
					$('.current .phone_noti_0').css('display', 'block');
					$('.current .phoneelem').css('border', '1px solid #ff5442');
				}
			});
			
			///사업자 연락처 -위치 수정@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
			//자동 - 생성
			var autoHypenPPhone = function(str){
			      str = str.replace(/[^0-9]/g, '');
			      var tmp = '';
			      if( str.length < 3){
			          return str;
			      }else if(str.length < 6){
			          tmp += str.substr(0, 2);
			          tmp += '-';
			          tmp += str.substr(2);
			          return tmp;
			      }else if(str.length < 10){
			          tmp += str.substr(0, 2);
			          tmp += '-';
			          tmp += str.substr(2, 3);
			          tmp += '-';
			          tmp += str.substr(5);
			          return tmp;
			      }else{              
			          tmp += str.substr(0, 2);
			          tmp += '-';
			          tmp += str.substr(2, 4);
			          tmp += '-';
			          tmp += str.substr(6);
			          return tmp;
			      }
			  
			      return str;
			}
	
			var pphoneNum = document.getElementById('pphoneelem');
	
			pphoneNum.onkeyup = function(){
			  console.log(this.value);
			  this.value = autoHypenPhone( this.value ) ;  
			}
			
			/// 사업자번호@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
			userPVeri = $(".current .pverielem");
			//자동 - 생성
			var autoHypenPVeri = function(str){
			      str = str.replace(/[^0-9]/g, '');
			      var tmp = '';
			      if( str.length < 4){
			          return str;
			      }else if(str.length < 7){
			          tmp += str.substr(0, 3);
			          tmp += '-';
			          tmp += str.substr(3);
			          return tmp;
			      }else{              
			          tmp += str.substr(0, 3);
			          tmp += '-';
			          tmp += str.substr(3, 2);
			          tmp += '-';
			          tmp += str.substr(5);
			          return tmp;
			      }
			}
			var pveriNum = document.getElementById('pverielem');
			pveriNum.onkeyup = function(){
			  console.log(this.value);
			  this.value = autoHypenPVeri( this.value ) ;  
			}
			
			// 회원데이터와 일치여부 - 이미 등록된 번호입니다
			$('.pverielem').keyup(function() {
				$('.pverinoti').css('display', 'none');
				$.ajax({
					url : "dupPveri.dz",
					data : { "partnerVerify" : userPVeri.val() },
					success : function(result) {
						if(result != 0){
							$('.pveri_noti_2').css('color', '#ff5442');
							$('.pveri_noti_2').css('display', 'block');
							$('.pverielem').css('border', '1px solid #ff5442');
						}else{
							$('.pverinoti').css('display', 'none');
							$('.pverielem').css('border', '0');
						}
					},
					error : function() {
						console.log("전송실패");
					}
				});
			});
			// 안적었을때 - 사업자번호를입력해주세요
			$(".pverielem").on("blur", function() {
				if (userPVeri.val() =="") {
					$('.pveri_noti_0').css('color', '#ff5442');
					$('.pveri_noti_0').css('display', 'block');
					$('.pverielem').css('border', '1px solid #ff5442');
				}else{
					var test = $("#pverielem").val();
					var str = test.replace(/-/gi, "");
					var strArr = str.split("");
					var multiply = new Array(1,3,7,1,3,7,1,3,5);
					var checkSum = 0;
					
					for(var i = 0; i < 9; i++){
						checkSum += multiply[i] * Number(strArr[i]);
					}
					
					if(10 - ((checkSum + Math.floor(multiply[8]*Number(strArr[8])/10)) %10) === Number(strArr[9])){
						$('.pveri_success').css('color', '#0160ff');
						$('.pveri_success').css('display', 'block');
						$('.pverielem').css('border', '0');
					}
					else{
						$('.pveri_noti_3').css('color', '#ff5442');
						$('.pveri_noti_3').css('display', 'block');
						$('.pverielem').css('border', '1px solid #ff5442');
					}
				}
			});
			
			
			
			// 이메일 유효성검사@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
			userEmail = $(".current .emailelem");
			var emailReg = /[a-zA-Z0-9]{4,12}\@/;
			$(".current .emailelem").keyup(function() {
				$('.current .emailnoti').css('display', 'none');
				$.ajax({
					url : "dupEmail.dz",
					data : { "userEmail" : userEmail.val() },
					success : function(result) {
						if(result != 0){
							$('.current .email_noti_2').css('color', '#ff5442');
							$('.current .email_noti_2').css('display', 'block');
							$('.current .emailelem').css('border', '1px solid #ff5442');
						}else if(!emailReg.test(userEmail.val())) {
							$('.current .emailnoti').css('display', 'none');
							$('.current .email_noti_1').css('color', '#ff5442');
							$('.current .email_noti_1').css('display', 'block');
							$('.current .emailelem').css('border', '1px solid #ff5442');
						}else {
							$('.current .emailnoti').css('display', 'none');
							$('.current .emailelem').css('border', '0');
						}
					},
					error : function() {
						console.log("전송실패");
					}
				});
			});
			// 안적었을때
			$(".current .emailelem").on("blur", function() {
				if (userEmail.val() =="") {
					$('.current .emailnoti').css('display', 'none');
					$('.current .email_noti_0').css('color', '#ff5442');
					$('.current .email_noti_0').css('display', 'block');
					$('.current .emailelem').css('border', '1px solid #ff5442');
				}
			});
			
			///////////////제출버튼@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
			$('.current .submit-btn').click(function() {
				var rtn = true;
				
				//아이디
				$.ajax({
					url : "dupId.dz",
					data : { "userId" : userId.val() },
					async: false,
					success : function(result) {
						if(result != 0){
							alert("사용중인 아이디입니다. 아이디를 다시 입력해주세요.");
							userId.focus();
							rtn = false;
						}else if(userId.val() =="") {
							alert("아이디를 입력해주세요.");
							userId.focus();
							rtn = false;
						}else if (!regExp.test(userId.val())) {
							alert("아이디가 올바르지 않습니다. 다시 입력해주세요.");
							userId.focus();
							rtn = false;
						}else {
							rtn = true;
						}
					},
					error : function() {
						console.log("전송실패");
					}
				});

				//비밀번호
				if (userPwd.val() =="") {
					alert("비밀번호를 입력해주세요.");
					userPwd.focus();
					rtn = false;
				}else if (!regExpPw.test(userPwd.val())) {
					alert("비밀번호가 올바르지 않습니다. 다시 입력해주세요.");
					userPwd.focus();
					rtn = false;
				}else if($(".current .re_pwd").val()!=userPwd.val()) {
					alert("비밀번호가 올바르지 않습니다. 다시 입력해주세요.");
					userPwd.focus();
					rtn = false;
				}
				
				//이름
				else if (userName.val() =="") {
					alert("이름을 입력해주세요.");
					userName.focus();
					rtn = false;
				}else if(userName.length != 0 && !regExpName.test(userName.val())){
					alert("이름이 올바르지 않습니다. 다시 입력해주세요.");
					userName.focus();
					rtn = false;
				} 
				
				//사업자명
				else if (userPName.val() =="") {
					alert("사업자명을 입력해주세요.");
					userPName.focus();
					rtn = false;
				}else if(userPName.length != 0 && !regExpPName.test(userPName.val())){
					alert("사업자명이 올바르지 않습니다. 다시 입력해주세요.");
					userPName.focus();
					rtn = false;
				}
				
				//간이사업자명//////////////////////
				else if (userSimpleName.val() =="") {
					alert("간이사업자명을 입력해주세요.");
					userSimpleName.focus();
					rtn = false;
				}else if(userSimpleName.length != 0 && !regExpSimpleName.test(userSimpleName.val())){
					alert("간이사업자명이 올바르지 않습니다. 다시 입력해주세요.");
					userSimpleName.focus();
					rtn = false;
				}
				
				///카드번호
				$.ajax({
					url : "dupCard.dz",
					type : "get",
					async: false,
					data : { "userName" : userName.val(), "dreamCardno" : dreamCardno.val() },
					success : function(result) {
						if (userCard.val() =="") {
							alert("카드번호를 입력해주세요.");
							userCard.focus();
							rtn = false;
						}else if(result == 0){
							alert("유효하지 않은 카드번호입니다. 카드번호를 다시 입력해주세요.");
							userCard.focus();
							rtn = false;
						}else if(result == 1){
							alert("이미 존재하는 카드번호입니다. 카드번호를 다시 입력해주세요.");
							userCard.focus();
							rtn = false;
						}
					},
					error : function() {
						console.log("전송실패");
					}
				});
				
				//닉네임
				$.ajax({
					url : "dupNick.dz",
					type : "get",
					data : { "userNick" : userNick.val()},
					success : function(result) {
						if (userNick.val() =="") {
							alert("닉네임을 입력해주세요.");
							userNick.focus();
							rtn = false;
						}else if(result != 0){
							alert("이미 사용중인 닉네임입니다. 다시 입력해주세요.");
							userNick.focus();
							rtn = false;
						}else if(!regExpNick.test(userNick.val())){
							alert("닉네임이 올바르지 않습니다. 다시 입력해주세요.");
							userNick.focus();
							rtn = false;
						}
					},
					error : function() {
						console.log("전송실패");
					}
				});
				
				
				///휴대폰번호
				$.ajax({
					url : "dupPhone.dz",
					data : { "userPhone" : userPhone.val() },
					async: false,
					success : function(result) {
						if (userPhone.val() =="") {
							alert("휴대폰번호를 입력해주세요.");
							userPhone.focus();
							rtn = false;
						}else if(result != 0){
							alert("이미 등록된 휴대폰번호입니다. 다시 입력해주세요.");
							userPhone.focus();
							rtn = false;
						}
					},
					error : function() {
						console.log("전송실패");
					}
				});
				// 사업자 연락처
				
				/// 사업자번호
				$.ajax({
					url : "dupPveri.dz",
					data : { "partnerVerify" : userPVeri.val() },
					async: false,
					success : function(result) {
						if (userPVeri.val() =="") {
							alert("사업자번호를 입력해주세요.");
							userPVeri.focus();
							rtn = false;
						}else if(result != 0){
							alert("이미 등록된 사업자번호입니다. 다시 입력해주세요.");
							userPVeri.focus();
							rtn = false;
						}
					},
					error : function() {
						console.log("전송실패");
					}
				});
				
				// 이메일
				$.ajax({
					url : "dupEmail.dz",
					data : { "userEmail" : userEmail.val() },
					async: false,
					success : function(result) {
						if (userEmail.val() =="") {
							alert("이메일을 입력해주세요.");
							userEmail.focus();
							rtn = false;
						}else if(result != 0){
							alert("이미 등록된 이메일입니다. 다시 입력해주세요.");
							userEmail.focus();
							rtn = false;
						}else if(!emailReg.test(userEmail.val())) {
							alert("이메일이 올바르지 않습니다. 다시 입력해주세요.");
							userEmail.focus();
							rtn = false;
						}
					},
					error : function() {
						console.log("전송실패");
					}
				});
				
				return rtn;
			});
			
		});
		// 기본으로 꿈나무회원이 클릭되어있게 설정
		$('#default').click(); 
			
			
			
			
			
	});
</script>
</html>