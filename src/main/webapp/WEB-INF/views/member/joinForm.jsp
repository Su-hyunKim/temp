<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Spring_Mybatis MemberJoin Form **</title>
<link rel="stylesheet" type="text/css" href="resources/myLib/myStyle.css">
<script src="resources/myLib/jquery-3.2.1.min.js"></script>
<script src="resources/myLib/inCheck.js"></script>
<script src="resources/myLib/axTest01.js"></script>

<script>
//1) 개별적 오류 확인을 위한 switch 변수 (전역)	
  var iCheck=false;
  var pCheck=false;	
  var nCheck=false;
  var bCheck=false;
  var oCheck=false; 
  var wCheck=false; 

// 2) 개별적 오류점검위한 focusout 이벤트 핸들러 : JQuery
  $(function() {
	  $('#id').focus();
	  $('#id').keydown(function(e){
		  // enter 누르면 다음 으로 이동
			if (e.which==13) {
				e.preventDefault(); 
				$('#idDup').focus()
			}
	  }).focusout(function() {
		 	iCheck=idCheck();
	  }); //id_focusout
	  
	  $('#password').focusout(function(){
			pCheck=pwCheck();		  
	  }); //password_focusout
	  
	  $('#name').focusout(function(){
			nCheck=nmCheck();		  
	  }); //name_focusout
	  
	  $('#birthd').focusout(function(){
			bCheck=bdCheck();		  
	  }); //birthd_focusout
	  
	  $('#point').focusout(function(){
			oCheck=poCheck();		  
	  }); //point_focusout
	  
	  $('#weight').focusout(function(){
			wCheck=weCheck();		  
	  }); //weight_focusout
  }); //ready


// 3) submit 여부를 판단 & 실행 : JS 의 function
  function inCheck(){
	// 모든 항목에 오류 없음을 확인 : switch 변수
	if (iCheck==false) {
		$('#iMessage').html('~~ id 를 확인하세요 ~~');
	}
	if (pCheck==false) {
		$('#pMessage').html('~~ password 를 확인하세요 ~~');
	}	
	if (nCheck==false) {
		$('#nMessage').html('~~ name 을 확인하세요 ~~');
	}	
	if (bCheck==false) {
		$('#bMessage').html('~~ birthday 를 확인하세요 ~~');
	}
	if (oCheck==false) {
		$('#oMessage').html('~~ point 를 확인하세요 ~~');
	}
	if (wCheck==false) {
		$('#wMessage').html('~~ weight 를 확인하세요 ~~');
	}	
	// 모든 오류 확인완료 
	// => 없으면 submit : return true , 
	//    있으면 submit 을 취소 : return false 
	if ( iCheck && pCheck && nCheck &&
		 bCheck && oCheck && wCheck ) {
		// => submit : 404
		if (confirm("~~ 정말 가입 하십니까 ? (Yes:확인 / No:취소)")==false) {   
		 	  alert('~~ 가입이 취소 되었습니다 ~~');
		 	  return false;
		}else return true; // submit 진행 -> server의 join  
	} else return false; 
  } //inCheck

  //** ID 중복 확인하기
  function idDupCheck() {
	// id 의 입력값 무결성 점검 확인
	if (iCheck==false) {
		iCheck=idCheck();
	}else { 
		// id 중복확인
		// => id를 서버로 보내 중복확인, 결과 처리 
		// => window.open(url,'','')
		//    url 요청을 서버로 전달(request) 하고, 그결과(response)를 Open 해줌
		var url="idcheck?id="+$('#id').val(); 
		window.open(url,'_blank',
				'toolbar=no,menubar=yes,scrollbars=yes,resizable=yes,width=400,height=300');
	}  
  } //idDupCheck
  
</script>

</head>
<body>
<h3>** Spring_Mybatis MemberJoin **</h3>
<!-- <pre><h3>
=> FileUpLoad TestForm
=> form 과 table Tag 사용시 주의사항 : form 내부에 table 사용해야함
   -> form 단위작업시 인식안됨
   -> JQ 의 serialize, FormData 의 append all 등
</h3></pre>
 -->
<form action="join" method="post" enctype="multipart/form-data" id="myForm">
<!-- => method="post" : 255 byte 이상 대용량 전송 가능 하므로 
	 => enctype="multipart/form-data" : 화일 upload 를 가능하게 해줌 
	** multipart/form-data는 파일업로드가 있는 입력양식요소에 사용되는 enctype 속성의 값중 하나이고, 
       multipart는 폼데이터가 여러 부분으로 나뉘어 서버로 전송되는 것을 의미
       이 폼이 제출될 때 이 형식을 서버에 알려주며, 
       multipart/form-data로 지정이 되어 있어야 서버에서 정상적으로 데이터를 처리할 수 있다.  -->
<table>
	<tr height="40">
		<td bgcolor="aquamarine">I D</td>
		<td>
			<input type="text" name="id" id="id" value="testid" size="20">&nbsp;&nbsp;
			<input type="button" value="ID중복확인" id="idDup" onclick="idDupCheck()"><br>
			<span id="iMessage" class="eMessage"></span>
		</td>
	</tr>
	
	<tr height="40">
		<td bgcolor="aquamarine">Name</td>
		<td>
			<input type="text" name="name" id="name" value="홍길동" size="20"><br>
			<span id="nMessage" class="eMessage"></span>
		</td>
	</tr>
	
	<tr height="40">
		<td bgcolor="aquamarine">Password</td>
		<td>
			<input type="password" name="password" id="password" value="12345" size="20"><br>
			<span id="pMessage" class="eMessage"></span>
		</td>
	</tr>
	
	<tr height="40">
		<td bgcolor="aquamarine">Password check</td>
		<td>
			<input type="password" name="password_check" id="password_check" value="12345" size="20"><br>
			<span id="pMessage" class="eMessage"></span>
		</td>
	</tr>
			
	<tr height="40">
		<td bgcolor="aquamarine">gender</td>
		<td>
			<label for="man">man</label>
			<input type="radio" name="gender" class="gender_radio" id="man" value="M">
			<label for="woman">woman</label>
			<input type="radio" name="gender" class="gender_radio" id="woman" value="F">
			<label for="what">what the?</label>
			<input type="radio" name="gender" class="gender_radio" id="what" value="N">
		</td>
	</tr>	
	
	<tr height="40">
		<td bgcolor="aquamarine">Level</td>
		<td>
			<select name="lev" id="lev">
				<option value="A" >관리자</option>
				<option value="B" >나무</option>
				<option value="C" >잎새</option>
				<option value="D" selected>새싹</option>
			</select>
		</td>
	</tr>
		
	<tr height="40">
		<td bgcolor="aquamarine">address</td>
		<td>
			<input type="text" id="sample2_postcode" placeholder="우편번호">
			<input type="button" onclick="sample2_execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" id="sample2_address" placeholder="주소"><br>
			<input type="text" id="sample2_detailAddress" placeholder="상세주소">
			<input type="text" id="sample2_extraAddress" placeholder="참고항목">
			
			<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
			<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
			<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
			</div>
			
			<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
			<script>
			    // 우편번호 찾기 화면을 넣을 element
			    var element_layer = document.getElementById('layer');
			
			    function closeDaumPostcode() {
			        // iframe을 넣은 element를 안보이게 한다.
			        element_layer.style.display = 'none';
			    }
			
			    function sample2_execDaumPostcode() {
			        new daum.Postcode({
			            oncomplete: function(data) {
			                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			
			                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
			                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			                var addr = ''; // 주소 변수
			                var extraAddr = ''; // 참고항목 변수
			
			                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
			                    addr = data.roadAddress;
			                } else { // 사용자가 지번 주소를 선택했을 경우(J)
			                    addr = data.jibunAddress;
			                }
			
			                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			                if(data.userSelectedType === 'R'){
			                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
			                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
			                        extraAddr += data.bname;
			                    }
			                    // 건물명이 있고, 공동주택일 경우 추가한다.
			                    if(data.buildingName !== '' && data.apartment === 'Y'){
			                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			                    }
			                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
			                    if(extraAddr !== ''){
			                        extraAddr = ' (' + extraAddr + ')';
			                    }
			                    // 조합된 참고항목을 해당 필드에 넣는다.
			                    document.getElementById("sample2_extraAddress").value = extraAddr;
			                
			                } else {
			                    document.getElementById("sample2_extraAddress").value = '';
			                }
			
			                // 우편번호와 주소 정보를 해당 필드에 넣는다.
			                document.getElementById('sample2_postcode').value = data.zonecode;
			                document.getElementById("sample2_address").value = addr;
			                // 커서를 상세주소 필드로 이동한다.
			                document.getElementById("sample2_detailAddress").focus();
			
			                // iframe을 넣은 element를 안보이게 한다.
			                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
			                element_layer.style.display = 'none';
			            },
			            width : '100%',
			            height : '100%',
			            maxSuggestItems : 5
			        }).embed(element_layer);
			
			        // iframe을 넣은 element를 보이게 한다.
			        element_layer.style.display = 'block';
			
			        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
			        initLayerPosition();
			    }
			
			    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
			    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
			    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
			    function initLayerPosition(){
			        var width = 300; //우편번호서비스가 들어갈 element의 width
			        var height = 400; //우편번호서비스가 들어갈 element의 height
			        var borderWidth = 5; //샘플에서 사용하는 border의 두께
			
			        // 위에서 선언한 값들을 실제 element에 넣는다.
			        element_layer.style.width = width + 'px';
			        element_layer.style.height = height + 'px';
			        element_layer.style.border = borderWidth + 'px solid';
			        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
			        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
			        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
			    }
			</script>
		</td>
	</tr>	
		
	<tr height="40">
		<td bgcolor="aquamarine">Birthday</td>
		<td>
			<input type="date" name="birthd" id="birthd"><br>
			<span id="bMessage" class="eMessage"></span>
		</td>
	</tr>
	
	
	<tr height="40">
		<td bgcolor="aquamarine">phone</td>
		<td>
			<input type="date" name="phone" id="phone"><br>
			<span id="pMessage" class="eMessage"></span>
		</td>
	</tr>
	
	
	
	<tr height="40">
		<td bgcolor="aquamarine">interest</td>
		<td>
			<textarea id="interest" name="interest" placeholder="interest"></textarea>
		</td>
	</tr>
	
	<tr height="40">
		<td bgcolor="aquamarine">SNS</td>
		<td>
			<input type="text" name="sns" id="sns" value="https://instagram:id"><br>
		</td>
	</tr>
	
	<!-- 팔로워 수를 가져올 수 있다.
	 SELECT COUNT(*) FROM follow WHERE follower = 2 -->
	
	<tr height="40"><td></td>
		<td><input type="submit" value="가입" onclick="return inCheck()" id="submit" disabled>&nbsp;&nbsp;
			<input type="reset" value="취소">&nbsp;&nbsp;
			<span id="axjoin" class="textLink">AxJoin</span>
		</td></tr>	
		
</table>
</form>
<c:if test="${not empty message}">
<br>=> ${message}<br><br> 
</c:if>
<hr>
<a href="home">[Home]</a>
</body>
</html>