<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 작성</title>
<link rel="stylesheet" href="resources/lib/comment.css"/>
<!-- Font Awesome Icons -->
<link rel="stylesheet" href="resources/lib/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="resources/lib/dist/css/adminlte.min.css">
<script src="resources/lib/jquery-3.2.1.min.js"></script>
<script src="resources/lib/inCheck.js"></script>
<script>
$(".replyAddBtn").on("click",function() { 
	// 화면으로부터 입력 받은 변수값의 처리 
	var texts = $("#newtexts"); 
	var member_id = $("#newmember_id"); 
	var textsVal = texts.val(); 
	var member_idVal = member_id.val(); 
	// AJAX 통신 : POST 
	$.ajax({ 
		type : "post", 
		url : "${path}/comments", 
		headers : { "Content-type" : "application/json", "X-HTTP-Method-Override" : "POST" }, 
		dataType : "text", 
		data : JSON.stringify({ 
			root_seq : root_seq,
			texts : textsVal, 
			member_id : member_idVal 
		}), 
		success : function (result) { 
			// 성공적인 댓글 등록 처리 알림 
			if (result == "regSuccess") { 
				alert("댓글 등록 완료!"); 
			} 
			getComments(); // 댓글 목록 출력 함수 호출 
			texts.val(""); // 댓글 내용 초기화 
			member_id.val(""); // 댓글 작성자 초기화 
			} 
		}); 
	});
//댓글 목록 호출 
var root_seq=3;
getComments(); 
// 댓글 목록 출력 함수 
function getComments() { 
	$.getJSON("${path}/comments/all/" + root_seq, function (data) { 
		console.log(data); 
		var str = ""; 
		$(data).each(function () { 
			str += "<li data-reply_seq='" + this.reply_seq + "' class='CommentLi'>" 
				+ "<p class='texts'>" + this.texts + "</p>" 
				+ "<p class='member_id'>" + this.member_id + "</p>" 
				+ "<button type='button' class='btn btn-xs btn-success' data-toggle='modal' data-target='#modifyModal'>댓글 수정</button>" 
				+ "</li>" 
				+ "<hr/>"; 
		}); 
		$("#comments").html(str); 
	}); 
}
</script>
</head>
<body>
	<div class="col-lg-12"> 
		<div class="card"> 
			<div class="card-header with-border"> 
				<h3 class="card-title">리뷰에 대한 평가를 남겨주세요.</h3><hr><hr> 
				<div class="star-rating">
					<input type="radio" id="5-stars" name="rating" value="5" v-model="ratings"/>
					<label for="5-stars" class="star pr-4">★</label>
					<input type="radio" id="4-stars" name="rating" value="4" v-model="ratings"/>
					<label for="4-stars" class="star">★</label>
					<input type="radio" id="3-stars" name="rating" value="3" v-model="ratings"/>
					<label for="3-stars" class="star">★</label>
					<input type="radio" id="2-stars" name="rating" value="2" v-model="ratings"/>
					<label for="2-stars" class="star">★</label>
					<input type="radio" id="1-star" name="rating" value="1" v-model="ratings" />
					<label for="1-star" class="star">★</label>
				</div>
			</div> 
			<div class="card-body"> 
				<div class="row"> 
					<div class="form-group col-sm-8"> 
						<input class="form-control input-sm" id="newReplyText" type="text" placeholder="댓글 입력..."> 
					</div> 
					<div class="form-group col-sm-2"> 
						<input class="form-control input-sm" name="member_id" type="text" value="${loginID}" readonly> 
					</div>
					<div class="form-group col-sm-2"> 
						<button type="button" class="btn btn-primary btn-sm btn-block replyAddBtn"> 
							<i class="fa fa-save"></i> 저장 
						</button> 
					</div> 
				</div> 
			</div> 
			<div class="card-footer"> 
				<ul id="comments"> </ul> 
			</div> 
			<div class="card-footer"> 
				<nav aria-label="Contacts Page Navigation"> 
				<ul class="pagination pagination-sm no-margin justify-content-center m-0"> </ul> 
				</nav> 
			</div> 
		</div> 
	</div> 
	<div class="modal fade" id="modifyModal" role="dialog"> 
		<div class="modal-dialog"> 
			<div class="modal-content"> 
				<div class="modal-header"> 
					<button type="button" class="close" data-dismiss="modal">&times;</button> 
					<h4 class="modal-title">댓글 수정창</h4> 
				</div> 
				<div class="modal-body"> 
					<div class="form-group"> 
						<label for="reply_seq">댓글 번호</label> 
						<input class="form-control" id="reply_seq" name="reply_seq" readonly> 
					</div> 
					<div class="form-group"> 
						<label for="texts">댓글 내용</label> 
						<input class="form-control" id="texts" name="texts" placeholder="댓글 내용을 입력해주세요"> 
					</div> 
					<div class="form-group"> 
						<label for="member_id">댓글 작성자</label> 
						<input class="form-control" id="member_id" name="member_id" readonly> 
					</div> 
				</div> 
				<div class="modal-footer"> 
					<button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button> 
					<button type="button" class="btn btn-success modalModBtn">수정</button> 
					<button type="button" class="btn btn-danger modalDelBtn">삭제</button> 
				</div> 
			</div> 
		</div> 
	</div>

</body>
</html>