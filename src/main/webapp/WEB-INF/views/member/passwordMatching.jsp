<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기존 비밀번호 확인</title>
	<style>
		table{text-align:center;}
	</style>
	<script src="resources/lib/jquery-3.2.1.min.js"></script>
 	<script>
 	var header = '${_csrf.headerName}';
 	var token = '${_csrf.token}';

/*	스프링 시큐리티가 적용된 사이트의 Post 방식에는 CSRF 토큰을 사용함 */	
	$('#pwmatch').hover(function(){$(this).css({cursor:"pointer"})},
			function(){$(this).css({curcor:"default"})})
		.click(function(e){
			$.ajax({
				type:"post",
				url:"pwmatch",
				data: {
					member_id: ${member_id},
					password: $('#modal_form #password').val()
				},
				beforeSend : function(xhr){
					// 전송전에 헤더에 csrf의 값을 설정 해야함
					xhr.setRequestHeader(header, token);
				},
				success:function(resultData) {
					// => 서버로부터 Json 형태의 Data 를 Response 로 받음
					//    "pwMatch" -> "T" 일치 , 다음 요청명 이행
					//    "pwMatch" -> "F" 불일치
					
					// 문자열 형태의 Data를 json Object로 변환 
					resultData = JSON.parse(resultData);
					if (resultData.pwMatch=="T") {
						alert("password 수정 화면으로 이동합니다.");
						location.href="pwupdatef?member_id="+${member_id};
					}else {
						$('#message').html(resultData.message);
						$('#modal_form #password').focus();
					}
				},
				error: function() {
					$('#message').html("~~ 서버 오류 입니다 ~~");
				}
			}); //ajax
			return false;
		}); //jslogin_click 
		
/* 	$('.modalClose').click(function(e){
		$('.modal,.modal_content').hide();
		e.stopPropagation();
	}); */
 	</script>
</head>
<body>
<div class="wrapped">
<h1>기존 비밀번호 확인</h1>
<form action="pwmatch" method="post" id="modal_form">
<table>
	<tr><td bgcolor="gray">Password</td>
		<td>
			<input type="password" name="password" id="password" placeholder="password를 입력해주세요">
			<span id="pMessage" class="eMessage"></span>
		</td>
	</tr>
	<tr><td colspan="2">
			<input type="submit" id="pwmatch" value="비밀번호 확인">&nbsp; 
			<input type="reset" value="Reset">			
		</td>
	</tr> 
</table>
</form>
<!-- <div class="modalClose">X</div> -->
<span id="message"></span>
</div>


</body>
</html> 