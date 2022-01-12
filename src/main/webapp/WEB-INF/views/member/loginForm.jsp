<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
	<link rel="stylesheet" type="text/css" href="resources/lib/main.css">
	<script src="resources/lib/jquery-3.2.1.min.js"></script>
	<script src="resources/lib/axTest01.js"></script>
</head>
<body>
<form action="login" method="post">
<table>
	<tr><td bgcolor="PaleTurquoise">I D</td>
		<td><input type="text" name="id" id="id" value="banana"></td></tr>
	<tr><td bgcolor="PaleTurquoise ">Password</td>
		<td><input type="password" name="password" id="password" value="12345"></td></tr>
	<tr><td></td>
		<td><input type="submit" value="Login">&nbsp; 
			<input type="reset" value="Reset">&nbsp;

		</td>
	</tr> 
</table>
</form>
</body>
<span id="message"></span><br>
<c:if test="${not empty message}">
	<a href="home.jsp"></a>
</c:if>
<hr>
<a href="**join**">[회원가입]</a>
<a href="**findid**">[아이디 찾기]</a>
<a href="**findpw**">[비밀번호 찾기]</a>



</html> 