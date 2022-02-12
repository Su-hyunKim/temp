<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팔로잉 리스트</title>
<link rel="stylesheet" type="text/css" href="resources/lib/main.css">
</head>
<body>
<h1>팔로잉</h1>
<br>
<table width=100%>
<tr height="30" bgcolor="RosyBrown">
	<th>ID</th>
</tr>
<%-- <c:if test="${not empty loginID}">--%>
<c:forEach var="followinglist" items="${apple}">
<tr height="30" align="center">
	<td>${followinglist}</td>
</tr>
</c:forEach>
<%-- </c:if> --%>
</table>
<hr>
	<%-- 홈화면 내아이디 팔로워 팔로잉 버튼에 링크걸기 
	<td>I D</td><td>${apple.member_id}</td>
		${myfollower}, ${myfollowing}
	<c:if test="${not empty loginID}">
		<a href="followerlist?follow_seq=${list.follow_seq}">${followerlist}</a>
	</c:if> --%>
<a href='javascript:history.go(-1)'>이전으로</a>&nbsp;&nbsp;
<a href="home" >[Home]</a>
</body>
</html>