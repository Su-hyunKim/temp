<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>징검다리 : 상품등록</title>
<script src="resources/lib/pinCheck.js"></script>

<style>
	.pwrap { 
		display: flex;
	    flex-direction: column;
	    justify-content: center;
	    align-items: center;
	}
	#pmyForm {
		
	}
	/* .signup_table {
		margin: 0 auto;
	} */
</style>

<script>
// 1) 개별적 오류 확인을 위한 switch 변수 (전역)
  var piCheck=false;
  var puCheck=false;
  var dpnCheck=false;
  var ipnCheck=false;
  var pcCheck=false;
  var pnCheck=false;
  var ptCheck=false;
  var ppCheck=false;
  var pcyCheck=false;
  var prgCheck=false;
  var pmiCheck=false;
  var pstCheck=false; 
  var preCheck=false; 

// 2) 개별적 오류점검위한 focusout 이벤트 핸들러 : JQuery
  $(function() {
	  $('#pid').focus();
	  $('#pid').keydown(function(e){
		  // enter 누르면 다음 으로 이동
			if (e.which==20) {
				e.preventDefault(); 
				$('#pidDup').focus()
			}
	  }).focusout(function() {
		 	piCheck=pidCheck();
	  }); //pid_focusout
	  
	  $('#purl').focusout(function(){
			puCheck=purlCheck();		  
	  }); //purl_focusout
	  
	  $('#dpnum').focusout(function(){
			dpnCheck=dpnumCheck();		  
	  }); //dpnum_focusout
	  
	  $('#ipnum').focusout(function(){
			ipnCheck=ipnumCheck();		  
	  }); //ipnum_focusout
	  
	  $('#pcategory').focusout(function(){
			pcCheck=pcategoryCheck();		  
	  }); //pcategory_focusout
	  
	  $('#pname').focusout(function(){
			pnCheck=pnameCheck();		  
	  }); //pname_focusout
	  
	  $('#punit').focusout(function(){
			ptCheck=punitCheck();		  
	  }); //punit_focusout
	  
	  $('#pprice').focusout(function(){
			ppCheck=ppriceCheck();		  
	  }); //pprice_focusout
	  
	  $('#pcurrency').focusout(function(){
			pcyCheck=pcurrencyCheck();		  
	  }); //pcurrency_focusout
	  
	  $('#pregdate').focusout(function(){
			prgCheck=pregdateCheck();		  
	  }); //pregdate_focusout
	  
	  $('#pmid').focusout(function(){
			pmiCheck=pmidCheck();		  
	  }); //pmember_id_focusout
	  
	  $('#pstatus').focusout(function(){
			pstCheck=pstatusCheck();		  
	  }); //pstatus_focusout
	  
	  $('#premarks').focusout(function(){
			preCheck=premarksCheck();		  
	  }); //premarks_focusout
	  
  }); //ready


// 3) submit 여부를 판단 & 실행 : JS 의 function
  function pinCheck(){
	// 모든 항목에 오류 없음을 확인 : switch 변수
	if (piCheck==false) {
		$('#piMessage').html('~~ 상품 id 를 확인하세요 ~~');
	}
	if (puCheck==false) {
		$('#puMessage').html('~~ 상품사진 을 확인하세요 ~~');
	}	
	if (dpnCheck==false) {
		$('#dpnMessage').html('~~ 상품상세번호 를 확인하세요 ~~');
	}	
	if (ipnCheck==false) {
		$('#ipnMessage').html('~~ 상품식별번호 를 확인하세요 ~~');
	}
	if (pnCheck==false) {
		$('#pnMessage').html('~~ 상품명 을 확인하세요 ~~');
	}	
	if (ptCheck==false) {
		$('#ptMessage').html('~~ 상품수량 을 확인하세요 ~~');
	}	
	if (ppCheck==false) {
		$('#ppMessage').html('~~ 상품가격 을 확인하세요 ~~');
	}	
	if (pcyCheck==false) {
		$('#pcyMessage').html('~~ 통화 를 선택하세요 ~~');
	}
	if (prgCheck==false) {
		$('#prgMessage').html('~~ 상품제조일 을 확인하세요 ~~');
	}	
	if (pmiCheck==false) {
		$('#pmiMessage').html('~~ 판매자 를 확인하세요 ~~');
	}		
	if (preCheck==false) {
		$('#preMessage').html('~~ 상품설명 를 확인하세요 ~~');
	}	
	
	
	// 모든 오류 확인완료 
	// => 없으면 submit : return true , 
	//    있으면 submit 을 취소 : return false 
	if ( piCheck && puCheck && dpnCheck &&
		 ipnCheck && pcCheck && pnCheck &&
		 ptCheck && ppCheck && pcyCheck &&
		 prgCheck && pmiCheck && pstCheck &&
		 preCheck
			) {
		// => submit : 404
		if (confirm("~~ 상품을 등록하시겠습니까 ? (Yes:확인 / No:취소)")==false) {   
		 	  alert('~~ 등록이 취소 되었습니다 ~~');
		 	  return false;
		}else return true; // submit 진행 -> server의 join  
	} else return false; 
  } //pinCheck

  //** ID 중복 확인하기
  function pidDupCheck() {
	// pid 의 입력값 무결성 점검 확인
	if (piCheck==false) {
		piCheck=pidCheck();
	}else { 
		// pid 중복확인
		// => pid를 서버로 보내 중복확인, 결과 처리 
		// => window.open(url,'','')
		//    url 요청을 서버로 전달(request) 하고, 그결과(response)를 Open 해줌
		var url="pidcheck?pid="+$('#pid').val(); 
		window.open(url,'_blank',
				'toolbar=no,menubar=yes,scrollbars=yes,resizable=yes,width=400,height=300');
	}  
  } //pidDupCheck
  
</script>

</head>
<body>
<div class="pwrap">
	<h2>징검다리 상품등록</h2>
	
	<form action="regist" method="post" enctype="multipart/form-data" id="pmyForm">
	<style>
		@font-face {
		    font-family: 'KyoboHandwriting2020A';
		    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2112@1.0/KyoboHandwriting2020A.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}
		@font-face {
		    font-family: 'KOTRAHOPE';
		    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2110@1.0/KOTRAHOPE.woff2') format('woff2');
		    font-weight: normal;
		    font-style: normal;
		}
		* {
			font-family: "KOTRAHOPE";
		}
		.input_div {
			
		}
		.input_div span {
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
		
	</style>
	<div class="input_div">
		<label for="pid">
			<span>상품 아이디</span>
			<input type="text" name="product_id" id="product_id" value="productid" size="20" style="width:61%">&nbsp;
			<input type="button" value="상품ID중복확인" id="pidDup" onclick="pidDupCheck()"style="width:35%"><br>
			<span id="piMessage" class="peMessage"></span>
		</label>
	</div>
	
	<div class="input_div">
		<label for="purl">
			<span>상품 사진</span>
			<input type="file" name="product_url2" id="product_url2"><br>
			<span id="puMessage" class="peMessage"></span>
		</label>
	</div>
	
	<div class="input_div">
		<label for="dpnum">
			<span>세부상품번호</span>
			<input type="text" name="detprod_num" id="detprod_num"  size="20"><br>
			<span id="dpnMessage" class="peMessage"></span>
		</label>
	</div>
	
	<div class="input_div">
		<label for="ipnum">
			<span>상품식별번호</span>
			<input type="text" name="idtprod_num" id="idtprod_num"  size="20"><br>
			<span id="ipnMessage" class="peMessage"></span>
		</label>
	</div>
	
	<div class="input_div">
		<span>카테고리</span>
			<label for="의류">의류</label>
			<input type="radio" name="category" class="category_radio" id="cloth" value="C">
			<label for="식품">식품</label>
			<input type="radio" name="category" class="category_radio" id="eats" value="E">
			<label for="생활용품">생활용품</label>
			<input type="radio" name="category" class="category_radio" id="need" value="N">
			<label for="가구">가구</label>
			<input type="radio" name="category" class="category_radio" id="furniture" value="F">
			<label for="기타">기타</label>
			<input type="radio" name="category" class="category_radio" id="etc" value="ET">
	</div>
	
	<div class="input_div">
		<label for="pname">
			<span>상품명</span>
			<input type="text" name="name" id="name" value="productname" size="20"><br>
			<span id="pnMessage" class="peMessage"></span>
		</label>
	</div>
	
	<div class="input_div">
		<label for="punit">
			<span>상품수량</span>
			<input type="text" name="unit" id="unit" value="productunit" size="20"><br>
			<span id="ptMessage" class="peMessage"></span>
		</label>
	</div>
	
	<div class="input_div">
		<label for="pprice">
			<span>상품가격</span>
			<input type="text" name="price" id="price" value="price" size="20"><br>
			<span id="ppMessage" class="peMessage"></span>
		</label>
	</div>
	
	<div class="input_div">
		<span>통화</span>
			<label for="원">원</label>
			<input type="radio" name="currency" class="currency_radio" id="won" value="W">
			<label for="달러">달러</label>
			<input type="radio" name="currency" class="currency_radio" id="dollar" value="D">
			<label for="엔">엔</label>
			<input type="radio" name="currency" class="currency_radio" id="yen" value="Y">
			<label for="유로">유로</label>
			<input type="radio" name="currency" class="currency_radio" id="euro" value="E">
			
	</div>
	
	<div class="input_div">
		<label for="pregdate">
			<span>상품제조일</span>
			<input type="date" name="regdate" id="regdate" size="20"><br>
			<span id="preMessage" class="peMessage"></span>
		</label>
	</div>
	
	<div class="input_div">
		<label for="pmid">
			<span>판매자</span>
			<input type="text" name="member_id" id="member_id" value="product member id" size="20"><br>
			<span id="pmidMessage" class="peMessage"></span>
		</label>
	</div>
	
	<div class="input_div">
		<span>상품상태</span>
			<label for="매우 양호">매우양호</label>
			<input type="radio" name="status" class="pstatus_radio" id="excelent" value="EC">
			<label for="양호">양호</label>
			<input type="radio" name="status" class="pstatus_radio" id="good" value="G">
			<label for="불량">불량</label>
			<input type="radio" name="status" class="pstatus_radio" id="bad" value="B">
			<label for="매우 불량">매우불량</label>
			<input type="radio" name="status" class="pstatus_radio" id="terrible" value="T">
			
	</div>
	
	<div class="input_div">
		<label for="premarks">
			<span>상품설명</span>
			<textarea id="remarks" name="remarks" placeholder="note"></textarea>
		</label>
	</div>	
	
	<!-- <div class="input_div">
		<label>
			<span>주소지</span>
				<input type="text" id="sample2_postcode" placeholder="우편번호" style="width:61%">
				<input type="button" onclick="sample2_execDaumPostcode()" value="우편번호 찾기" style="width:30%"><br>
				<input type="text" id="sample2_address" placeholder="주소"><br>
				<input type="text" id="sample2_detailAddress" placeholder="상세주소">
				<input type="text" id="sample2_extraAddress" placeholder="참고항목">
				
				iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요
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
		</label>
	</div> -->

	<div class="input_div">
		<input type="submit" value="등록" onclick="return pinCheck()" id="submit" style="width:46%" disabled>&nbsp;&nbsp;
		<input type="reset" value="취소" style="width:46%">&nbsp;&nbsp;
		<span id="axregist" class="textLink">AxRegist</span>
	</div>	
	</form>
	<c:if test="${not empty message}">
	<br>=> ${message}<br><br> 
	</c:if>
	<hr>
	<a href="home">[Home]</a>
</div> <!-- pwrap -end- -->
</body>
</html>