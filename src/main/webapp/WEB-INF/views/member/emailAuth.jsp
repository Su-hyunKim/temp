<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Email 인증페이지</title>
<script> 

</script>
</head>
<body>
<div class="wrapped">
	<h1>Email 인증페이지</h1>
	인증번호 입력
	<form action="emailauth" method="post">
		<input type="hidden" name="member_id" value="${member_id}">
		<input type="text" name="auth_no">
		<input type="submit" value="인증">
		<input type="reset" value="초기화">
	</form>
</div>

</body>
</html>