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
<link rel="stylesheet" type="text/css" href="resources/lib/main.css">
<style>
	hr{width:100%;}
	table{background:black;}
	td:nth-child(2n+1){background:lavender;}
	td:nth-child(2n){background:lavender;}
	a{width:100px;text-align:center;margin:5px 0;border:0;}
</style>
</head>
<body>
<div class="wrapped">
<h1>회원상세정보</h1>
<table>
	<tr height="40">
		<td>I  D</td><td>${apple.member_id}</td>
	</tr>
	<tr height="40">
		<td>이름</td><td>${apple.name}</td>
	</tr>
	<tr height="40">
		<td>성별</td><td>${apple.gender}</td>
	</tr>
	<tr height="40">
		<td>생년월일</td><td>${apple.birthday}</td>
	</tr>
	<tr height="40">
		<td>관심사</td><td>${apple.interest}</td>
	</tr>
	<tr height="40">
		<td>포인트</td><td>${apple.point}</td>
	</tr>
	<tr height="40">
		<td>주소</td>
		<td>${apple.address1}<br>
			${apple.address2}${apple.address3}
		</td>
	</tr>
	<tr height="40">
		<td>전화번호</td><td>${apple.phone}</td>
	</tr>
	<tr height="40">
		<td>이메일</td><td>${apple.email}</td>
	</tr>
	<tr height="40">
		<td>SNS</td><td>${apple.sns}</td>
	</tr>
	<tr height="40">
		<td>마지막 접속</td><td>${apple.last_access}</td>
	</tr>
	<tr height="40">
		<td>Image</td>
		<td><img src="${apple.profile}" width="100" height="120"></td>
	</tr>
</table>
<c:if test="${not empty message}">
=> ${message}<br>
<hr>
</c:if>
<a href="mdetail?jcode=U&member_id=${apple.member_id}">정보수정</a>
<!-- 1) 내정보수정 -> 내정보읽기서블릿 (mdetail) 
 			  -> 내정보수정화면 (updateForm.jsp) : 수정후, submit 
 			  -> 서블릿(컨트롤러) 
 	 2) 관리자기능 추가 -> loghinID 는 관리자이지만, 수정대상은 현재 출력된 id
 	 				 -> 수정, 탈퇴 uri 에 &id=${apple.member_id} 추가 		  
 			  -->
<a href="mdelete?member_id=${apple.member_id}">회원탈퇴</a><br>
<a href='javascript:history.go(-1)'>이전으로</a><a href="home">HOME</a>
</div>
</body>
</html>