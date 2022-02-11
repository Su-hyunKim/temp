<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>징검다리 : Login</title>

	<style>
		table{text-align:center;}
	</style>
	<script src="resources/lib/jquery-3.2.1.min.js"></script>
 	<script>
$(function(){
 	var header = '${_csrf.headerName}';
 	var token = '${_csrf.token}';
 	var context = '${pageContext.request.contextPath}';
 	
/*	Spring Security login
-> 요청명은 login , method='POST' 
-> Tag name 은 username, password 로 함
-> 스프링 시큐리티가 적용된 사이트의 Post 방식에는 CSRF 토큰을 사용함 */	
	$('#login').hover(function(){$(this).css({cursor:"pointer"})},
			function(){$(this).css({curcor:"default"})})
		.click(function(e){
			$.ajax({
				type:"post",
				url: context + "/login",
				data: {
					username: $('#modal_form #member_id').val(),
					password: $('#modal_form #password').val()
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
					
					// 문자열 형태의 Data를 json Object로 변환 
					if(resultData.indexOf('<')==-1) resultData = JSON.parse(resultData);
					if (resultData.loginSuccess=="T") {
						alert("~~ Login 성공 ~~");
						location.href="afterlogin?member_id="+resultData.id;
					}else {
						$('#message').html(resultData.message);
						$('#modal_form #member_id').focus();
					}
				},
				error: function() {
					$('#message').html("~~ 서버 오류 입니다 ~~");
				}
			}); //ajax
			return false;
		}); //jslogin_click 
		
		
		$('#findpwf').click(function(e){
			$.ajax({
				type:"get",
				url: context + "/findpwf",
				success:function(resultPage) {
							$('.modal_content').html(resultPage);
						},
				error: function() {
							$('#message').html("~~ 서버 오류 입니다 ~~");
						}
			});//ajax
			return false;
		}); //findpwf_click
			
/* 	$('.modalClose').click(function(e){
		$('.modal,.modal_content').hide();
		e.stopPropagation();
	}); */
	
});
 	</script>
</head>
<body>
<div class="wrapped">
<h1>로그인</h1>
<form action="login" method="post" id="modal_form">
<table>
	<tr><td bgcolor="gray">I D</td>
		<td><input type="text" name="member_id" id="member_id" value="admin"></td></tr>
	<tr><td bgcolor="gray">Password</td>
		<td><input type="password" name="password" id="password" value="1234567!"></td></tr>
	<tr><td colspan="2">
			<button id="login">Login</button>&nbsp; 
			<input type="reset" value="Reset"><br>
			<a href="joinf?R=joinf">[회원가입]</a>&nbsp;
			<a href="findidf">[아이디 찾기]</a>&nbsp;
			<a href="findpwf" id="findpwf">[비밀번호 찾기]</a>			
		</td>
	</tr> 
</table>
</form>
<!-- <div class="modalClose">X</div> -->
<span id="message"></span>
</div>
</body>
</html> 