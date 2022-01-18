<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
	<script src="resources/lib/jquery-3.2.1.min.js"></script>
 	<script>
//$(function(){
 // ** JSON Login : jsonView Test	
	$('#login').hover(function(){$(this).css({cursor:"pointer"})},
			function(){$(this).css({curcor:"default"})})
		.click(function(e){
			$.ajax({
				type:"Post",
				url:"login",
				data: {
					member_id: $('#modal_form #member_id').val(),
					password: $('#modal_form #password').val()
				},
				success:function(resultData) {
					// => 서버로부터 Json 형태의 Data 를 Response 로 받음
					//    "loginSuccess" -> "T" 성공 , 새로고침
					//    "loginSuccess" -> "F" 실패
					// => 성공시 : 성공message, 새로고침
					//    실패시 : 실패message, 재로그인 유도;
					if (resultData.loginSuccess=='T') {
						location.reload();
						alert("~~ Login 성공 ~~");
					}else {
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
		
	$('.modalClose').click(function(e){
		$('.modal,.modal_content').hide();
		e.stopPropagation();
	});
		
//}); //ready
 	</script>
</head>
<body>
<form action="login" method="post" id="modal_form">
<table>
	<tr><td bgcolor="gray">I D</td>
		<td><input type="text" name="member_id" id="member_id" value="1"></td></tr>
	<tr><td bgcolor="gray">Password</td>
		<td><input type="password" name="password" id="password" value="3"></td></tr>
	<tr><td></td>
		<td><button id="login">Login</button>&nbsp; 
			<input type="reset" value="Reset">&nbsp;
			
		</td>
	</tr> 
</table>
</form>
<div class="modalClose">X</div>
<span id="message"></span><br>
<hr>
<a href="**join**">[회원가입]</a>
<a href="**findid**">[아이디 찾기]</a>
<a href="**findpw**">[비밀번호 찾기]</a>


</body>
</html> 