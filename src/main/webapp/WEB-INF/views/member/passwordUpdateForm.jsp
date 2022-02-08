<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>    
<html>
<head>
<meta charset="UTF-8">
<title>새 비밀번호 설정</title>
</head>
<body>
<div class="wrapped">
<h1>새로운 비밀번호 설정</h1>
<form action="pwupdate" method='post'>
	<input type="hidden" name="member_id" value="${member_id}">
	<table>
		<tr><td bgcolor="gray">Password</td>
			<td><input type="password" name="password" placeholder="새로운 비밀번호를 입력해주세요" id="password"><br>
				<span id="iMessage" class="eMessage"></span>
			</td>
		</tr>
		<tr><td colspan="2">
				<input type="submit">비밀번호 변경&nbsp; 
				<input type="reset" value="Reset">			
			</td>
		</tr> 
	</table>
	<s:csrfInput />
</form>
</div>
</body>
</html>
