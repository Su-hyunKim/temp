<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0,
	user-scalable=no, maximum-scale=1.0,minimum-scale=1.0">
<title>주문상세</title>
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
<h1>주문내역</h1>
<table>
	<tr>
		<th>주문I D</th><td>${apple.purchase_id}</td>
	</tr>
	<tr>
		<th>받는분</th><td>${apple.addressee}</td>
	</tr>
	<tr>
		<th>구매자I D</th><td>${apple.member_id}</td>
	</tr>
	<tr>
		<th>주소</th>
		<td>&#12306;&nbsp;${apple.address1}<br>
			${apple.address2}${apple.address3}
		</td>
	</tr>
	<tr>
		<th>주문상태</th><td>${apple.purchase_status}</td>
	</tr>
	<tr>
		<th>배달비</th><td>${apple.delivery_cost}</td>
	</tr>
	<tr>
		<th>사용한 포인트</th><td>${apple.usePoint}</td>
	</tr>
	<tr>
		<th>주문일</th><td>${apple.purchaseDate}</td>
	</tr>
	
</table>
<c:if test="${not empty message}">
=> ${message}<br>
<hr>
</c:if>
<a href="purdelete?purchase_id=${apple.purchase_id}">주문취소</a>&nbsp;
<a href='javascript:history.go(-1)'>이전으로</a>&nbsp;&nbsp;<a href="home">HOME</a>
</div>
</body>
</html>