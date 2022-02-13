<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품세부</title>
<link rel="stylesheet" href="../resources/lib/productDetail.css">
<script 
	src="https://code.jquery.com/jquery-3.2.1.min.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
	<script src="https://cdn.ckeditor.com/ckeditor5/32.0.0/classic/ckeditor.js"></script>	
</head>
<body>
					<div class="admin_content_wrap">
						 <div class="admin_content_subject"><span>상품등록</span><div>
						 <div class="admin_content_main">

	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>상품 이름</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<input name="product_name">
	    
	                    			</div>
	                    		</div>
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>판매자</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<input id="seller_name_input" readonly="readonly">
										<input id="seller_id_input" name="seller_id" type="hidden">
					
										
	                    			</div>
	                    		</div>                       
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>제조일</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<input name="product_date" autocomplete="off" readonly="readonly">
	                    				
	                    			</div>
	                    		</div>            
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>제조사</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<input name="company_name">
	                    				
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
										
	                    			</div>
	                    		</div>          
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>상품 가격</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<input name="product_price" value="0">
	                    				
	                    			</div>
	                    		</div>               
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>상품 재고</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<input name="product_stock" value="0">
	                    				
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
										
	                    			</div>
	                    		</div>          		
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>상품 설명</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<textarea name="product_desc" id="product_desc_textarea"></textarea>
	                    				
	                    			</div>
	                    		</div>      
	                    		 
		                    	<div class="btn_section">
	                   				<button id="cancelBtn" class="btn">상품 목록</button>
		                    		<button id="updateBtn" class="btn update_btn">수정 </button>
	                    		</div>
	                    	</div> 
	                    	
	                    	<form id="moveForm" action="/admin/productManage" method="get" >
		 						<input type="hidden" name="currPage" value="${Criteria.currPage}">
								<input type="hidden" name="rowsPerPage" value="${Criteria.rowPerPage}">
								<input type="hidden" name="keyword" value="${Criteria.keyword}">
                			</form>
                    </div>  
   <script>
   
		$(document).ready(function(){
			
			/* 할인율 값 삽입 */
			let product_dc = '<c:out value="${productInfo.product_dc}"/>' * 100;
			$("#product_dc_interface").attr("value", product_dc);
		
	
		
			/* 제조일 가공 */
			let product_date = '${productInfo.product_date}';
			let length = product_date.indexOf(" ");
			
			product_date = product_date.substring(0, length);
			
			$("input[name='product_date']").attr("value", product_date);
			
			/* 상품 소개 */
			ClassicEditor
				.create(document.querySelector('#product_desc_textarea'))
				.then(editor => {
					console.log(editor);
					editor.isReadOnly = true;
				})
				.catch(error=>{
					console.error(error);
				});
			
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
				
			let targetProcate2 = '';
			let targetProcate3 = '${productInfo.product_catecode}';
			
			for(let i = 0; i < procate3Array.length; i++){
				if(targetProcate3 === procate3Array[i].product_cateCode){
					targetProcate3 = procate3Array[i];
				}
			}// for	
			
			for(let i = 0; i < procate3Array.length; i++){
				if(targetProcate3.cate_parent === procate3Array[i].cate_parent){
					procateSelect3.append("<option value='"+procate3Array[i].product_catecode+"'>" + procate3Array[i].cate_name + "</option>");
				}
			}
			
			$(".procate3 option").each(function(i,obj){
				if(targetProcate3.product_catecode === obj.value){
					$(obj).attr("selected", "selected");
				}
			
			});	
			
			for(let i = 0; i < procate2Array.length; i++){
				if(targetProcate3.cate_parent === procate2Array[i].product_catecode){
					targetProcate2 = procate2Array[i];	
				}
			}// for	
			
			for(let i = 0; i < procate2Array.length; i++){
				if(targetProcate2.cate_parent === procate2Array[i].cate_parent){
					procateSelect2.append("<option value='"+procate2Array[i].product_catecode+"'>" + procate2Array[i].cate_name + "</option>");
				}
			}		
			
			$(".procate2 option").each(function(i,obj){
				if(targetProcate2.product_catecode === obj.value){
					$(obj).attr("selected", "selected");
				}
			});	
			
			for(let i = 0; i < procate1Array.length; i++){
				procateSelect1.append("<option value='"+procate1Array[i].product_catecode+"'>" + procate1Array[i].cate_name + "</option>");
			}
			
			$(".procate1 option").each(function(i,obj){
				if(targetProcate2.cate_parent === obj.value){
					$(obj).attr("selected", "selected");
				}
			});	
			
			/* 목록 이동 버튼 */
			$("#cancelBtn").on("click", function(e){
				e.preventDefault();
				$("#moveForm").submit();	
			});	
			
			/* 수정 페이지 이동 */
			$("#updateBtn").on("click", function(e){
				e.preventDefault();
				let addInput = '<input type="hidden" name="product_id" value="${productInfo.product_id}">';
				$("#moveForm").append(addInput);
				$("#moveForm").attr("action", "/admin/producrtUpdate");
				$("#moveForm").submit();
			});	
			
			
		});		// $(document).ready
		
	</script>    
	             
</body>
</html>