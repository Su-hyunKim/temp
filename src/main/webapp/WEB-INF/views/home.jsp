<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<html>
<head>
	<meta charset="UTF-8">
	<title>Home</title>
	<link rel="stylesheet" type="text/css" href="resources/lib/main.css">
	<script src="resources/lib/jquery-3.2.1.min.js"></script> 
<script>
$(function(){	
	$('#home').hover(function(){
		$(this).css({
			transform:"scale(1.2)",
			cursor:"pointer"
		}); //css
	}, function(){
		$(this).css({
			transform:"scale(1)",
			cursor:"default"
		}); //css
	}) //home

	if(document.getElementById("loginID")){
		$('#loginBt').hide();
		$('#logoutBt').show();
	}else{
		$('#loginBt').show();
		$('#logoutBt').hide();
	}
	
	$('#logoutBt').hover(function(){
		$(this).css({
			transform:"scale(1.2)",
			cursor:"pointer"
		}); //css
	}, function(){
		$(this).css({
			transform:"scale(1)",
			cursor:"default"
		}); //css
	}).click(function(e){		
		$.ajax({
			type:"Get",
			url:"logout",
			success:function(resultData) {
				location.reload();
				alert(resultData.message);				
			},
			error:function() {
				alert("~~ 서버오류!!! 잠시후 다시 하세요 ~~");
			}
		}); //ajax
	}) //logoutBt
	
	$('#loginBt').hover(function(){
		$(this).css({
			transform:"scale(1.2)",
			cursor:"pointer"
		}); //css
	}, function(){
		$(this).css({
			transform:"scale(1)",
			cursor:"default"
		}); //css
	}).click(function(e){		
		$.ajax({
			type:"Get",
			url:"loginf",
			success:function(resultPage) {
				$('#container').html(resultPage);	
			},
			error:function() {
				alert("~~ 서버오류!!! 잠시후 다시 하세요 ~~");
			}
		}); //ajax
	}) //loginBt
	
	$('#joinf').click(function(e){
		$('.banner').css({display:"none"});
		$.ajax({
			type:"Get",
			url:"joinf",
			success:function(resultPage) {
				$('#container').html(resultPage);	
			},
			error:function() {
				alert("~~ 서버오류!!! 잠시후 다시 하세요 ~~");
			}
		}); //ajax
	}) //joinf	
	
	$('#mypage').click(function(e){
		$('.banner').css({display:"none"});
		$.ajax({
			type:"Get",
			url:"mdetail?member_id="+$('#loginID').val(),
			success:function(resultPage) {
				var html = resultPage;				
				var body = html.substring(html.lastIndexOf('<body>')+6,html.lastIndexOf('</body>'));
				if(body.indexOf("<P>HOME</P>")!=-1) html = body.substring(body.indexOf('<P>HOME</P>'),
						body.indexOf('<div class="footer">'));
				$('#container').html(html);	
			},
			error:function() {
				alert("~~ 서버오류!!! 잠시후 다시 하세요 ~~");
			}
		}); //ajax
	}) //joinf
}); //ready
</script>
</head>
<body>
<div id="home"><a href=""><img src="resources/image/home.png" width="30" height="30"></a></div>
<img  id="loginBt" src="resources/image/login.png" width="35" height="35">
<img  id="logoutBt" src="resources/image/logout.png" width="35" height="35">
<div class="menu">
<ul>
	<div id="d1">
	<li class="title">게시판
	<ul>
		<li><span>전체글조회</span>
		<li><span>홍보글조회</span>
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
	</ul>
	</div>
</ul>
</div>
<div class="banner">
<img src="resources/image/stars.png" width="100%" height="100%">
</div>
<div id="container">
<P>HOME</P>
<P>${serverTime}</P>
<c:if test="${not empty loginID}">
<input type="hidden" id="loginID" value="${loginID}">
<span>${loginName}님 환영합니다.</span>
</c:if>
<c:if test="${not empty message}">
<span>${message}</span>
</c:if>
</div>

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

