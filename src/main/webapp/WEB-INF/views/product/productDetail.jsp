<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>필요한 이를 이어주는 징검다리</title>
	<link rel="stylesheet" type="text/css" href="resources/lib/main.css">
	<script src="resources/lib/jquery-3.2.1.min.js"></script> 
	<script src="resources/lib/menu.js"></script>
	
</head>
<body>
<c:if test="${not empty loginID}">
<input type="hidden" id="loginID" value="${loginID}">
</c:if>
<h3>** 상품세부 **</h3>
<table>
	<tr height="40">
		<td bgcolor="Lavender"></td><td>${apple.product_id}</td>
	</tr>
	<tr height="40">
		<td bgcolor="Lavender"></td><td>${apple.product_url}</td>
	</tr>
	<tr height="40">
		<td bgcolor="Lavender"></td><td>${apple.product_url2}</td>
	</tr>
	<tr height="40">
		<td bgcolor="Lavender"></td><td>${apple.product_detprod_num}</td>
	</tr>
	<tr height="40">
		<td bgcolor="Lavender"></td><td>${apple.product_idtprod_num}</td>
	</tr>
	<tr height="40">
		<td bgcolor="Lavender"></td><td>${apple.category}</td>
	</tr>
	<tr height="40">
		<td bgcolor="Lavender"></td><td>${apple.name}</td>
	</tr>
	<tr height="40">
		<td bgcolor="Lavender"></td><td>${apple.unit}</td>
	</tr>
	<tr height="40">
		<td bgcolor="Lavender"></td><td>${apple.price}</td>
	</tr>
	<tr height="40">
		<td bgcolor="Lavender"></td><td>${apple.currency}</td>
	</tr>
	<tr height="40">
		<td bgcolor="Lavender"></td><td>${apple.regdate}</td>
	</tr>
	<tr height="40">
		<td bgcolor="Lavender"></td><td>${apple.member_id}</td>
	</tr>
	<tr height="40">
		<td bgcolor="Lavender"></td><td>${apple.status}</td>
	</tr>
	<tr height="40">
		<td bgcolor="Lavender"></td><td>${apple.remarks}</td>
	</tr>
	<tr height="40">
		<td bgcolor="Lavender"></td><td>${apple.cnt}</td>
	</tr>
	<tr height="40">
		<td bgcolor="Lavender"></td><td>${apple.check}</td>
	</tr>
	
</table>
<c:if test="${not empty message}">
<hr>
=> ${message}<br>
</c:if>
<!-- 1) 글수정, 글삭제
		-> 내가 쓴글인 경우, 관리자 인경우 에만 가능 
		-> loginID 와 apple.id 가 동일한 경우
 -->
 <hr>
<c:if test="${loginID==apple.id  || loginID=='admin'}">
	<%-- <a href="pdetail?jcode=U&product_id=${apple.procuct_id}">글수정</a>&nbsp;&nbsp;
	<a href="pdelete?root=${apple.root}&product_id=${apple.product_id}">글삭제</a> --%>
		<!-- 삭제시 원글삭제 or 답글삭제 확인을 위함 -->
</c:if> 
<!-- 새글, 답글등록 추가하기 -->
&nbsp;&nbsp;<a href="pregistf">상품등록</a>
<%-- &nbsp;&nbsp;<a href="rinsertf?root=${apple.root}&step=${apple.step}&indent=${apple.indent}">답글등록</ --%>a><br>
<hr>
<!-- <a href='javascript:history.go(-1)'>이전으로</a>&nbsp;&nbsp; -->
<a href="home">[Home]</a>
</body>
</html>