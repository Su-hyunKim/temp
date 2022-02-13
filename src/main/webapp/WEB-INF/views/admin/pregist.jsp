<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품등록</title>
<link rel="stylesheet" href="../resources/lib/pregist.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />

<script 
	src="https://code.jquery.com/jquery-3.2.1.min.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/32.0.0/classic/ckeditor.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
</head>
<body>
					<div class="admin_content_wrap">
						 <div class="admin_content_subject"><span>상품등록</span><div>
						 <div class="admin_content_main">
	                    	<form action="/admin/pregist" method="post" id="pregistForm">
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>상품 이름</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<input name="product_name">
	                    				<span class="ck_warn product_name_warn">상품명을 입력해주세요.</span>
	                    			</div>
	                    		</div>
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>판매자</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<input id="seller_name_input" readonly="readonly">
										<input id="seller_id_input" name="seller_id" type="hidden">
										<button class="seller_id_btn">작가 선택</button>
										<span class="ck_warn seller_id_warn">판매자를 선택해주세요</span>
	                    			</div>
	                    		</div>                       
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>제조일</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<input name="product_date" autocomplete="off" readonly="readonly">
	                    				<span class="ck_warn product_date_warn">상품 제조일을 선택해주세요.</span>
	                    			</div>
	                    		</div>            
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>제조사</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<input name="company_name">
	                    				<span class="ck_warn company_name_warn">제조사를 입력해주세요.</span>
	                    			</div>
	                    		</div>             
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>상품분류코드</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<div class="cate_wrap">
											<span>대분류</span>
											<select class="cate1">
												<option selected value="none">선택</option>
												<option value="100000">징PB</option>
												<option value="200000">Others</option>
											</select>
										</div>
										<div class="cate_wrap">
											<span>중분류</span>
											<select class="cate2">
												<option selected value="none">선택</option>
											</select>
										</div>
										<div class="cate_wrap">
											<span>소분류</span>
											<select class="cate3" name="cateCode">
												<option selected value="none">선택</option>
											</select>
										</div> 
										<span class="ck_warn product_catecode_warn">상품 카테고리를 선택해주세요.</span>
	                    			</div>
	                    		</div>          
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>상품 가격</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<input name="product_price" value="0">
	                    				<span class="ck_warn product_price_warn">상품 가격를 입력해주세요.</span>
	                    			</div>
	                    		</div>               
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>상품 재고</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<input name="product_stock" value="0">
	                    				<span class="ck_warn product_stock_warn">상품 재고를 입력해주세요.</span>
	                    			</div>
	                    		</div>          
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>상품 할인율</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<input id="product_dc_interface" maxlength="2" value="0">
	                    				<input name="product_dc" type="hidden" value="0">
										<span class="step_val">할인 가격 : <span class="span_product_dc"></span></span>
										<span class="ck_warn product_dc_warn">상품 할인율을 숫자로 입력해주세요.(1~99)</span>
	                    			</div>
	                    		</div>          		
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>상품 설명</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<textarea name="product_desc" id="product_desc_textarea"></textarea>
	                    				<span class="ck_warn product_price_warn">상품 소개를 입력해주세요.</span>
	                    			</div>
	                    		</div> 
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>상품 이미지</label>
	                    			</div>
	                    			<div class="form_section_content">
									<input type="file" multiple id ="fileItem" name='uploadFile' style="height: 30px;">	
	                    			</div>
                    			</div>         		
	                   		</form>
	                   			<div class="btn_section">
	                   				<button id="cancelBtn" class="btn">취 소</button>
		                    		<button id="pregistBtn" class="btn pregist_btn">등 록</button>
		                    	</div> 
	                    </div>  
	                    
<script>

	/* 상품등록버튼 */	
		
			let pregistForm = $("#pregistForm")
			
	$("#cancelBtn").click(function(){
	
		location.href="/admin/pregistManage"
	});
		
	/* 상품등록버튼 */		
			
	$("#pregistBtn").on("click",function(e){
		
		e.preventDefault();
		
		/* 체크 변수 */
		let product_nameCk = false;
		let seller_idCk = false;
		let product_dateCk = false;
		let company_nameCK = false;
		let product_catecodeCk = false;
		let product_priceCk = false;
		let product_stockCk = false;
		let product_dcCk = false;
		let product_descCk = false;
		
		/* 체크 대상 변수 */
		let product_name = $("input[name='product_name']").val();
		let seller_id = $("input[name='seller_id']").val();
		let product_date = $("input[name='product_date']").val();
		let company_name = $("input[name='company_name']").val();
		let product_catecode = $("input[name='product_catecode']").val();
		let product_price = $("select[name='product_price']").val();
		let product_stock = $("input[name='product_stock']").val();
		let product_dc = $("product_dc_interface").val();
		let product_desc = $(".bit p").html();
		
		if(product_name){
			$(".product_name_warn").css('display','none');
			product_nameCk = true;
		} else {
			$(".product_name_warn").css('display','block');
			product_nameCk = false;
		}
		
		if(seller_id){
			$(".seller_id_warn").css('display','none');
			seller_idCk = true;
		} else {
			$(".seller_id_warn").css('display','block');
			seller_idCk = false;
		}
		
		if(publeYear){
			$(".product_date_warn").css('display','none');
			product_dateCk = true;
		} else {
			$(".product_date_warn").css('display','block');
			product_dateCk = false;
		}	
		
		if(company_name){
			$(".company_name_warn").css('display','none');
			company_nameCk = true;
		} else {
			$(".company_name_warn").css('display','block');
			company_nameCk = false;
		}
		
		if(product_catecode != 'none'){
			$(".product_catecode_warn").css('display','none');
			product_catecodeCk = true;
		} else {
			$(".product_catecode_warn").css('display','block');
			product_catecodeCk = false;
		}	
		
		if(product_price != 0){
			$(".product_price_warn").css('display','none');
			product_priceCk = true;
		} else {
			$(".product_price_warn").css('display','block');
			product_priceCk = false;
		}	
		
		if(product_stock != 0){
			$(".product_stock_warn").css('display','none');
			product_stockCk = true;
		} else {
			$(".product_stock_warn").css('display','block');
			product_stockCk = false;
		}		
		
		if(!isNaN(product_dc)){
			$(".product_dc_warn").css('display','none');
			product_dcCk = true;
		} else {
			$(".product_dc_warn").css('display','block');
			product_dcCk = false;
		}	
		
		if(product_desc != '<br data-cke-filler="true">'){
			$(".product_desc_warn").css('display','none');
			product_descCk = true;
		} else {
			$(".product_desc_warn").css('display','block');
			product_descCk = false;
		}	
		
		if(product_nameCk && seller_idCk && product_dateCk && company_nameCk && product_catecodeCk && product_priceCk && product_stockCk && product_dcCk && product_descCk){
			//alert('통과');
			$("#pregistForm").submit();
		} else {
			return false;
		}
		
	});	
	

	/* 위지윅 적용 */

	/* 상품 소개 */
	ClassicEditor	
		.create(document.querySelector('#product_desc_textarea'))
		.catch(error=>{
			console.error(error);
		});
	
	/* 캘린터 위젯 적용 */
	
	/* 설정 */
	const config = {
		dateFormat: 'yy-mm-dd',
		showOn : "button",
		buttonText:"날짜 선택",
	    prevText: '이전 달',
	    nextText: '다음 달',
	    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    dayNames: ['일','월','화','수','목','금','토'],
	    dayNamesShort: ['일','월','화','수','목','금','토'],
	    dayNamesMin: ['일','월','화','수','목','금','토'],
	    yearSuffix: '년',
        changeMonth: true,
        changeYear: true
	}
	/* 캘린더 */
	$(function() {
	  $( "input[name='product_date']" ).datepicker(config);
	});
	
	/* 작가 선택 버튼 */
	$('.seller_id_btn').on("click",function(e){
		
		e.preventDefault();
		
		let popUrl = "/admin/sellerPop";
		let popOption = "width = 650px, height=550px, top=300px, left=300px, scrollbars=yes";
		
		window.open(popUrl,"판매자 찾기",popOption);	
		
	});
	
	/* 
	$(document).ready(function(){
		console.log('${procateList}');
	});
	*/
	
	/* 카테고리 */
	let procateList = JSON.parse('${procateList}');
	
	let procate1Array = new Array();
	let procate2Array = new Array();
	let procate3Array = new Array();
	let procate1Obj = new Object();
	let procate2Obj = new Object();
	let procate3Obj = new Object();
	
	let procateSelect1 = $(".cate1");		
	let procateSelect2 = $(".cate2");
	let procateSelect3 = $(".cate3");
	
	/* 카테고리 배열 초기화 메서드 */
	function makeProcateArray(obj,array,procateList, tier){
		for(let i = 0; i < procateList.length; i++){
			if(procateList[i].tier === tier){
				obj = new Object();
				
				obj.cate_name = procateList[i].cate_name;
				obj.product_catecode = procateList[i].product_catecode;
				obj.cate_parent = procateList[i].cate_parent;
				
				array.push(obj);				
				
			}
		}
	}
		
	/* 배열 초기화 */
	makeProcateArray(procate1Obj,procate1Array,procateList,1);
	makeProcateArray(procate2Obj,procate2Array,procateList,2);
	makeProcateArray(procate3Obj,procate3Array,procateList,3);
	
	/* 
	$(document).ready(function(){
		console.log(procate1Array);
		console.log(procate2Array);
		console.log(procate3Array);
	});
	*/
	
	/* 대분류 <option> */
	for(let i = 0; i < procate1Array.length; i++){
		procateSelect1.append("<option value='"+procate1Array[i].product_catecode+"'>" + procate1Array[i].cate_name + "</option>");
	}
	
	/* 중분류 <option> 태그 */
	$(procateSelect1).on("change",function(){
		
		let selectVal1 = $(this).find("option:selected").val();	
		
		procateSelect2.children().remove();
		procateSelect3.children().remove();
		
		procateSelect2.append("<option value='none'>선택</option>");
		procateSelect3.append("<option value='none'>선택</option>");
		
		for(let i = 0; i < procate2Array.length; i++){
			if(selectVal1 === procate2Array[i].cate_parent){
				procateSelect2.append("<option value='"+procate2Array[i].product_catecode+"'>" + procate2Array[i].cate_name + "</option>");	
			}
		}// for
		
	});
	
	/* 소분류 <option> */
	$(procateSelect2).on("change",function(){
		
		let selectVal2 = $(this).find("option:selected").val();
		
		procateSelect3.children().remove();
		
		procateSelect3.append("<option value='none'>선택</option>");		
		
		for(let i = 0; i < procate3Array.length; i++){
			if(selectVal2 === procate3Array[i].cate_parent){
				procateSelect3.append("<option value='"+procate3Array[i].product_catecode+"'>" + procate3Array[i].cate_name + "</option>");	
			}
		}// for		
		
	});	
	
	/* 할인율 Input 설정 */
	$("#product_dc_interface").on("propertychange change keyup paste input", function(){
		
		let userInput = $("#product_dc_interface");
		let product_dcInput = $("input[name='product_dc']");
		
		let product_dcRate = userInput.val();								// 사용자가 입력할 할인값
		let sendProduct_dcRate = product_dcRate / 100;						// 서버에 전송항 할인값
		let product_price = $("input[name='product_price']").val();			// 원가
		let product_dc_price = product_price * (1 - sendProduct_dcRate);	// 할인가격
		     
		if(!isNaN(product_dcRate)){
			$(".span_product_dc").html(product_dc_price);
			product_dcInput.val(sendProduct_dcRate);			
		}
		
		
	});	
 	
	$("input[name='product_price']").on("change", function(){
		
		let userInput = $("#product_dc_interface");
		let product_dcInput = $("input[name='product_dc']");
		
		let product_dcRate = userInput.val();					// 사용자가 입력한 할인값
		let sendproduct_dcRate = product_dcRate / 100;			// 서버에 전송할 할인값
		let product_price = $("input[name='product_price']").val();			// 원가
		let product_dc_price = product_price * (1 - sendProduct_dcRate);	// 할인가격
		
		if(!isNaN(product_dcRate)){
			$(".span_product_dc").html(product_dc_price);	
		}
	});
		
	/* 이미지 업로드 */
	$("input[type='file']").on("change", function(e){

		let formData = new FormData();
		let fileInput = $('input[name="uploadFile"]');
		let fileList = fileInput[0].files;
		let fileObj = fileList[0];
		
		if(!fileCheck(fileObj.name, fileObj.size)){
			return false;
		}
		
		for(let i = 0; i < fileList.length; i++){
			formData.append("uploadFile", fileList[i]);
		}
		
		$.ajax({
			url: '/admin/uploadAjaxAction',
	    	processData : false,
	    	contentType : false,
	    	data : formData,
	    	type : 'POST',
	    	dataType : 'json'
		});	
		
	});
	
	/* var, method related with attachFile */
	let regex = new RegExp("(.*?)\.(jpg|png)$");
	let maxSize = 1048576; //1MB	
	
	function fileCheck(fileName, fileSize){

		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
			  
		if(!regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		
		return true;		
		
	}
	
</script>

</body>
</html>