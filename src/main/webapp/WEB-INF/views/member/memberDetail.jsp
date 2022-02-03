<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0,
	user-scalable=no, maximum-scale=1.0,minimum-scale=1.0">
<title>회원상세정보</title>
<style>
	hr {
		width:100%;
	}
	table {
		border-collapse:collapse;
		text-align:left;
		line-height:1.5;
		border-top:1px solid #ccc;
		border-bottom:1px solid #ccc;
		margin:20px auto;
	}
	th {
		width:150px;
		padding:10px;
		font-weight:bold;
		vertical-align:top;
	}
	td {
		width:350px;
		padding:10px;
		vertical-align:top;
	}
	tr:nth-child(2n) {
		background:#efefef;
	}
	a {
		width:100px;
		text-decoration-line:none;
		font-weight:bold;
		margin:5px 0;
		border:0;
	}
	.center {
		text-align:center;
	}
</style>
</head>
<body>
<div class="center">
<h1>회원상세정보</h1>
<table>
	<tr>
		<th>I  D</th><td>${apple.member_id}</td>
	</tr>
	<tr>
		<th>이름</th><td>${apple.name}</td>
	</tr>
	<tr>
		<th>성별</th>
		<td>
			<c:if test="${apple.gender=='M'}">
				남성
			</c:if>
			<c:if test="${apple.gender=='F'}">
				여성
			</c:if>
			<c:if test="${apple.gender=='N'}">
				기타
			</c:if>
		</td>
	</tr>
	<tr>
		<th>생년월일</th>
		<td>${apple.birthday}</td>
	</tr>
	<tr>
		<th>관심사</th><td>${apple.interest}</td>
	</tr>
	<tr>
		<th>포인트</th><td>${apple.point}</td>
	</tr>
	<tr>
		<th>주소</th>
		<td>&#12306;&nbsp;${apple.address1}<br>
			${apple.address2}${apple.address3}
		</td>
	</tr>
	<tr>
		<th>전화번호</th><td>${apple.phone}</td>
	</tr>
	<tr>
		<th>이메일</th><td>${apple.email}</td>
	</tr>
	<tr>
		<th>SNS</th><td>${apple.sns}</td>
	</tr>
	<tr>
		<th>마지막 접속</th><td>${apple.last_access}</td>
	</tr>
	<tr>
		<th>Authorities</th>
		<td><c:forEach var="auth" items="${apple.authList}">${auth.authority}&nbsp;</c:forEach></td>
	</tr>
	<tr>
		<th>Status</th>
		<td>${apple.status}</td>
	</tr>
	<tr>
		<th>활성계정여부</th>
		<td>${apple.enabled}</td>
	</tr>
	<tr>
		<th>Image</th>
		<td><img src="${apple.profile}" width="100" height="120"></td>
	</tr>
</table>
<c:if test="${not empty message}">
=> ${message}<br>
<hr>
</c:if>
<a href="mupdatef?member_id=${apple.member_id}">정보수정</a>&nbsp;
<!-- 1) 내정보수정 -> 내정보읽기서블릿 (mdetail) 
 			  -> 내정보수정화면 (updateForm.jsp) : 수정후, submit 
 			  -> 서블릿(컨트롤러) 
 	 2) 관리자기능 추가 -> loghinID 는 관리자이지만, 수정대상은 현재 출력된 id
 	 				 -> 수정, 탈퇴 uri 에 &id=${apple.member_id} 추가 		  
 			  -->
<a href="mdelete?member_id=${apple.member_id}">회원탈퇴</a>&nbsp;
<a href='javascript:history.go(-1)'>이전으로</a>&nbsp;&nbsp;<a href="home">HOME</a>
</div>
</body>
</html>