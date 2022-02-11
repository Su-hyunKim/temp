<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>    
<html>
<head>
<meta charset="UTF-8">
<title>징검다리 : 임시 비밀번호 발급</title>
</head>
<body>
<div class="wrapped">
<h1>임시 비밀번호 발급</h1>
아래 버튼을 누르면<br>
${apple.email} 로<br>
임시 비밀번호가 전송됩니다.
<form action="${pageContext.request.contextPath}/sendpw" method='post'>
	<input type="hidden" name="member_id" value="${apple.member_id}">
	<input type="hidden" name="email" value="${apple.email}">
	<button>임시 비밀번호 발급</button>
	<s:csrfInput />
</form>
</div>
</body>
</html>
