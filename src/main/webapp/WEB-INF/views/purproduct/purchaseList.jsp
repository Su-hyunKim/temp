<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
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
<div id="container">
<h3>주문내역</h3>
<br>
<c:if test="${not empty message}">
=> ${message}<br>
</c:if>
<hr>
<table width=100%>
<tr height="30" bgcolor="GreenYellow">
	<th>#주문I D</th><th>#구매상품명</th><th>#구매량</th><th>#상품가격</th><th>#할인률</th><th>#초코 적립</th> 
</tr>	
<c:forEach var="list" items="${banana}">
<tr  height="30" align="center">
	<td>${list.purchase_id}</td>
	<td>${list.name}</td>

	<td>${list.product_count}</td><td>${list.price}</td><td>${list.product_dc}</td><td>${list.savePoint}</td>
</tr>
</c:forEach>
</table>
<hr>
<!-- <a href='javascript:history.go(-1)'>이전으로</a>&nbsp;&nbsp; -->
<a href="home" >[Home]</a>

</div>
<div class="modal"></div><div class="modal_content"></div>
<div class="footer">
</div>
</body>
</html>

