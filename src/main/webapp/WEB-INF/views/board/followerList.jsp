<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팔로워목록</title>
<link rel="stylesheet" type="text/css" href="resources/lib/main.css">
</head>
<body>
<h1>팔로워</h1>
<br>
<c:if test="${not empty message}">
=> ${message}<br>
</c:if>
<hr>
<table width=100%>
<tr height="30" bgcolor="RosyBrown">
	<th>ID</th>
</tr>	
<c:if test="${not empty loginID}">
	<tr  height="30" align="center">
	<c:forEach var="followerlist" items="${apple}"></c:forEach>
	</tr>
</c:if>
	
</table>
<hr>
<div align="center">
	<!-- Paging 1 
	=> 현재Page (currPage) : 강조 / 아니면 : Link 적용 
	<c:forEach var="i" begin="1" end="${totalPageNo}">
		<c:if test="${i==currPage}">
			<font size="5" color="Orange">${i}</font>&nbsp;
		</c:if>
		<c:if test="${i!=currPage}">
			<a href="bpagelist?currPage=${i}">${i}</a>&nbsp;
		</c:if>
	</c:forEach> 
	-->
	<!-- Paging 2 : PageBlock 적용 
		=> 기호 사용  < &lt;   > &gt; 
	-->
	<c:choose>
		<c:when test="${sPageNo>pageNoCount}">
			<a href="rpagelist?currPage=1">첫페이지</a>&nbsp;
			<a href="rpagelist?currPage=${sPageNo-1}">&lt;</a>&nbsp;&nbsp;
		</c:when>
		<c:otherwise>
			<font color="gray">FF&nbsp;&lt;</font>&nbsp;&nbsp;
		</c:otherwise>
	</c:choose>
	
	<c:forEach var="i" begin="${sPageNo}" end="${ePageNo}">
		<c:if test="${i==currPage}">
			<font size="5" color="Orange">${i}</font>&nbsp;
		</c:if>
		<c:if test="${i!=currPage}">
			<a href="bpagelist?currPage=${i}">${i}</a>&nbsp;
		</c:if>
	</c:forEach>
	&nbsp;
	<c:choose>
		<c:when test="${ePageNo<totalPageNo}">
			<a href="rpagelist?currPage=${ePageNo+1}">&gt;</a>&nbsp;
			<a href="rpagelist?currPage=${totalPageNo}">끝페이지</a>
		</c:when>
		<c:otherwise>
			<font color="gray">&gt;&nbsp;끝페이지</font>
		</c:otherwise>
	</c:choose>
	
</div>
<hr>


<a href='javascript:history.go(-1)'>이전으로</a>&nbsp;&nbsp;
<a href="home" >[Home]</a>
</body>
</html>