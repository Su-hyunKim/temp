<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>    
<html>
<head>
<meta charset="UTF-8">
<title>징검다리 : 새 비밀번호 설정</title>
<script src="resources/lib/inCheck.js"></script>
<script>
fChecks = [new FocusoutCheck(false,'password',pwCheck,'pMessage','비밀번호를')];
function pwCheck() {
	let password=$('#password').val()
	if (password.length<8) {
		$('#pMessage').html('8자 이상');
		return false;
	}else if ( password.replace(/[!-*.@]/gi,'').length >= password.length ) {
		$('#pMessage').html('특수문자가 반드시 1개 이상');
		return false;
	}else if ( password.replace(/[a-z.0-9.!-*.@]/gi ,'').length > 0 ) {
		$('#pMessage').html('영문자, 숫자, 특수문자로만');
		return false;
	}else {
		$('#pMessage').html('');
		return true;
	}
} //password
$(function(){		
	$('#pwForm input[type="reset"]').click(function(){
		$('#pwForm .eMessage').html('');
		$('#pwForm input').css({border:original});
	});
}); //ready
</script>
</head>
<body>
<div class="wrapped">
<h1>새로운 비밀번호 설정</h1>
<form action="pwupdate" method='post' id="pwForm">
	<input type="hidden" name="member_id" value="${member_id}">
	<table>
		<tr><td bgcolor="gray">Password</td>
			<td><input type="password" name="password" placeholder="새로운 비밀번호를 입력해주세요" id="password"><br>
				<span id="pMessage" class="eMessage"></span>
			</td>
		</tr>
		<tr><td colspan="2">
				<input type="submit" value="비밀번호 변경">&nbsp; 
				<input type="reset"  value="입력 초기화">			
			</td>
		</tr> 
	</table>
	<s:csrfInput />
</form>
</div>
</body>
</html>
