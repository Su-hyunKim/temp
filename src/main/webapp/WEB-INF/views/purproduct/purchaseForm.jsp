<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>징검다리 : 주문하기</title>
<script src="resources/lib/poCheck.js"></script>
<script src="resources/lib/inCheck.js"></script>
<script>
	$(function(){
		$('#idDup').click(function(e){
			if (!poChecks[0].bool) {
				if(poChecks[0].func()) pfChecks[0].bool=true;
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
								modal(300,350);
								$('.modal_content').html(resultPage);	
							},
					error:function() {
								alert("~~ 서버오류!!! 잠시후 다시 하세요 ~~");
							}
				}); //ajax
			}
			e.stopPropagation();
		}); //click
	});//ready
	 
	let poChecks = [
		new FocusoutCheck(false,'addressee',adrCheck,'adMessage','받는분을'),
		new FocusoutCheck(false,'member_id',idCheck,'iMessage','아이디를'),
		new FocusoutCheck(false,'adress1',ad1Check,'a1Message','우편번호를'),
		new FocusoutCheck(false,'adress2',ad2Check,'a2Message','주소를'),
		new FocusoutCheck(false,'adress3',ad3Check,'a3Message','상세주소를'),
		new FocusoutCheck(false,'point',pointCheck,'pntMessage','포인트를')
	];

	let redbox = '3px solid red';
	let original = '1px solid #ddd';
	
	function adrCheck() {
		let addressee=$('#addressee').val(); 	
		if (addressee.length<2) {
			$('#adMessage').html('~~ 받는분 이름은 2자 이상 입니다 ~~');
			return false;
		}else if ( addressee.replace(/[a-z.가-힣]/gi ,'').length > 0 ) {
			$('#adMessage').html('~~ 받는분 이름은 한글 영어로만 입력 하세요 ~~');
			return false;
		}else {
			$('#adMessage').html('');
			return true;
		}
	} //addressee
	
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
	} //member_id

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
	
	function pntCheck() {
		let usePoint=$('#usePoint').val()
		if (usePoint<1000) {
			$('#pntMessage').html('~~ 포인트는 1000초코 이상부터 사용가능 합니다 ~~');
			return false;
		}else if ( detprod_num.replace(/[0-9]/gi ,'').length > 0 ) {
			$('#pntMessage').html('~~ 포인트는 숫자로만 입력 하세요');
			return false;
		}else {
			$('#pntMessage').html('');
			return true;
		}
	} //usePoint

</script>

</head>
<body>
<br>
<hr>
<br>
<div class="powrapped">
	<h1>상품등록</h1>
	
	<form action="purchase" method="get" enctype="multipart/form-data" id="poForm" onsubmit="return pocheck('구매');">
	<style>
		.input_div{width:280px}
		.input_div span:not(.Message) {
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
		
		.input_div input[type="submit"],.input_div input[type="reset"]{width:46%;}
		.input_div input[type="checkbox"]{width:20px;margin:0}
		
		.powrapped{
		}
		
		#poForm {
		}
	</style>
	<div class="input_div">
		<label for="purchase_id">
			<span>*구매 I D</span>
		</label>
	</div>
	
	<div class="input_div">
		<label for="addressee">
			<span>*구매자</span>
			<input type="text" name="addressee" placeholder="구매자 이름을 써주세요">&nbsp;
			<input type="button" value="입력" id="adrs" style="width:20%"><br>
			<span id="adMessage" class="poMessage"></span>
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
		<label for="usePoint">
			<span>*포인트 사용여부</span>
			<label for="yes">사용</label>
				<input type="radio" name="ox" class="ox_radio" id="yes" value="Y"><br>
				<input type="hidden" name="usePoint" id="usePoint"placeholder="사용할 포인트를 입력하세요">
				<span id="adMessage" class="poMessage"></span>
			
			<label for="no">사용안함</label>
				<input type="radio" name="ox" class="ox_radio" id="no" value="N">	
		</label>
	</div>
	
	
	
	</form>
</div>

</body>
</html>