<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>징검다리 : ID 중복 확인</title>
<script>
//** 사용자가 입력한 id 를 사용가능하도록 해주고, 현재(this)창은 close
// => this 창의 id 를 부모창의 id 로
// => 부모창의 ID중복확인 버튼은 disable & submit 은 enable
// => 부모창의 id 는 수정불가 (readonly) , password 에 focus
// => 현재(this)창은 close   
  function idOK() {	
	$('#myForm #idDup').prop('disabled',true);
	$('#myForm #submit').prop('disabled',false);	
	$('#myForm #member_id').prop('readonly',true);
	$('.modal,.modal_content').hide();
  } //idOK
  
  function closeModal() {
	  $('.modal,.modal_content').hide();
	  $('#myForm #member_id').val('').focus();
  }
</script>
</head>
<body>
<div class="wrapped">
	<h1>ID 중복 확인</h1>
	<div id="msgBlock">
		<c:if test="${idUse=='T'}">
			${newID} 는 사용가능 합니다<br><br>
			<input type="button" value="아이디를 사용" onclick="idOK()" id="idOK">&nbsp;&nbsp;
			<input type="button" value="취소" onclick="closeModal()">
			<!-- 사용자가 입력한 id 를 사용가능하도록 해주고, 현재(this)창은 close -->
		</c:if>
		<c:if test="${idUse=='F'}">
			${newID} 는 이미 사용중 입니다<br>
			다시 입력 하세요<br><br>
			<input type="button" value="입력창으로" onclick="closeModal()" id="idOK">
			<!-- 부모창(joinForm, opener)에 남아있는 사용자가 입력한 id 를 지워주고,
  		     현재(this)창 의 id 에 포커스를 주고 재입력 유도 
  		     JScript 코드 필요함-->
		</c:if>
	</div>
</div>

</body>
</html>