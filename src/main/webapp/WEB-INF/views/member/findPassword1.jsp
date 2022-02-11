<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>징검다리 : 회원ID 확인</title>
	<style>
		table{text-align:center;}
	</style>
 	<script> 
 	$('#idcheck').hover(function(){$(this).css({cursor:"pointer"})},
			function(){$(this).css({curcor:"default"})})
		.click(function(e){
			$.ajax({
				type:"get",
				url:"idcheck?member_id="+$('#modal_form #member_id').val(),
				success:function(resultData) {
					// => 서버로부터 Json 형태의 Data 를 Response 로 받음
					//    "exist" -> "T" 일치 , 다음 요청명 이행
					//    "exist" -> "F" 불일치
					if (resultData.exist=="T") {
						alert("임시비밀번호 발급 화면으로 이동합니다.");
						$.ajax({
							type:"get",
							url:"sendpwf?member_id="+$('#modal_form #member_id').val(),
							success:function(resultPage) {
								$('.modal_content').html(resultPage);
							},
							error: function() {
								$('#message').html("~~ 서버 오류 입니다 ~~");
							}
						});
					}else {
						$('#message').html(resultData.message);
						$('#member_id').focus();
					}
				},
				error: function() {
					$('#message').html("~~ 서버 오류 입니다 ~~");
				}
			}); //ajax
			return false;
		}); //jslogin_click 
 	</script>
</head>
<body>
<div class="wrapped">
<h1>회원ID 확인</h1>
<form action="idcheck" method="get" id="modal_form">
<table>
	<tr><td bgcolor="gray">회원 I D</td>
		<td>
			<input type="text" name="member_id" id="member_id" placeholder="회원ID를 입력해주세요">
			<span id="iMessage" class="eMessage"></span>
		</td>
	</tr>
	<tr><td colspan="2">
			<input type="submit" id="idcheck" value="ID확인">&nbsp; 
			<input type="reset" value="입력 초기화">			
		</td>
	</tr> 
</table>
</form>
<span id="message"></span>
<a href="findidf">[아이디 찾기]</a>&nbsp;
</div>
</body>
</html> 