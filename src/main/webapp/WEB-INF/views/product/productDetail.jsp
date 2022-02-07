<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0,
	user-scalable=no, maximum-scale=1.0,minimum-scale=1.0">
<title>상품상세정보</title>
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
<h1>상품상세정보</h1>
<table>
	<tr>
		<th>상품ID</th><td>${apple.product_id}</td>
	</tr>
	<tr>
		<th>상품사진</th>
		<td><img src="${apple.product_imgfile}" width="500" height="600"></td>
	</tr>
	<tr>
		<th>상품상세번호</th><td>${apple.detprod_num}</td>
	</tr>
	<tr>
		<th>상품식별번호</th><td>${apple.idtprod_num}</td>
	</tr>
	<tr>
		<th>카테고리</th>
		<td>
			<c:if test="${apple.category=='C'}">
				의류
			</c:if>
			<c:if test="${apple.category=='E'}">
				식품
			</c:if>
			<c:if test="${apple.category=='N'}">
				생활용품
			</c:if>
			<c:if test="${apple.category=='B'}">
				도서
			</c:if>
			<c:if test="${apple.category=='F'}">
				가구
			</c:if>
		</td>
	</tr>
	<tr>
		<th>상품명</th><td>${apple.name}</td>
	</tr>
	<tr>
		<th>상품가격</th>
		<td>${apple.currency}${apple.price}</td>
	</tr>
	<tr>
		<th>상품수량</th><td>${apple.quantity}</td>
	</tr>
	<tr>
		<th>상품제조일</th><td>${apple.regdate}</td>
	</tr>
	<tr>
		<th>판매자</th><td>${apple.member_id}</td>
	</tr>
	<tr>
		<th>상품상태</th><td>${apple.status}</td>
	</tr>
	<tr>
		<th>상품설명</th><td>${apple.product_desc}</td>
	</tr>
	
</table>
<c:if test="${not empty message}">
=> ${message}<br>
<hr>
</c:if>
<a href="pupdatef?product_id=${apple.product_id}">정보수정</a>&nbsp;
<!-- 1) 내정보수정 -> 내정보읽기서블릿 (mdetail) 
 			  -> 내정보수정화면 (updateForm.jsp) : 수정후, submit 
 			  -> 서블릿(컨트롤러) 
 	 2) 관리자기능 추가 -> loghinID 는 관리자이지만, 수정대상은 현재 출력된 id
 	 				 -> 수정, 탈퇴 uri 에 &id=${apple.member_id} 추가 		  
 			  -->
<a href="pdelete?product_id=${apple.product_id}">상품삭제</a>&nbsp;
<a href='javascript:history.go(-1)'>이전으로</a>&nbsp;&nbsp;<a href="home">HOME</a>
</div>
</body>
</html>