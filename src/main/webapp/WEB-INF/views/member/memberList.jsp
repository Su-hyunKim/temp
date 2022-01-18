<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<html>
<head>
	<meta charset="UTF-8">
	<title>필요한 이를 이어주는 징검다리</title>
	<link rel="stylesheet" type="text/css" href="resources/lib/main.css">
	<script src="resources/lib/jquery-3.2.1.min.js"></script> 
	<script src="resources/lib/menu.js"></script>
</head>
<body>
<div id="home"><a href="home"><img src="resources/image/home.png" width="30" height="30"></a></div>
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
				<li id="comment"><span>리뷰작성</span>
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
				<li><a href="mchecklist"><span>회원검색</span></a>
			</ul>
		</div>
	</ul>
</div>
<c:if test="${not empty loginID}">
<input type="hidden" id="loginID" value="${loginID}">
</c:if>
<div id="container">
<h3>** 멤버리스트 **</h3>
<br>
<c:if test="${not empty message}">
=> ${message}<br>
</c:if>
<div id="searchBar">
	<form action="mchecklist" method="get">
		<b>Level : </b>
		<input type="checkbox" name="check" value="플레인">플레인&nbsp;
		<input type="checkbox" name="check" value="브론즈">브론즈&nbsp;
		<input type="checkbox" name="check" value="실버">실버&nbsp;
		<input type="checkbox" name="check" value="골드">골드&nbsp;&nbsp;
		<button id="mchecklist">검색</button>&nbsp;
		<input type="reset" value="취소">
	</form>
</div><br>
<hr>
<table width=100%>
<tr height="30" bgcolor="pink">
	<th>I D</th><th>Password</th><th>Name</th><th>Gender</th>
	<th>Birthday</th><th>Email</th><th>Phone</th><th>Interest</th><th>Last Access</th>
</tr>	
<c:forEach var="list" items="${banana}">
<tr  height="30" align="center">
	<td> <!-- 관리자 기능 추가하기 -->
	<c:if test="${loginID=='1'}">
		<a href="mdetail?member_id=${list.member_id}">${list.member_id}</a>
	</c:if>
	<c:if test="${loginID!='1'}">
		${list.member_id} 
	</c:if>
	</td>
	<td>${list.password}</td><td>${list.name}</td><td>${list.gender}</td>
	<td>${list.birthday}</td><td>${list.email}</td>
	<td>${list.phone}</td><td>${list.interest}</td>
	<td>${list.last_access}</td>
</tr>
</c:forEach>
</table>
<hr>

<a href="home" >[Home]</a>

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

