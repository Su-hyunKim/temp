<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<html>
<head>
	<meta charset="UTF-8">
	<title>필요한 이를 이어주는 징검다리</title>
	<link rel="stylesheet" type="text/css" href="resources/lib/main.css">
	<script src="resources/lib/jquery-3.2.1.min.js"></script> 
<script>
$(function(){
	
	if(document.getElementById("loginID")){
		$('#loginBt').hide();
		$('#logoutBt').show();
	}else{
		$('#loginBt').show();
		$('#logoutBt').hide();
	}
	
	ajaxBnts.forEach(function(ajaxButton){
		if(ajaxButton.opt.includes('scale')) scale(ajaxButton.id);
		if(ajaxButton.url!=null){
			let success;
			let url = ajaxButton.url;
			let container = '#container'
			if(ajaxButton.opt.includes('loginID')) url = url+$('#loginID').val();
			if(ajaxButton.opt.includes('modal')){
				modal('#'+ajaxButton.id,300,300);
				container = '.modal_content';
			}
			if(ajaxButton.convey=='data'){
				success = function(resultData) {
								location.reload();
								alert(resultData.message);				
							};
			}else if(ajaxButton.convey=='page'){
				success = function(resultPage) {
								let body = resultPage.substring(resultPage.lastIndexOf('<body>')+6,
										resultPage.lastIndexOf('</body>'));
								if(body.indexOf("<P>징검다리</P>")!=-1)
									resultPage = body.substring(body.indexOf('<P>징검다리</P>'),
										body.indexOf('<div class="footer">'));
								$(container).html(resultPage);	
							};
			}
			$('#'+ajaxButton.id).click(function(e){	
					if(ajaxButton.opt.includes('banner')) banner();
				$.ajax({
					type:ajaxButton.method,
					url:url,
					success:success,
					error:function() {
								alert("~~ 서버오류!!! 잠시후 다시 하세요 ~~");
							}
				}); //ajax
				e.stopPropagation();
			}); //click
		} //if
	}); //ajaxBnts_forEach
	

	$('.modal').click(function(e){
		$('.modal,.modal_content').hide();
		e.stopPropagation();
	});
	
}); //ready

class AjaxButton{
	constructor(opt,id,url,method,convey){
		this.opt=opt;
		this.id=id;
		this.url=url;
		this.method=method;
		this.convey=convey;
	}
}

class Home extends AjaxButton{}
class LoginBt extends AjaxButton{}
class LogoutBt extends AjaxButton{}
class Joinf extends AjaxButton{}
class Comment extends AjaxButton{}
class Mypage extends AjaxButton{}
class MList extends AjaxButton{}

const ajaxBnts = [new Home(['scale'],'home',null,null,null),
				new LoginBt(['scale','modal'],'loginBt','loginf','get','page'),
				new LogoutBt(['scale','loginID'],'logoutBt','logout?member_id=','get','data'),
				new Joinf(['banner'],'joinf','joinf','get','page'),
				new Comment(['banner'],'comment','comment','get','page'),
				new Mypage(['banner','loginID'],'mypage','mdetail?member_id=','get','page'),
				new MList(['banner'],'mlist','mlist','get','page')
				];

function scale(id){
	$('#'+id).hover(function(){
		$(this).css({
			transform:"scale(1.2)",
			cursor:"pointer"
		}); //css
	}, function(){
		$(this).css({
			transform:"scale(1)",
			cursor:"default"
		}); //css
	}); //hover
} //scale

function modal(button,width,height){
	$(button).click(function(e){
		$('.modal').css({
			position:"fixed",
			top:0,
			left:0,
			width:"100%",
			height:"100%", 
			background:"rgba(0,0,0,0.5)",
			display:"block"
		});
		$('.modal_content').css({
			position:"fixed",
			width:width,
			height:height,
			top:(window.innerHeight-height)/2,
			left:(window.innerWidth-width)/2,
			background:"white",
			display:"block",
			border:"0px solid gray",
			borderRadius:"5px 5px",
		});
		e.stopPropagation();
	}); //button_click
} //modal

function banner(){
	$('.banner').css({display:"none"});
}

</script>
</head>
<body>
<div id="home"><a href=""><img src="resources/image/home.png" width="30" height="30"></a></div>
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
				<li id="mlist"><span>회원검색</span>
			</ul>
		</div>
	</ul>
</div>
<c:if test="${not empty loginID}">
<input type="hidden" id="loginID" value="${loginID}">
</c:if>
<div class="banner">
<img src="resources/image/stars.png" width="100%" height="100%">
</div>
<div id="container">
<P>징검다리</P>
<P>${serverTime}</P>
<c:if test="${not empty loginID}">
<span>${loginName}님 환영합니다.</span>
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

