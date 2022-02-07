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
<title>Comments UpdateForm</title>
<link rel="stylesheet" type="text/css" href="resources/lib/main.css">
<script src="resources/lib/menu.js"></script>
<link rel="stylesheet" href="resources/lib/comment.css"/>
<!-- Font Awesome Icons -->
<link rel="stylesheet" href="resources/lib/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="resources/lib/dist/css/adminlte.min.css">
<script>
function 함수이름(){  
       location.reload();
}
</script>
</head>
<body>
<form action="cupdate" method="post" id="modal_form">
<div class="wrapper">
	<div>
		<s:csrfInput/>
		<table>
			<tr height="40"><th bgcolor="HoneyDew ">리뷰글 번호</th><th bgcolor="HoneyDew ">댓글 번호</th>
				<th bgcolor="HoneyDew ">I D</th><th bgcolor="HoneyDew ">등록 시간</th></tr>
				
			<tr height="40">
				<td><input class="form-control input-sm" name="root_seq" type="text" value="${apple.root_seq}" readonly></td>
				<td><input class="form-control input-sm" name="reply_seq" type="text" value="${apple.reply_seq}" readonly></td>
				<td><input class="form-control input-sm" name="member_id" type="text" value="${apple.member_id}" readonly></td>
				<td><input class="form-control input-sm" name="regdate" type="text" value="${apple.regdate}" readonly></td>
			<tr height="40"><th bgcolor="HoneyDew ">별점</th>
				<td>
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
				</td>
				
			</tr>
			<tr height="40"><th bgcolor="HoneyDew ">댓글 내용</th>
				<td colspan="2">
				<input class="form-control input-sm" name="texts" type="text" value="${apple.texts}">
				</td>
				<td>
				<input type="submit" value="수정">&nbsp;&nbsp;
				</td>
			</tr>
		</table>
	</div>
	<div class="form-group col-sm-2"> 
		<h6><a href="comment" >댓글 목록</a></h6>
	</div> 
</div>
<s:csrfInput/>
</form>
<c:if test="${not empty message}">
<br>=> ${message}<br><br> 
</c:if>
</body>
</html>