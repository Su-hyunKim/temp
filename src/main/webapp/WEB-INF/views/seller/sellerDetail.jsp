<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0,
	user-scalable=no, maximum-scale=1.0,minimum-scale=1.0">
<title>징검다리 : 판매자상세정보</title>
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
	<h1>판매자상세정보</h1>
<c:if test="${not empty message}">
=> ${message}<br>
</c:if>
	<table>
		<tr>
			<th>I  D</th>
			<td>${apple.member_id}</td>
		</tr>
		<tr>
			<th>업체명</th>
			<td>${apple.company_name}</td>
		</tr>
		<tr>
			<th>대표자</th>
			<td>${apple.representative}</td>
		</tr>
		<tr>
			<th>업태</th>
			<td>${apple.business_type}</td>
		</tr>
		<tr>
			<th>종목</th>
			<td>${apple.business_items}</td>
		</tr>
		<tr>
			<th>사업개시일</th>
			<td>${apple.launch_date}</td>
		</tr>
		<tr>
			<th>사업자등록번호</th>
			<td>${apple.employer_id}</td>
		</tr>
		<tr>
			<th>법인등록번호</th>
			<td>${apple.corporation_id}</td>
		</tr>
		<tr>
			<th>사업장 주소</th>
			<td>&#12306;&nbsp;${apple.location1}<br>
				${apple.location2}${apple.location3}
			</td>
		</tr>
		<tr>
			<th>업무용 전화번호</th>
			<td>${apple.business_phone}</td>
		</tr>
		<tr>
			<th>업무용 이메일</th>
			<td>${apple.business_email}</td>
		</tr>
		<tr>
			<th>관할세무소</th>
			<td>${apple.tax_office}</td>
		</tr>
		<tr>
			<th>Products</th>
			<td>
			<c:forEach var="product" items="${apple.productList}">
				<a href="pdetail?product_id='${product.product_id}'">${product.name}</a>&nbsp;|&nbsp;
			</c:forEach>
			</td>
		</tr>
		<tr>
			<th>Logo</th>
			<td><img src="${apple.logo}" width="100" height="120"></td>
		</tr>
	</table>
<c:if test="${loginID==apple.member_id or loginID=='admin'}">
	<a href="supdatef?member_id=${apple.member_id}">판매자정보수정</a>&nbsp;
	<a href="mdetail?member_id=${apple.member_id}">회원상세정보</a>&nbsp;
	<a href='javascript:if(confirm("정말로 판매자계정을 취소하시겠습니까?")) location.href="swithdraw?member_id=${apple.member_id}";'>판매자계정취소</a><br>
</c:if>
	<a href='javascript:history.go(-1)'>이전으로</a>&nbsp;&nbsp;<a href="home">HOME</a>
</div>
</body>
</html>