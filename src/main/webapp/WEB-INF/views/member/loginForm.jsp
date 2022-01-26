<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
	<script src="resources/lib/jquery-3.2.1.min.js"></script>
 	<script>
 	var header = '${_csrf.headerName}';
 	var token = '${_csrf.token}';

/*	Spring Security login
-> 요청명은 login , method='POST' 
-> Tag name 은 username, password 로 함
-> 스프링 시큐리티가 적용된 사이트의 Post 방식에는 CSRF 토큰을 사용함 */	
	$('#login').hover(function(){$(this).css({cursor:"pointer"})},
			function(){$(this).css({curcor:"default"})})
		.click(function(e){
			$.ajax({
				type:"Post",
				url:"/Project/login",
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
					// => 성공시 : 성공message, 새로고침
					//    실패시 : 실패message, 재로그인 유도;
					if (resultData.loginSuccess=='T') {
						location.href="home";
						alert("~~ Login 성공 ~~");
					}else {
						console.log(header);
						console.log(token);
						$('#message').html(resultData.message);
						$('#modal_form #member_id').focus();
					}
				},
				error: function() {
					$('#message').html("~~ Ajax_jslogin Test Error ~~");
				}
			}); //ajax
			return false;
		}); //jslogin_click 
		
/* 	$('.modalClose').click(function(e){
		$('.modal,.modal_content').hide();
		e.stopPropagation();
	}); */
	
		
$(function(){		

}); //ready
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
		<td><input type="password" name="password" id="password" value="1"></td></tr>
	<tr><td></td>
		<td><button id="login">Login</button>&nbsp; 
			<input type="reset" value="Reset">&nbsp;
			
		</td>
	</tr> 
</table>
</form>
<!-- <div class="modalClose">X</div> -->
<span id="message"></span><br>
<a href="joinf?R=joinf">[회원가입]</a>
<a href="**findid**">[아이디 찾기]</a>
<a href="**findpw**">[비밀번호 찾기]</a>
</div>
</body>
</html> 