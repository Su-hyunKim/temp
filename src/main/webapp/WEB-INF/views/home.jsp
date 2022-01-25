<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0,
	user-scalable=no, maximum-scale=1.0,minimum-scale=1.0">
	<title>필요한 이를 이어주는 징검다리</title>
	<link rel="stylesheet" type="text/css" href="resources/lib/main.css">
	<script src="resources/lib/jquery-3.2.1.min.js"></script> 
	<script src="resources/lib/menu.js"></script>
</head>
<body>
<a id="home" href="home"><img src="resources/image/home.png" width="30" height="30"></a>
<div>
	<img  id="loginBt" src="resources/image/login.png" width="35" height="35">
	<img  id="logoutBt" src="resources/image/logout.png" width="35" height="35">
</div>
<div class="menu">
	<ul>
		<div id="d1">
			<li class="title">게시판
			<ul>
				<li><span>전체글조회</span>
				<li><span>홍보글조회</span>
				<li id="comment"><span>댓글작성</span>
				<li><span>리뷰글조회</span>
			</ul>
		</div>
		<div id="d2">
			<li class="title">상 품
			<ul>
				<li><span>상품등록</span>
				<li><span>상품검색</span>
				<li><span>상품리뷰조회</span>
			</ul>
		</div>
		<div id="d3">
			<li class="title">회 원
			<ul>
				<li id="mypage"><span>마이페이지</span>
				<li id="joinf"><span>회원가입</span>
				<li><span>내정보수정</span>
				<li><span>회원탈퇴</span>
				<li id="mlist"><span>회원검색</span>
			</ul>
		</div>
	</ul>
</div>
<c:if test="${not empty loginID}">
<input type="hidden" id="loginID" value="${loginID}">
</c:if>
<c:if test="${not empty R}">
<input type="hidden" id="R" value="${R}">
</c:if>
<div class="banner">
<img src="resources/image/steppingStone.jpg" width="100%" height="100%">
</div>
<div id="container">
<img src="resources/image/logo.png" width="125px" height="75px">
<P>${serverTime}</P>
<c:if test="${not empty loginID}">
<span>${loginID}님 환영합니다.</span>
</c:if>
<c:if test="${not empty message}">
<span>${message}</span>
</c:if>
</div>
<div class="modal"></div><div class="modal_content"></div>
<div class="footer">
 <hr>
 <center>
<font size=2 color="gray"  face="휴먼모음T">  
<!-- <a href="left.html" target="left">[HTML]</a>&nbsp;&nbsp;&nbsp; -->
<!-- <a href="leftCss.html" target="left">[CSS]</a>&nbsp;&nbsp;&nbsp; -->
<!-- <a href="leftJs.html" target="left">[JavaScript]</a>&nbsp;&nbsp;&nbsp; -->
<!-- <a href="leftJq.html" target="left">[JQuery]</a> -->
<br><br>	
  주소 : 경기도 성남시 분당구 금곡동 그린 컴퓨터아카데미<br>
  연락처 : 010-****-****<br>
  <a HREF="mailto:ummsam@naver.com">e 메일 문의...</a> </font>
</center>
</div>
</body>
</html>

