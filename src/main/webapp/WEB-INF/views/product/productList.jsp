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
<h3>** 상품리스트 **</h3>
<br>
<c:if test="${not empty message}">
=> ${message}<br>
</c:if>
<hr>
<table width=100%>
<tr height="30" bgcolor="GreenYellow">
	<th>#I D</th><th>#Name</th><th>#Img</th><th>#Price</th><th>#Regdate</th> 
</tr>	
<c:forEach var="list" items="${banana}">
<tr  height="30" align="center">
	<td>${list.product_id}</td>
	<td align="left">
	 <!-- 답글 등록후 indent 에 따른 들여쓰기 
			=> 답글인 경우에만 적용  -->
	<%-- <c:if test="${list.indent>0}">
		<c:forEach begin="1" end="${list.indent}">
			<span>&nbsp;&nbsp;</span>
		</c:forEach>
		<span style="color:purple">re..</span>
	</c:if> --%>
	
	 <!-- 글내용보기 기능 추가하기 -> login한 경우에만 허용 -->
	<c:if test="${not empty loginID}">
		<a href="pdetail?product_id=${list.product_id}">${list.name}</a>
	</c:if>
	<c:if test="${empty loginID}">
		${list.name} 
	</c:if>
	</td>
	
	<td align="left">${list.product_imgfile}</td><td>${list.price}</td><td>${list.regdate}</td>
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

