<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0,
	user-scalable=no, maximum-scale=1.0,minimum-scale=1.0">
	<title>징검다리 : ${title} 리스트</title>
	<style>
		table {
			width:100%;
			border-collapse: collapse;
			text-align: center;
			line-height: 1.5;
		
		}
		table thead th {
			padding: 5px;
			font-weight: bold;
			vertical-align: top;
			color: #369;
			border-bottom: 3px solid #036;
		}
		table tbody th {
			padding: 5px;
			font-weight: bold;
			vertical-align: top;
			border-bottom: 1px solid #ccc;
		}
		table td {
			padding: 5px;
			vertical-align: top;
			border-bottom: 1px solid #ccc;
		}
		table a {
			color:gray;
			text-decoration:none;
		}
		table a:hover {
			color:black;
		}
		a:hover,
		label:hover,
		input:hover, 
		button:hover,
		select:hover {
			cursor:pointer;
		}
	</style>
</head>
<body>
<div class="wrapped">
	<h1>${title} 리스트</h1>
<c:if test="${not empty message}">
=> ${message}<br>
</c:if>
<br>
		<table>
			<thead>
				<tr>
					<th>I D</th><th>이름</th><th>성별</th><th>생년</th>
					<th>주소지</th><th>point</th><th>Last Access</th>
				</tr>
			</thead>
			<tbody>	
<c:forEach var="list" items="${banana}">
				<tr>
					<th> <!-- 관리자 기능 추가하기 -->
	<c:if test="${loginID=='admin'}">
		<a href="mdetail?member_id=${list.member_id}">${list.member_id}</a></c:if>
	<c:if test="${loginID!='admin'}">
		${list.member_id}</c:if>
					</th>
					<td>${list.name}</td>
					<td>
						<c:if test="${list.gender=='F'}">여</c:if>
						<c:if test="${list.gender=='M'}">남</c:if>
						<c:if test="${list.gender=='N'}">N</c:if>
					</td>
					<td>${list.birthday}</td>
					<td>${list.address2}</td>
					<td>${list.point}</td>
					<td>${list.last_access}</td>
				</tr>
</c:forEach>
			</tbody>
		</table>
<c:if test="${not empty loginID}">
<a href="mypage?R=mypage">[mypage]</a>&nbsp;
</c:if>	
<a href="home">[HOME]</a>				
</div>
</body>
</html>

