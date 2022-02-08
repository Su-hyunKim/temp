<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>댓글 작성</title>
<link rel="stylesheet" type="text/css" href="resources/lib/main.css">
<link rel="stylesheet" href="resources/lib/comment.css"/>
<!-- Font Awesome Icons -->
<link rel="stylesheet" href="resources/lib/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="resources/lib/dist/css/adminlte.min.css">
<script src="resources/lib/jquery-3.2.1.min.js"></script>
</head>
<body>
<form action="psend" method="post">
	<div class="col-lg-12"> 
		<div class="card"> 
			<div class="card-header with-border"> 
				<h3 class="card-title">보유중인 포인트</h3>
				<div class="form-group col-sm-2"> 
				<input class="form-control input-sm" name="mypoint" type="text" value="${mypoint}" readonly>
				</div>
			</div> 
			<div class="card-header with-border"> 
				<h3 class="card-title">보내실 포인트와 받으실 분을 작성해 주세요.</h3>
			</div> 
			<div class="card-body"> 
			<s:csrfInput/> 
				<div class="row"> 
					<div class="form-group col-sm-2"> 
						<input class="form-control input-sm" name="point" type="text" placeholder="보내실 포인트를 입력해주세요."> 
					</div> 
					<div class="form-group col-sm-2"> 
						<input class="form-control input-sm" name="giver" type="text" value="${loginID}" readonly> 
					</div>
					<div class="form-group col-sm-2"> 
						<input class="form-control input-sm" name="grantee" type="text" placeholder="받으실분의 아이디를 적어주세요."> 
					</div>
				</div> 
				<div class="form-group col-sm-2"> 
						<button type="submit" class="btn btn-dark btn-block">보내기</button>
				</div> 
				<c:if test="${not empty message}">
				=> ${message}<br>
				</c:if>
			</div> 
		</div> 
		<h4><a href="mypage?member_id=${loginID}&R=mypage" >[마이페이지]</a></h4>
	</div> 
	<s:csrfInput/> 
</form>
</body>
</html>