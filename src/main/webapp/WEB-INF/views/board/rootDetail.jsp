<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0,
	user-scalable=no, maximum-scale=1.0,minimum-scale=1.0">
<title>게시판 상세정보</title>
<script src="resources/lib/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="resources/lib/main.css">
</head>
<body>
<h1>게시판 상세정보</h1>
<table>
	<tr height="40">
		<td>글번호</td><td>${apple.root_seq}</td>
	</tr>
	<tr height="40">
		<td>I D</td><td>${apple.member_id}&nbsp;&nbsp;<button id="followFlag">팔로우</button>
		팔로워 ${follower}, 팔로잉 ${following}</td>
	<!-- 	팔로잉 팔로워 카운트 표시 -->
	</tr>
	<tr height="40">
		<td>제목</td><td>${apple.title}</td>
	</tr>
	<tr height="40">
		<td>글내용</td>
		<td><textarea rows="7" cols="50" readonly>${apple.content}</textarea></td>
	</tr>
	<tr height="40">
		<td>첨부파일</td>
		<td><img src="${apple.files}" width="150" height="150"></td>
	</tr>
	<tr height="40">
		<td>글등록일</td><td>${apple.regdate}</td>
	</tr>
	<tr height="40">
		<td>조회수</td><td>${apple.cnt}</td>
	</tr>
	
</table>
<c:if test="${not empty message}">
<hr>
=> ${message}<br>
</c:if>
<!-- 1) 글수정, 글삭제
		-> 내가 쓴글인 경우, 관리자 인경우 에만 가능 
		-> loginID 와 apple.id 가 동일한 경우
 -->
 <hr>
<c:if test="${loginID==apple.member_id  || loginID=='admin'}">
	<a href="rdetail?jcode=U&root_seq=${apple.root_seq}">글수정</a>&nbsp;&nbsp;
	<a href="rdelete?root_seq=${apple.root_seq}">글삭제</a>
		<!-- 삭제시 원글삭제 or 답글삭제 확인을 위함 -->
</c:if> 
<!-- 새글, 답글등록 추가하기 -->
&nbsp;&nbsp;<a href="rinsertf">새글등록</a>
<jsp:include page="commentsForm.jsp" />
<hr>
<a href='javascript:history.go(-1)'>이전으로</a>&nbsp;&nbsp;
<a href="home">HOME</a>
<script>
$(function(){
	if('${loginID}'=='${apple.member_id}') $("#followFlag").hide();
	else  $("#followFlag").show();
	if('${followflag}'=='0') $("#followFlag").html('팔로우');
	else $("#followFlag").html('팔로잉');
	// follow 서블릿 호출 
	// var data = [jsonType data ]
	$("#followFlag").click(function(){
		var tag = $(this).html();
		if(tag=='팔로우'){
			tag='insert'
		}else{
			tag='delete'
		}
		$.ajax({ 
			url: "followMember", 
			type: "GET", 
			data: {
				following:'${loginID}',
				follower:'${apple.member_id}',
				tag:tag		
			}, 
			success: function(data){  // true or false
				if(data.success=="T"){
					location.reload();
// 					if(tag=='insert'){ 
// 						$("#followFlag").val("팔로잉");
// 					}else{
// 						$("#followFlag").val("팔로우"); 
// 					}
				}else{
					alert("팔로우처리가 정상적으로 실행되지 않았습니다");
				}
			}, 
			error: function (request, status, error){ 
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

			} 
		});
		return false;
	})
	
	
});
</script>
</body>
</html>