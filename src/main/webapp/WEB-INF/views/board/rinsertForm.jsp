<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>징검다리 : 글쓰기</title>
</head>
<body>
<h1>징검다리 : 글쓰기</h1>
<form action="rinsert" method="post">
<table>
	<tr height="40"><td bgcolor="aqua">아이디</td>
		<td><input type="text" name="member_id" value="${loginID}" size="20" readonly></td></tr>
	<tr height="40"><td bgcolor="aqua">제목</td>
		<td><input type="text" name="title"></td></tr>	
	<tr height="40"><td bgcolor="aqua">내용</td>
		<td><textarea name="content" rows="5" cols="50"></textarea></td></tr>
	<tr height="40"><td bgcolor="aqua">상품번호</td>
		<td><input type="text" name="product_id" id="product_id" size="20"></td>
		<!-- 여기서 상품태그 걸어야 하나요? -->
	</tr>		
	<tr height="40"><td bgcolor="aqua">첨부파일</td>
		<td><img src="" class="select_img"><br>
			<input type="file" name="uploadfilef" id="uploadfilef">
			<script>
			// 해당 파일의 서버상의 경로를 src로 지정하는것으로는 클라이언트 영역에서 이미지는 표시될수 없기 때문에
			// 이를 해결하기 위해 FileReader이라는 Web API를 사용
			// => 이 를 통해 url data를 얻을 수 있음.
			//    ( https://developer.mozilla.org/ko/docs/Web/API/FileReader)
			// ** FileReader
			// => 웹 애플리케이션이 비동기적으로 데이터를 읽기 위하여 읽을 파일을 가리키는File
			//    혹은 Blob 객체를 이용해 파일의 내용을(혹은 raw data버퍼로) 읽고 
			//    사용자의 컴퓨터에 저장하는 것을 가능하게 해줌.	
			// => FileReader.onload 이벤트의 핸들러.
			//    읽기 동작이 성공적으로 완료 되었을 때마다 발생.
			// => e.target : 이벤트를 유발시킨 DOM 객체
	  		
				$('#uploadfilef').change(function(){
					if(this.files && this.files[0]) {
						var reader = new FileReader;
				 			reader.onload = function(e) {
			 				$(".select_img").attr("src", e.target.result)
			 					.width(100).height(100); 
			 				} // onload_function
			 				reader.readAsDataURL(this.files[0]);
			 			
			 		} // if
				}); // change			
			</script>
		</td>
	</tr>	
	<tr height="40"><td></td>
		<td><input type="submit" value="등록">&nbsp;&nbsp;
			<input type="reset" value="취소">
		</td></tr>			
</table>
<s:csrfInput/>
</form>
<c:if test="${not empty message}">
<br>=> ${message}<br><br> 
</c:if>
<hr>
<a href="rlist">rList</a>&nbsp;&nbsp;
<a href="home" >[Home]</a>
</body>
</html>