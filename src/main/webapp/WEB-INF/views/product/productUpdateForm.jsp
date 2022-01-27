<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="resources/lib/pinCheck.js"></script>
<title>** 징검다리 : 상품수정 **</title>
</head>
<body>
<h3>** 징검다리 : 상품수정 **</h3>
<form action="pupdate" method="post">
<table>
	<tr height="40"><td bgcolor="HoneyDew ">상품 ID</td>
		<td><input type="text" name="product_id" value="${apple.product_id}" size="20" readonly></td></tr>
	<tr height="40"><td bgcolor="HoneyDew ">상품 사진</td>
		<td><input type="file" name="product_imgfile" value="${apple.product_imgfile}" width="300px" height="200px"></td></tr>
	<tr height="40"><td bgcolor="HoneyDew ">상품상세번호</td>
		<td><input type="text" name="detprod_num" value="${apple.detprod_num}"  size="20"></td></tr>
	<tr height="40"><td bgcolor="HoneyDew ">상품식별번호</td>
		<td><input type="text" name="idtprod_num" value="${apple.idtprod_num}" size="20"></td></tr>	
	<tr height="40"><td bgcolor="HoneyDew ">카테고리</td>
		<td><input type="text" name="category" value="${apple.category}"></td></tr>	
	<tr height="40"><td bgcolor="HoneyDew ">상품명</td>
		<td><input type="text" name="name" value="${apple.name}"></td></tr>	
	<tr height="40"><td bgcolor="HoneyDew ">통화</td>
		<td><input type="text" name="unit" value="${apple.currency}"></td></tr>
	<tr height="40"><td bgcolor="HoneyDew ">상품가격</td>
		<td><input type="text" name="price" value="${apple.price}"></td></tr>
	<tr height="40"><td bgcolor="HoneyDew ">수량</td>
		<td><input type="text" name="quantity" value="${apple.quantity}"></td></tr>
	<tr height="40"><td bgcolor="HoneyDew ">상품제조일</td>
		<td>${apple.regdate}</td></tr>
	<tr height="40"><td bgcolor="HoneyDew ">판매자</td>
		<td><input type="text" name="member_id" value="${apple.member_id}"></td></tr>
	<tr height="40"><td bgcolor="HoneyDew ">상품상태</td>
		<td><input type="text" name="status" value="${apple.status}"></td></tr>
	<tr height="40"><td bgcolor="HoneyDew ">상품설명</td>
		<td><textarea name="productdesc" rows="5" cols="50">${apple.product_desc}</textarea>
		</td></tr>					
	<tr height="40"><td></td>
		<td><input type="submit" value="수정">&nbsp;&nbsp;
			<input type="reset" value="취소">
		</td></tr>			
</table>
</form>
<c:if test="${not empty message}">
<br>=> ${message}<br><br> 
</c:if>
<hr>
<a href="plist">pList</a>&nbsp;&nbsp;
<a href="home" >[Home]</a>
</body>
</html>