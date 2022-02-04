<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>CommentsList</title>
<link rel="stylesheet" type="text/css" href="resources/lib/main.css">
<script src="resources/lib/menu.js"></script>
<link rel="stylesheet" href="resources/lib/comment.css"/>
<!-- Font Awesome Icons -->
<link rel="stylesheet" href="resources/lib/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="resources/lib/dist/css/adminlte.min.css">
<script src="resources/lib/jquery-3.2.1.min.js"></script>
</head>
<body>
<div class=wrapper>
	<div>
		<c:if test="${not empty message}">
		=> ${message}<br>
		</c:if>
		<table width=100%>
			<tr height="30" bgcolor="GreenYellow" align="center">
				<th>Seq</th><th>ID</th><th>댓글 내용</th><th>별점</th><th>등록 시간</th><th>수정 / 삭제</th>
			</tr>	
			<c:forEach var="list" items="${banana}">
				<tr height="30" align="center">
					<td width="5%">${list.reply_seq}</td><td width="10%">${list.member_id}</td>
					<td width="55%">${list.texts}</td><td width="5%">${list.rating}</td><td width="15%">${list.regdate}</td>
					<td width="10%">
						<c:if test="${loginID==list.member_id  || loginID=='admin'}">
							<a href="cdetail?reply_seq=${list.reply_seq}">글수정</a>&nbsp;&nbsp;
							<a href="cdelete?reply_seq=${list.reply_seq}">글삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<h4><a href="home" >[Home]</a></h4>
</div>

</body>
</html>