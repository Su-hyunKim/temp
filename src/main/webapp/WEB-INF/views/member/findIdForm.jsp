<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>    
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0,
	user-scalable=no, maximum-scale=1.0,minimum-scale=1.0">
<title>징검다리 : ID 찾기</title>
<script src="resources/lib/jquery-3.2.1.min.js"></script>
<script>
$(function(){		
	// EL 값을 읽어오려면 페이지가 완전히 로드된 시점이어야함.
	var header = '${_csrf.headerName}';
	var token = '${_csrf.token}';
	var context = '${pageContext.request.contextPath}';
	let email;
	$('#email_direct').hide();
	$('#email_tail').change(function(){
		if($('#email_tail').val()=='direct') $('#email_direct').show();
		else $('#email_direct').hide();
	});
	$('form').hide();
	$('#bybirthday').click(function(){
		$('#byemail').prop('checked',false);
		$('form').hide();
		$('#bybirthdayf').show();
	});
	$('#byemail').click(function(){
		$('#bybirthday').prop('checked',false);
		$('form').hide();
		$('#byemailf').show();
	});
	$('input').focusout(function(){
		$('span').html('');
	});
	$('#emailSubmit').click(function(){
		if( $('#email').val()=="" ){
			$('#byEmailMessage').html("이메일을 입력해주세요");
			$('#email').focus();
			return false;
		}else if( $('#email_tail').val()=="" ){
			$('#byEmailMessage').html("이메일을 입력해주세요");
			$('#email_tail').focus();
			return false;
		}else if( $('#email_tail').val()=="direct" && $('#email_direct').val()=="" ){
			$('#byEmailMessage').html("이메일을 입력해주세요");
			$('#email_direct').focus();
			return false;
		}else if($('#ename').val()==""){
			$('#byEmailMessage').html("이름을 입력해주세요");
			$('#ename').focus();
			return false;
		}else if( $('#email_tail').val()=="direct" )
			email =  $('#email').val() + "@" + $('#email_direct').val();
		else email = $('#email').val() + "@" + $('#email_tail').val();
		$.ajax({
			type:"post",
			url:context+"/findid",
			data: {
				name: $('#ename').val(),
				email: email
			},
			beforeSend : function(xhr){
				// 전송전에 헤더에 csrf의 값을 설정 해야함
				xhr.setRequestHeader(header, token);
			},
			success:function(resultData) {
				// => 서버로부터 Json 형태의 Data 를 Response 로 받음
				//    "loginSuccess" -> "T" 성공 , 새로고침
				//    "loginSuccess" -> "F" 실패
				// => 성공시 : 성공message, afterlogin처리
				//    실패시 : 실패message, 재로그인 유도;
				if (resultData.exist=="T") {
					alert("ID는" + resultData.id + " 입니다");
					location.href="home";
				}else {
					$('#byEmailMessage').html(resultData.message);
					$('#ename').focus();
				}
			},
			error: function() {
				$('#byEmailMessage').html("~~ 서버 오류 입니다 ~~");
			}
		}); //ajax
		return false;
	}); // click
	$('#birthdaySubmit').click(function(){
		if( ($('#bname').val()=="")){
			$('#byBirthdayMessage').html("이름을 입력해주세요");
			$('#bname').focus();
			return false;
		}else if( ($('#gender').val()=="")){
			$('#byBirthdayMessage').html("성별을 선택해주세요");
			$('#gender').focus();
			return false;
		}else if( ($('#birthday').val()=="")){
			$('#byBirthdayMessage').html("생일을 입력해주세요");
			$('#birthday').focus();
			return false;
		}
		$.ajax({
			type:"post",
			url:context+"/findid",
			data: {
				name: $('#bname').val(),
				gender: $('#gender').val(),
				birthday: $('#birthday').val()
			},
			beforeSend : function(xhr){
				// 전송전에 헤더에 csrf의 값을 설정 해야함
				xhr.setRequestHeader(header, token);
			},
			success:function(resultData) {
				// => 서버로부터 Json 형태의 Data 를 Response 로 받음
				//    "loginSuccess" -> "T" 성공 , 새로고침
				//    "loginSuccess" -> "F" 실패
				// => 성공시 : 성공message, afterlogin처리
				//    실패시 : 실패message, 재로그인 유도;
				if (resultData.exist=="T") {
					alert("ID는" + resultData.id + " 입니다");
					location.href="home";
				}else {
					$('#byBirthdayMessage').html(resultData.message);
					$('#bname').focus();
				}
			},
			error: function() {
				$('#byBirthdayMessage').html("~~ 서버 오류 입니다 ~~");
			}
		}); //ajax
		return false;
	}); // click
});
</script>
<style>
#email,
#email_tail,
#email_direct{
	width:25%;
}
span{
	color:red;
	font-style:italic;
}
.center{
	width:350px;
	margin-left:auto;
	margin-right:auto;
	background:midnightblue;
	text-align:center;
	padding:10px;
	color:lightyellow;
	font-weight:bold;
	border-radius:5px;
}
table{
	color:white;
}
a{
	color:white;
}
</style>
</head>
<body>
<div class="center">
	<h1>ID 찾기</h1>
	<p>아래 방법 중 하나를 선택해주세요</p>
	<table>
		<tr>
			<td><label><input type="radio" id="bybirthday">이름, 성별, 생년월일로 찾기</label><br>
				<form action="findid" method="post" id="bybirthdayf">
					<input type="text" name="name" id="bname" size="20" placeholder="이름입력">&nbsp;
					<select name="gender" id="gender">
						<option value="">성별선택</option>
						<option value="M">남성</option>
						<option value="F">여성</option>
						<option value="N">해당항목없음</option>
					</select><br>
					<label>생년월일&nbsp;<input type="date" name="birthday" id="birthday"></label>&nbsp;
					<button id="birthdaySubmit">ID 찾기</button><br>
					<span id="byBirthdayMessage"></span>
					<s:csrfInput />
				</form>			
			</td>
		</tr>
		<tr>
			<td><label><input type="radio" id="byemail">이메일, 이름으로 찾기</label><br>
				<form action="findid" method="post"  id="byemailf">
					<input type="text" name="email" id="email" placeholder="가입시메일">&nbsp;@&nbsp;
					<select id="email_tail">
						<option value="">선택</option>
						<option value="naver.com">naver.com</option>
						<option value="daum.net">daum.net</option>
						<option value="gmail.com">gmail.com</option>
						<option value="nate.com">nate.com</option>
						<option value="direct">직접입력</option>
					</select>
					<input type="text" id="email_direct" class="direct" placeholder="직접입력"><br>
					<input type="text" name="name" id="ename" size="20" placeholder="이름입력">&nbsp;
					<button id="emailSubmit">ID 찾기</button><br>
					<span id="byEmailMessage"></span>
					<s:csrfInput />
				</form>				
			</td>
		</tr>
	</table>
	<br><br>
	<a href="home">[HOME]</a>
	<br><br>
</div>
</body>
</html>
