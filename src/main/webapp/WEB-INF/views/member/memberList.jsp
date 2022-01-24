<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<html>
<head>
	<meta charset="UTF-8">
	<title>Member List</title>
	<style>	
		#searchBar input[type="checkbox"]{width:20px;margin:0}
	</style>
	<script src="resources/lib/jquery-3.2.1.min.js"></script> 
	<script>
		$('#listSearch').click(function(e){
			let url = '';
			for(var i=0; i<$('input[type="checkbox"]:checked').length; i++)
				url+='&check='+$($('input[type="checkbox"]:checked')[i]).val();
			url = 'mlist?'+url.substring(1);
			$.ajax({
				type:'get',
				url:url,
				success:function(resultPage){
					resultPage = resultPage.substring(
							resultPage.lastIndexOf('"targetList">')+13,
							resultPage.lastIndexOf('</div>'));
					$('#targetList').html(resultPage);					
				},
				error:function() {
					alert("~~ 서버오류!!! 잠시후 다시 하세요 ~~");
				}
			}); //ajax
			return false;
		});
	</script>
</head>
<body>
<div class="wrapped">
<h1>회원검색</h1>
<div id="searchBar">
	<form action="mlist" method="get">
		<label><input type="checkbox" name="check" value="플레인">플레인&nbsp;</label>
		<label><input type="checkbox" name="check" value="브론즈">브론즈&nbsp;</label>
		<label><input type="checkbox" name="check" value="실버">실버&nbsp;</label>
		<label><input type="checkbox" name="check" value="골드">골드&nbsp;&nbsp;</label>
 		<button id="listSearch">검색</button>&nbsp;		
		<input type="reset" value="취소">
	</form>
</div>
<div id="targetList">
<c:if test="${not empty message}">
=> ${message}<br>
</c:if>
<br>
<hr>
<table width=100%>
<tr height="30" bgcolor="RosyBrown">
	<th>I D</th><th>이름</th><th>성별</th><th>생년</th>
	<th>주소지</th><th>point</th><th>Last Access</th>
</tr>	
<c:forEach var="list" items="${banana}">
<tr  height="30" align="center">
	<td> <!-- 관리자 기능 추가하기 -->
	<c:if test="${loginID=='admin'}">
		<a href="mdetail?member_id=${list.member_id}">${list.member_id}</a>
	</c:if>
	<c:if test="${loginID!='admin'}">
		${list.member_id} 
	</c:if>
	</td>
	<td>${list.name}</td><td>${list.gender}</td><td>${list.birthday}</td>
	<td>${list.address2}</td><td>${list.point}</td><td>${list.last_access}</td>
</tr>
</c:forEach>
</table>
<hr>
</div>
</div>
</body>
</html>

