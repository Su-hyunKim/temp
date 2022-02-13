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
<form action="cinsert" method="post">
	<div class="col-lg-12"> 
		<div class="card"> 
			<div class="card-header with-border"> 
				<h3 class="card-title">리뷰에 대한 평가를 남겨주세요.</h3>
			</div> 
			<div class="card-body"> 
			<s:csrfInput/> 
				<div class="row"> 
					<div class="star-rating">
						<input type="radio" id="5-stars" name="rating" value="5" v-model="rating"/>
						<label for="5-stars" class="star pr-4">★</label>
						<input type="radio" id="4-stars" name="rating" value="4" v-model="rating"/>
						<label for="4-stars" class="star">★</label>
						<input type="radio" id="3-stars" name="rating" value="3" v-model="rating"/>
						<label for="3-stars" class="star">★</label>
						<input type="radio" id="2-stars" name="rating" value="2" v-model="rating"/>
						<label for="2-stars" class="star">★</label>
						<input type="radio" id="1-star" name="rating" value="1" v-model="rating" />
						<label for="1-star" class="star">★</label>
					</div>
				</div>
				<div class="row"> 
					<div class="form-group col-sm-8"> 
						<input class="form-control input-sm" name="texts" type="text" placeholder="댓글 입력..."> 
					</div> 
					<div class="form-group col-sm-2"> 
						<input class="form-control input-sm" name="member_id" type="text" value="${loginID}" readonly> 
					</div>
					<div class="form-group col-sm-2"> 
						<button type="submit" class="btn btn-dark btn-block">댓글 등록</button>
					</div> 
				</div> 
				<div>
					<input type="text" name="root_seq" value="${apple.root_seq}" hidden>
				</div>
			</div> 
			<div class="wrapper"> 
				<jsp:include page="commentsList.jsp" />
			</div> 
		</div> 
	</div> 
	<s:csrfInput/> 
</form>
</body>
</html>