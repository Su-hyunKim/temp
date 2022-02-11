<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0,
	user-scalable=no, maximum-scale=1.0,minimum-scale=1.0">
<title>징검다리 : Email 인증</title>
<link rel="stylesheet" type="text/css" href="resources/lib/main.css">
<script>
	let second = 300;
	
	function clock(){
		second -= 1;
		if(second<0) document.getElementById('submit').click();
		else{
			var ss = second%60;
			var mm = Math.trunc(second/60);
			if(ss<10) ss="0"+ss;
			document.getElementById("clock").innerHTML = "남은시간 "+mm+":"+ss;
			setTimeout("clock()",1000);
		}
	}
</script>
</head>
<body onload="clock()">
<div class="wrapped">
	<h1>Email 인증</h1>
	<p>남은시간 이내에 인증을 완료해 주십시오</p>
	<p id="clock">종료</p>
	<form action="emailauth" method="post">
		<input type="hidden" name="member_id" value="${member_id}">
		<input type="hidden" name="key" value="${key}">
		<c:if test="${not empty R}"><input type="hidden" name="R" value="${R}"></c:if>
		<input type="text" name="auth_no" placeholder="인증키 입력">
		<input type="submit" value="인증" id="submit">
		<input type="reset" value="초기화">
		<s:csrfInput />
	</form>
</div>
</body>
</html>