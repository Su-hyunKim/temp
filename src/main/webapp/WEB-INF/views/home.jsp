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
	
	$('#loginBt').hover(function(){
		$(this).css({
			cursor:"pointer"
		}); //css
	}, function(){
		$(this).css({
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
	
}); //ready
</script>
<style>
	* { padding:3px; }
	.menu div { overflow:auto; position:absolute; top:10px; }
	#d1 { left:20%; }
	#d2 { left:47%; }
	#d3 { left:70%; }
	ul { list-style:none; }
	.title{ color:black;}
	ul a { 
		font-size:20px; font-weight:bold; color:gray;
		text-decoration:underline; line-height:30px;
	}
	ul ul { display:none; clear:both; }
	ul li:hover ul { display:block; }
	ul li a:hover { color:green; }	
	.footer a { color: black ; text-decoration: none }
	#home {position:fixed; left:10px; top:10px;}
	#loginBt {position:fixed; left:92%; top:10px;}
	body @font-face {
    font-family: 'Arita-dotum-Medium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/Arita-dotum-Medium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
	}
	.banner{opacity:0.5; height:250px; width:100%; padding:0; border:0;}
	#container{height:250px; width:100%;}
</style>
</head>
<body>
<div id="home"><a href="home"><img src="resources/image/home.png" width="30" height="30"></a></div>
<div id="loginBt"><img src="resources/image/login.png" width="30" height="30"></div>
<div class="menu">
<ul>
	<div id="d1">
	<li><a class="title" href="">게시판</a>
	<ul>
		<li><a href="https://www.w3schools.com/colors/colors_groups.asp" target="_blank">ColorPicker</a>
		<li><a href="https://oracle.com" target="_blank">Oracle</a>
		<li><a href="http://docs.oracle.com/javase/8/docs/api" target="main">JavaAPI</a>
		<li><a href="http://www.eclipse.org"  target="_blank">Eclipse</a>
		<li><a href="http://tomcat.apache.org"  target="_blank">Tomcat</a>
	</ul>
	</div>
	<div id="d2">
	<li><a class="title" href="">상 품</a>
	<ul>
		<li><a href="https://www.w3schools.com/colors/colors_groups.asp" target="_blank">ColorPicker</a>
		<li><a href="https://oracle.com" target="_blank">Oracle</a>
		<li><a href="http://docs.oracle.com/javase/8/docs/api" target="main">JavaAPI</a>
		<li><a href="http://www.eclipse.org"  target="_blank">Eclipse</a>
		<li><a href="http://tomcat.apache.org"  target="_blank">Tomcat</a>
	</ul>
	</div>
	<div id="d3">
	<li><a class="title" href="">GoodSite</a>
	<ul>
		<li><a href="https://www.w3schools.com/colors/colors_groups.asp" target="_blank">ColorPicker</a>
		<li><a href="https://oracle.com" target="_blank">Oracle</a>
		<li><a href="http://docs.oracle.com/javase/8/docs/api" target="main">JavaAPI</a>
		<li><a href="http://www.eclipse.org"  target="_blank">Eclipse</a>
		<li><a href="http://tomcat.apache.org"  target="_blank">Tomcat</a>
	</ul>
	</div>
</ul>
</div>
<div class="banner">
<img src="resources/image/stars.png" width="100%" height="100%">
</div>
<div id="container">
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

