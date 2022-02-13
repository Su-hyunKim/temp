<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c " %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품관리</title>
<link rel="stylesheet" href="../resources/lib/pregist.css">
<link rel="stylesheet" href="../resources/lib/productManage.css">

<script 
	src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
</head>
<body>
				<div class="admin_content_wrap">
					<div class="admin_content_subject"><span>상품관리</span></div>
					  <div class="product_table_wrap">
	                   	<!-- 상품 리스트 O -->
	                    <c:if test="${listcheck != 'empty'}">
	                    	<table class="product_table">
	                    		<thead>
	                    			<tr>
										<td class="th_column_1">상품 번호</td>
	                    				<td class="th_column_2">상품 이름</td>
	                    				<td class="th_column_3">판매자 이름</td>
	                    				<td class="th_column_4">카테고리</td>
	                    				<td class="th_column_5">재고</td>
	                    				<td class="th_column_6">등록날짜</td>
	                    			</tr>
	                    		</thead>	
	                    		<c:forEach items="${list}" var="list">
	                    		<tr>
	                    			<td><c:out value="${list.product_id}"></c:out></td>
	                    			<td><a class="move" href='<c:out value="${list.product_id}"/>'>
											<c:out value="${list.product_name}"></c:out>
										</a>	
									</td>
	                    			<td><c:out value="${list.seller_name}"></c:out></td>
	                    			<td><c:out value="${list.cate_name}"></c:out></td>
	                    			<td><c:out value="${list.product_stock}"></c:out></td>
	                    			<td><fmt:formatDate value="${list.product_regdate}" pattern="yyyy-MM-dd"/></td>
	                    		</tr>
	                    		</c:forEach>
	                    	</table>
	                    </c:if>
	                    <!-- 상품 리스트 X -->
	               		<c:if test="${listCheck == 'empty'}">
	               			<div class="table_empty">
	               				등록된 판매자가 없습니다.
	               			</div>
	               		</c:if> 
	               	</div>
	               	
	               	<!-- 검색 영역 -->
	               	<div class="search_wrap">
	               		<form id="searchForm" action="/admin/productManage" method="get">
	               			<div class="search_input">
	                   			<input type="text" name="keyword" value='<c:out value="${MultiCheckSearchCriteria.keyword}"></c:out>'>
	                   			<input type="hidden" name="currPage" value='<c:out value="${Criteria.currPage}"></c:out>'>
	                   			<input type="hidden" name="rowsPerPage" value='${Criteria.rowsPerPage}'>
	                   			<input type="hidden" name="type" value="G">
	                   			<button class='btn search_btn'>검 색</button>                				
	               			</div>
	               		</form>
	               	</div>
	               	
	               	<!-- 페이지 이름 인터페이스 영역 -->
	               	<div class="PageMaker_wrap">
	               		<ul class="PageMaker">
	               			
	               			<!-- 이전 버튼 -->
	               			<c:if test="${PageMaker.prev }">
	               				<li class="PageMaker_btn prev">
	               					<a href="${PageMaker.spageNo -1}">이전</a>
	               				</li>
	               			</c:if>
	               			
	               			<!-- 페이지 번호 -->
	               			<c:forEach begin="${PageMaker.spageNo }" end="${PageMaker.epageNo }" var="num">
	               				<li class="PageMaker_btn ${Criteria.currPage == num ? 'active':''}">
	               					<a href="${num}">${num}</a>
	               				</li>	
	               			</c:forEach>
	               		
	                    	<!-- 다음 버튼 -->
	                    	<c:if test="${PageMaker.next}">
	                    		<li class="PageMaker_btn next">
	                    			<a href="${PageMaker.epageNo + 1 }">다음</a>
	                    		</li>
	                    	</c:if>
	                    </ul>
	               	</div>
	               	
	               	<form id="moveForm" action="/admin/productManage" method="get" >
							<input type="hidden" name="currPage" value="${Criteria.currPage}">
						<input type="hidden" name="rowsPerPage" value="${Criteria.rowsPerPage}">
						<input type="hidden" name="keyword" value="${MultiCheckSearchCriteria.keyword}">
	               	</form>
				</div>	

<script>
$(document).ready(function(){
	
	// 등록 성공 이벤트
	let rResult = '<c:out value="${regist_result}"/>';
	
	checkResult(rResult);
	
	function checkResult(result){
		
		if(result === 'currPage'){
			return;
		}
		
		alert("상품'"+ rResult +"'을 등록하였습니다.");
		
	}
	
	/* 수정 성공 이벤트 */
	let update_result = '${update_result}';
	
	if(update_result == 1){
		alert("수정 완료");
	}	
	
	/* 삭제 결과 경고창 */
	let delete_result = '${delete_result}';
	
	if(delete_result == 1){
		alert("삭제 완료");
	}


});

let searchForm = $('#searchForm');
let moveForm = $('#moveForm');

/* 작거 검색 버튼 동작 */
$("#searchForm button").on("click", function(e){
	
	e.preventDefault();
	
	/* 검색 키워드 유효성 검사 */
	if(!searchForm.find("input[name='keyword']").val()){
		alert("키워드를 입력하십시오");
		return false;
	}
	
	searchForm.find("input[name='currPage']").val("1");
	
	searchForm.submit();
	
});


/* 페이지 이동 버튼 */
$(".PageMaker_btn a").on("click", function(e){
	
	e.preventDefault();
	
	moveForm.find("input[name='currPage']").val($(this).attr("href"));
	
	moveForm.submit();
	
});

/* 상품 조회 페이지 */
$(".move").on("click", function(e){
	
	e.preventDefault();
	
	moveForm.append("<input type='hidden' name='product_id' value='"+$(this).attr("href") + "'>");
	moveForm.attr("action", "/admin/productDetail");
	moveForm.submit();
	
	
});
</script>
</body>
</html>