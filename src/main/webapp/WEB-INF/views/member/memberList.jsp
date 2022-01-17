<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>징검다리 : 회원검색</title>
</head>
<body>
<h3>** 멤버리스트 **</h3>
<br>
<c:if test="${not empty message}">
=> ${message}<br>
</c:if>
<div id="searchBar">
	<form action="mchecklist" method="get">
		<b>Level : </b>
		<input type="checkbox" name="check" value="플레인">플레인&nbsp;
		<input type="checkbox" name="check" value="브론즈">브론즈&nbsp;
		<input type="checkbox" name="check" value="실버">실버&nbsp;
		<input type="checkbox" name="check" value="골드">골드&nbsp;&nbsp;
<!-- 		<input type="submit" value="검색">&nbsp; -->
		<button id="mchecklist">검색</button>&nbsp;
		<input type="reset" value="취소">
	</form>
</div><br>
<hr>
<table width=100%>
<tr height="30" bgcolor="pink">
	<th>I D</th><th>Password</th><th>Name</th><th>Gender</th>
	<th>Birthday</th><th>Email</th><th>Phone</th><th>Interest</th><th>Last Access</th>
</tr>	
<c:forEach var="list" items="${banana}">
<tr  height="30" align="center">
	<td> <!-- 관리자 기능 추가하기 -->
	<c:if test="${loginID=='1'}">
		<a href="mdetail?member_id=${list.member_id}">${list.member_id}</a>
	</c:if>
	<c:if test="${loginID!='1'}">
		${list.member_id} 
	</c:if>
	</td>
	<td>${list.password}</td><td>${list.name}</td><td>${list.gender}</td>
	<td>${list.birthday}</td><td>${list.email}</td>
	<td>${list.phone}</td><td>${list.interest}</td>
	<td>${list.last_access}</td>
</tr>
</c:forEach>
</table>
<hr>

<a href="home" >[Home]</a>

</body>
</html>