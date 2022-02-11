<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0,
	user-scalable=no, maximum-scale=1.0,minimum-scale=1.0">
<title>징검다리 : 회원정보수정</title>
<script src="resources/lib/jquery-3.2.1.min.js"></script>
<script src="resources/lib/inCheck.js"></script>
<script>	 
	fChecks = [
		new FocusoutCheck(true,'name',nmCheck,'nMessage','이름을'),
		new FocusoutCheck(true,'birthday',bdCheck,'bMessage','생년월일을'),
		new FocusoutCheck(true,'address1',ad1Check,'a1Message','우편번호를'),
		new FocusoutCheck(true,'address2',ad2Check,'a2Message','주소를'),
		new FocusoutCheck(true,'address3',ad3Check,'a3Message','상세주소를'),
/* 		new FocusoutCheck(true,'email',em1Check,'emMessage','이메일을'),
		new FocusoutCheck(true,'email_tail',em2Check,'emMessage','이메일을'),
		new FocusoutCheck(true,'email_direct',em3Check,'emMessage','이메일을'), */
		new FocusoutCheck(true,'phone',phoCheck,'phMessage','전화번호를')
	];

	redbox = '3px solid red';
	original = '1px solid #ddd';

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

/* 	function em1Check() {
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
	} //email3 */

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
	
	function initial(){
		// 성별
		$('input[name="gender"]').each(function(){
			if($(this).val()=="${apple.gender}") $(this).prop('checked',true);
		});
		// 관심사
		$('#else_direct').hide();
 		$('#else').click(function(){
			if($('#else').prop("checked")) $('#else_direct').show();
			else $('#else_direct').hide();
		});
		if("${apple.interest}".indexOf("기타:")!=-1) $('#else_direct').show();
		else $('#else_direct').hide();
		$('input[type="checkbox"]').each(function(){
			if("${apple.interest}".indexOf( $(this).val() )!=-1) {
				$(this).prop('checked',true);
			}
			else $(this).prop('checked',false);
		});
		$('#else_direct').val( "${apple.interest}".substring("${apple.interest}".lastIndexOf(":")+1) );
		// 이메일
 		$('#email_direct').show();
 /*		$('#email_tail').change(function(){
			if($('#email_tail').val()=='direct') $('#email_direct').show();
			else $('#email_direct').hide();
		}); */
		$('#email').val( "${apple.email}".substring(0,"${apple.email}".indexOf("@")) );
		
/* 		$('#email_tail option[value="direct"]').prop('selected',true);  */
		
		$('#email_direct').val( "${apple.email}".substring("${apple.email}".indexOf("@")+1) );
	}

	$(function(){
		$('#myForm input[type="reset"]').click(function(){
			$('#name').val("${apple.name}");
			$('#birthday').val("${apple.birthday}");
			$('#address1').val("${apple.address1}");
			$('#address2').val("${apple.address2}");
			$('#address3').val("${apple.address3}");
			$('#extraAddress').val('');
			$('#phone').val("${apple.phone}");
			$('#sns').val("${apple.sns}");
			$('#else_direct').val("${apple.interest}".substring("${apple.interest}".indexOf("기타:")+1));
			$('.eMessage').html('');
			$('#profilef').val(null);
			$('input,select').css({border:original});
			$(".select_img").attr("src","${apple.profile}");
			initial();
			fChecks.forEach(function(fCheck){
				fCheck.bool=true;
			});
			window.scrollTo(0,0);
			return false;
		});
		
		initial();
		
		$('#pwUpdate').click(function(){
			$.ajax({
				type:'get',
				url:"pwmatchf?member_id="+$('#member_id').val(),
				success:function(resultPage) {
							let width = 300;
							let height = 260;
							$('.pwmodal').css({
								position:"fixed",
								top:0,
								left:0,
								width:"100%",
								height:"100%", 
								background:"rgba(0,0,0,0.5)",
								display:"block"
							});
							$('.pwmodal_content').css({
								position:"fixed",
								width:width,
								height:height,
								top:(window.innerHeight-height)/2,
								left:(window.innerWidth-width)/2,
								background:"white",
								display:"block",
								border:"0px solid gray",
								borderRadius:"5px 5px",
							});
							$('.pwmodal_content').html(resultPage);
							$('.pwmodal_content #password').focus();
						},
				error:function() {
							alert("~~ 서버오류!!! 잠시후 다시 하세요 ~~");
						}
			}); //ajax
			return false;
		}); //#pwUpdate_click	
		
 		$('.pwmodal').click(function(e){
			$('.pwmodal,.pwmodal_content').hide();
			e.stopPropagation();
		});
	});
	
</script>
<style>
	hr {
		width:100%;
	}
	.basic {
		width:100%;
		border-collapse:collapse;
		text-align:left;
		line-height:1.5;
		border-top:1px solid #ccc;
		border-bottom:1px solid #ccc;
		margin:20px auto;
	}
	.basic th {
		width:64px;
		padding:5px;
		font-weight:bold;
		vertical-align:top;
	}
	.basic td {
		width:280px;
		padding:10px;
		vertical-align:top;
	}
	.basic tr:nth-child(2n) {
		background:#efefef;
	}	
	.basic td span:not(.eMessage) {
		display: block;
		font-weight: bold;
		font-size: 20px;
		margin-bottom: 10px;
		margin-top: 10px;
	}
	.basic td input {
		padding: 5px 5px;
		width: 95%;
		border: 1px solid #ddd;
	}	
	.basic td input[type="radio"] {
		width:15px;margin:0 20px 0 0;
	}	
	.basic td input[type="checkbox"] {
		width:20px;margin:0
	}
	a {
		width:100px;
		text-decoration-line:none;
		font-weight:bold;
		margin:5px 0;
		border:0;
	}
	.center {
		text-align:center;
	}
	#email,
	#email_tail,
	#email_direct {
		width:25%;
	}
	#member_id,
	#pwUpdate,
	td input[type="submit"],
	td input[type="reset"] {
		width:46%;
	}
	#pwUpdate:hover,
	td input[type="submit"]:hover,
	td input[type="reset"]:hover {
		background:snow;
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
<div class="center">
	<h1>회원정보수정</h1>
<c:if test="${not empty message}">
=> ${message}<br>
<hr>
</c:if>
	<form action="mupdate" method="post" enctype="multipart/form-data" id="myForm">
		<table class="basic">
			<tr>
				<th><label for="member_id">I  D</label></th>
				<td>
					<input type="text" name="member_id" id="member_id" value='${apple.member_id}' size="20" readonly>
					<input type="button" value="비밀번호 수정" id="pwUpdate"><br>
				</td>
			</tr>
			<tr>
				<th><label for="name">이름</label></th>
				<td>
					<input type="text" name="name" id="name" value="${apple.name}" size="20"><br>
					<span id="nMessage" class="eMessage"></span>			
				</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<label for="man">남자</label>
					<input type="radio" name="gender" class="gender_radio" id="man" value="M">
					<label for="woman">여자</label>
					<input type="radio" name="gender" class="gender_radio" id="woman" value="F">
					<label for="neither">해당항목없음</label>
					<input type="radio" name="gender" class="gender_radio" id="neither" value="N">
				</td>
			</tr>
			<tr>
				<th><label for="birthday">생년월일</label></th>		
				<td>
					<input type="date" name="birthday" id="birthday" value="${apple.birthday}"><br>
					<span id="bMessage" class="eMessage"></span>				
				</td>
			</tr>
			<tr>
				<th>관심사</th>
				<td>
					<input type="hidden" value="${apple.interest}" name="interest">
					<label><input type="checkbox" name="check" value="IT/모바일">IT/모바일&nbsp;</label>
					<label><input type="checkbox" name="check" value="시사">&nbsp;시사&nbsp;</label>
					<label><input type="checkbox" name="check" value="스포츠">&nbsp;스포츠&nbsp;</label>
					<label><input type="checkbox" name="check" value="여행">여행&nbsp;</label><br>
					<label><input type="checkbox" name="check" value="자동차">&nbsp;자동차</label>
					<label><input type="checkbox" name="check" value="건강">&nbsp;건강&nbsp;</label>
					<label><input type="checkbox" name="check" value="패션/뷰티">&nbsp;패션/뷰티&nbsp;</label>
					<label><input type="checkbox" name="check" value="기타" id="else">&nbsp;기타</label>
					<input type="text" id="else_direct" class="direct" placeholder="기타 입력"><br>	
				</td>	
			</tr>
			<tr>
				<th><label for="address1">주소</label></th>
				<td><input type="text" name="address1" id="address1" value="${apple.address1}" style="width:50%" >
					<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" style="width:30%"><br>
					<span id="a1Message" class="eMessage"></span>
					<input type="text" name="address2" id="address2" value="${apple.address2}"><br>
					<span id="a2Message" class="eMessage"></span>
					<input type="text" name="address3" id="address3" value="${apple.address3}"><br>
					<span id="a3Message" class="eMessage"></span>
					<input type="text" name="extraAddress" id="extraAddress" value=""><br>
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
			                // 상세주소를 지운 후 커서를 상세주소 필드로 이동한다.
			                document.getElementById("address3").value = "";
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
				</td>
			</tr>								
			<tr>
				<th><label for="phone">전화번호</label></th>
				<td>
					<input type="text" name="phone" id="phone" value="${apple.phone}"><br>
					<span id="phMessage" class="eMessage"></span>
				</td>
			</tr>			
			<tr>
				<th><label for="email">이메일</label></th>
				<td>
					<input type="text" name="email" id="email" readonly>&nbsp;@&nbsp;
<%-- 					<select id="email_tail">
						<option value="">선택</option>
						<option value="naver.com">naver.com</option>
						<option value="daum.net">daum.net</option>
						<option value="gmail.com">gmail.com</option>
						<option value="nate.com">nate.com</option>
						<option value="direct">직접입력</option>
					</select> --%>
					<input type="text" name="email_direct" id="email_direct" class="direct" placeholder="직접입력" readonly><br>
					<span id="emMessage" class="eMessage"></span>		
				</td>
			</tr>
			<tr>
				<th><label for="sns">SNS</label></th>
				<td><input type="text" name="sns" id="sns" value="${apple.sns}"></td>
			</tr>
			<tr>
				<th>Image</th>
				<td>
					<img src="${apple.profile}" class="select_img" width="100" height="100"><br>
					<input type="hidden" name="profile" value="${apple.profile}"><br>
					<input type="file" name="profilef" id="profilef">
			<script>	  		
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
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<span id="finalMessage" class="eMessage"></span><br>
					<input type="submit" value="수정" onclick="return inCheck('수정')" id="submit">&nbsp;&nbsp;
					<input type="reset" value="입력 초기화">
				</td>
			</tr>
			<s:csrfInput/>
		</table>
	</form>	 
<a href="mwithdraw?member_id=${apple.member_id}">[회원탈퇴]</a>&nbsp;
<a href='javascript:history.go(-1)'>[이전으로]</a>&nbsp;&nbsp;<a href="home">[HOME]</a>
</div>
<div class="pwmodal"></div><div class="pwmodal_content"></div>
</body>
</html>