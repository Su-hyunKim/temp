<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>징검다리 : 회원가입</title>
<script src="resources/lib/inCheck.js"></script>
<script>
	$(function(){
		$('#idDup').click(function(e){
			if (!fChecks[0].bool) {
				if(fChecks[0].func()) fChecks[0].bool=true;
				else $('#member_id').css({border:redbox});
			}else {
				$.ajax({
					type:'get',
					url:"midcheck?member_id="+$('#member_id').val(),
					success:function(resultPage) {
								let body = resultPage.substring(resultPage.lastIndexOf('<body>')+6,
									resultPage.lastIndexOf('</body>'));
								if(body.indexOf('<img src="resources/image/logo.png"')!=-1)
									resultPage = body.substring(body.indexOf('<img src="resources/image/logo.png"'),
										body.indexOf('<div class="modal">'));
								modal(300,260);
								$('.modal_content').html(resultPage);
								$('.modal_content #idOK').focus();
							},
					error:function() {
								alert("~~ 서버오류!!! 잠시후 다시 하세요 ~~");
							}
				}); //ajax
			}
			e.stopPropagation();
		}); //click	
		
		$('#myForm input[type="reset"]').click(function(){
			$('#myForm #idDup').prop('disabled',false);
			$('#myForm #submit').prop('disabled',true);	
			$('#myForm #member_id').prop('readonly',false);
			$('#myForm .eMessage').html('');
			$('#myForm input,#myForm select').css({border:original});
			$(".select_img").attr("src","resources/uploadImage/basicman.png");
			$('#myForm .direct').hide();
			window.scrollTo(0,0);
		});
	});//ready
	 
	fChecks = [
		new FocusoutCheck(false,'member_id',idCheck,'iMessage','아이디를'),
		new FocusoutCheck(false,'password',pwCheck,'pMessage','비밀번호를'),
		new FocusoutCheck(false,'name',nmCheck,'nMessage','이름을'),
		new FocusoutCheck(false,'birthday',bdCheck,'bMessage','생년월일을'),
		new FocusoutCheck(false,'address1',ad1Check,'a1Message','우편번호를'),
		new FocusoutCheck(false,'address2',ad2Check,'a2Message','주소를'),
		new FocusoutCheck(false,'address3',ad3Check,'a3Message','상세주소를'),
		new FocusoutCheck(false,'email',em1Check,'emMessage','이메일을'),
		new FocusoutCheck(false,'email_tail',em2Check,'emMessage','이메일을'),
		new FocusoutCheck(true,'email_direct',em3Check,'emMessage','이메일을'),
		new FocusoutCheck(false,'phone',phoCheck,'phMessage','전화번호를')
	];

	redbox = '3px solid red';
	original = '1px solid #ddd';
	
	function idCheck() {
		let id=$('#member_id').val(); 	
		if (id.length<4) {
			$('#iMessage').html('~~ id 는 4자 이상 입니다 ~~');
			return false;
		}else if ( id.replace(/[a-z.0-9]/gi ,'').length > 0 ) {
			$('#iMessage').html('~~ id 는 영문자, 숫자로만 입력 하세요 ~~');
			return false;
		}else {
			$('#iMessage').html('');
			return true;
		}
	} //idCheck

	function pwCheck() {
		let password=$('#password').val()
		if (password.length<8) {
			$('#pMessage').html('~~ password 는 8자 이상 입니다 ~~');
			return false;
		}else if ( password.replace(/[!-*.@]/gi,'').length >= password.length ) {
			$('#pMessage').html('~~ password 는 특수문자가 반드시 1개 이상 포함되어야 합니다 ~~');
			return false;
		}else if ( password.replace(/[a-z.0-9.!-*.@]/gi ,'').length > 0 ) {
			$('#pMessage').html('password 는 영문자, 숫자, 특수문자 로만 입력 하세요');
			return false;
		}else {
			$('#pMessage').html('');
			return true;
		}
	} //password

	function nmCheck() {
		let name=$('#name').val();
		if (name.length<2) {
			$('#nMessage').html(' ~~ 이름은 2자 이상 입니다 ~~');
			return false;
		}else if (name.replace(/[a-z.가-힣]/gi,'').length > 0) {
			$('#nMessage').html(' ~~ 이름은 한글 또는 영문 으로만 입력 하세요 ~~');
			return false;
		}else {
			$('#nMessage').html('');
			return true;
		}	
	} //name

	function bdCheck() {
		let birthday=$('#birthday').val();
		if (birthday.length != 10) {
			$('#bMessage').html(' ~~ 생년월일을 정확하게 입력 하세요 (yyyy-mm-dd) ~~');
			return false;
		}else {
			$('#bMessage').html('');
			return true;
		}	
	} //birthday

	function ad1Check() {
		let address1=$('#address1').val();
		if (address1.length<5) {
			$('#a1Message').html(' ~~ 우편번호를 입력해주세요 ~~ ');
			return false;
		}else if ( $.isNumeric(address1)==false || address1.replace(/[.]/g,'').length < address1.length) {
			$('#a1Message').html(' ~~ 우편번호는 숫자로만 정확하게 입력 하세요 ~~ ');
			return false;
		}else {
			$('#a1Message').html('');
			return true;
		}
	} //address1

	function ad2Check() {
		if ($('#address2').val()=='') {
			$('#a2Message').html(' ~~ 주소를 입력해주세요 ~~ ');
			return false;
		}else {
			$('#a2Message').html('');
			return true;
		}
	} //address2

	function ad3Check() {
		if ($('#address3').val()=='') {
			$('#a3Message').html(' ~~ 상세주소를 입력해주세요 ~~ ');
			return false;
		}else {
			$('#a3Message').html('');
			return true;
		}
	} //address3

	function em1Check() {
		if ($('#email').val()=='') {
			$('#emMessage').html(' ~~ 이메일 계정을 입력해주세요 ~~ ');
			return false;
		}else {
			$('#emMessage').html('');
			$('#email_tail').focus();
			return true;
		}
	} //email1
	
	function em2Check() {
		if ($('#email_tail').val()=='') {
			$('#emMessage').html(' ~~ 이메일 주소 뒷자리를 선택해주세요 ~~ ');
			return false;
		}else {
			$('#emMessage').html('');
			return true;
		}
	} //email2
	
	function em3Check() {
		if($('#email_tail').val()=='direct' && !($('#email_direct').val().includes('.'))){
			$('#emMessage').html(' ~~ 직접입력란을 완성해주세요 ~~ ');
			return false;
		}else {
			$('#emMessage').html('');
			return true;
		}
	} //email3

	function phoCheck() {
		let phone=$('#phone').val();
		if (phone.length<10) {
			$('#phMessage').html(' ~~ 전화번호를 입력해주세요 ~~ ');
			return false;
		}else if ( $.isNumeric(phone)==false || phone.replace(/[.]/g,'').length < phone.length) {
			$('#phMessage').html(' ~~ 전화번호는 숫자로만 입력해주세요 ~~ ');
			return false;
		}else {
			$('#phMessage').html('');
			return true;
		}
	} //phone
</script>
<style>
		.input_div {
			width:280px
		}
		.input_div span:not(.eMessage) {
			display: block;
			font-weight: bold;
			font-size: 20px;
			margin-bottom: 10px;
			margin-top: 10px;
		}
		.input_div input {
			padding: 7px 8px;
			width: 100%;
			border: 1px solid #ddd;
		}
		#email,#email_tail,
		#email_direct {
			width:30%;
		}
		.input_div input[type="submit"],
		.input_div input[type="reset"] {
			width:46%;
		}
		.input_div input[type="submit"]:hover,
		.input_div input[type="reset"]:hover,
		#idDup:hover {
			background:snow;
		}
		.input_div input[type="radio"] {
			width:20px;margin:0 20px 0 0;
		}	
		.input_div input[type="checkbox"] {
			width:20px;margin:0
		}
		#email_direct,
		#else_direct {
			display:none;
		}
		.eMessage {
			padding:0;
			border:0;
			margin:0px;
			color:red;
			font-style:italic;
			font-family:굴림;
			font-size:12px;
	}
</style>
</head>
<body>
<div class="wrapped">
	<h1>징검다리 회원가입</h1>
	<!-- <pre><h3>
	=> FileUpLoad TestForm
	=> form 과 table Tag 사용시 주의사항 : form 내부에 table 사용해야함
	   -> form 단위작업시 인식안됨
	   -> JQ 의 serialize, FormData 의 append all 등
	</h3></pre>
	 -->
 	<form action="join" method="post" enctype="multipart/form-data" id="myForm">

	<div class="input_div">
		<label for="member_id">
			<span>*아이디</span>
			<input type="text" name="member_id" id="member_id" placeholder="4자 이상 영문 또는 숫자" size="20" style="width:61%">&nbsp;
			<input type="button" value="ID중복확인" id="idDup" style="width:30%"><br>
			<span id="iMessage" class="eMessage"></span>
		</label>
	</div>

	<div class="input_div">
		<label for="password">
			<span>*비밀번호</span>
			<s:csrfInput />	
			<input type="password" name="password" id="password" placeholder="8자 이상 특수문자(1자 이상 반드시 포함), 영문, 숫자" size="20"><br>
			<span id="pMessage" class="eMessage"></span>
		</label>
	</div>
	
 	<div class="input_div">
		<span>프로필 사진</span>
		<img src="resources/uploadImage/basicman.png" class="select_img" width="100" height="100"><br>
		<input type="file" name="profilef" id="profilef">
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
  		
			$('#profilef').change(function(){
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
	</div>
	
	<div class="input_div">
		<label for="name">
			<span>*이름</span>
			<input type="text" name="name" id="name" placeholder="2자 이상 한글 또는 영문" size="20"><br>
			<span id="nMessage" class="eMessage"></span>
		</label>
	</div>
	
	<div class="input_div">
		<span>*성별</span>
			<label for="man">남자</label>
			<input type="radio" name="gender" class="gender_radio" id="man" value="M">
			<label for="woman">여자</label>
			<input type="radio" name="gender" class="gender_radio" id="woman" value="F">
			<label for="neither">해당항목없음</label>
			<input type="radio" name="gender" class="gender_radio" id="neither" value="N" checked>
	</div>
	
	<div class="input_div">
		<label for="birthday">
			<span>*생년월일</span>
			<input type="date" name="birthday" id="birthday"><br>
			<span id="bMessage" class="eMessage"></span>
		</label>
	</div>	
	
	<div class="input_div">
		<label>
			<span>*주소</span>
			<input type="text" name="address1" id="address1" placeholder="우편번호" style="width:61%">
			<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" style="width:30%"><br>
			<span id="a1Message" class="eMessage"></span>
			<input type="text" name="address2" id="address2" placeholder="주소"><br>
			<span id="a2Message" class="eMessage"></span>
			<input type="text" name="address3" id="address3" placeholder="상세주소"><br>
			<span id="a3Message" class="eMessage"></span>
			<input type="text" name="extraAddress" id="extraAddress" placeholder="참고항목"><br>
				
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
			
			    function execDaumPostcode() {
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
			                    document.getElementById("extraAddress").value = extraAddr;			                
			                } else {
			                    document.getElementById("extraAddress").value = '';
			                }
			
			                // 우편번호와 주소 정보를 해당 필드에 넣는다.
			                document.getElementById("address1").value = data.zonecode;
			                document.getElementById("address2").value = addr;
			                // 커서를 상세주소 필드로 이동한다.
			                document.getElementById("address1").focus();
			                document.getElementById("address2").focus();
			                document.getElementById("address3").focus();
			
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
			        var borderWidth = 1; //샘플에서 사용하는 border의 두께
			
			        // 위에서 선언한 값들을 실제 element에 넣는다.
			        element_layer.style.padding = "0"
			        element_layer.style.width = width + 'px';
			        element_layer.style.height = height + 'px';
			        element_layer.style.border = borderWidth + 'px solid snow';
			        element_layer.style.borderRadius = "5px 5px";
			        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
			        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
			        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
			    }
			</script>
		</label>
	</div>
		
	<div class="input_div">
		<label for="email">
			<span>*이메일</span>
			<input type="text" name="email" id="email" placeholder="인증용 이메일">&nbsp;@&nbsp;
			<select id="email_tail">
				<option value="">선택</option>
				<option value="naver.com">naver.com</option>
				<option value="daum.net">daum.net</option>
				<option value="gmail.com">gmail.com</option>
				<option value="nate.com">nate.com</option>
				<option value="direct">직접입력</option>
			</select>
			<input type="text" name="email_direct" id="email_direct" class="direct" placeholder="직접입력"><br>
			<script>					
				$('#email_tail').change(function(){
					if($('#email_tail').val()=='direct') $('#email_direct').show();
					else $('#email_direct').hide();
				});
			</script>
			<span id="emMessage" class="eMessage"></span>
		</label>
	</div>
	
	<div class="input_div">
		<label for="phone">
			<span>*전화번호</span>
			<input type="text" name="phone" id="phone" placeholder='"-" 없이 번호만 입력해주세요'><br>
			<span id="phMessage" class="eMessage"></span>
		</label>
	</div>		
		
	<div class="input_div">
		<input type="hidden" value="" name="interest">
		<span>관심사</span>
		<label><input type="checkbox" name="check" value="IT/모바일">IT/모바일&nbsp;</label>
		<label><input type="checkbox" name="check" value="시사">&nbsp;시사&nbsp;</label>
		<label><input type="checkbox" name="check" value="스포츠">&nbsp;스포츠&nbsp;</label>
		<label><input type="checkbox" name="check" value="여행">여행&nbsp;</label><br>
		<label><input type="checkbox" name="check" value="자동차">&nbsp;자동차</label>
		<label><input type="checkbox" name="check" value="건강">&nbsp;건강&nbsp;</label>
		<label><input type="checkbox" name="check" value="패션/뷰티">&nbsp;패션/뷰티&nbsp;</label>
		<label><input type="checkbox" name="check" value="기타" id="else">&nbsp;기타</label>
		<input type="text" id="else_direct" class="direct" placeholder="기타 입력"><br>
		<script>
			$('#else').click(function(){
				if($('#else').prop("checked")) $('#else_direct').show();
				else $('#else_direct').hide();
			});
		</script>
	</div>	
	<div class="input_div">
		<label for="sns">
			<span>SNS</span>
			<input type="text" name="sns" id="sns" placeholder="SNS계정 url"><br><br>
		</label>
	</div>		

	<div class="input_div">
		<span id="finalMessage" class="eMessage"></span><br>
		<input type="submit" value="가입" onclick="return inCheck('가입')" id="submit" disabled>
		<input type="reset" value="입력 초기화">&nbsp;&nbsp;
	</div>
	<s:csrfInput/> 
	</form>
	<c:if test="${not empty message}">
	<br>=> ${message}<br><br> 
	</c:if>
</div> 
</body>
</html>