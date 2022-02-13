<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자 선택 pop</title>
<link rel="stylesheet" href="../resources/lib/sellerPop.css">
<script
  src="https://code.jquery.com/jquery-3.2.1.min.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
</head>
<body>
<h1>판매자 선택 pop 페이지</h1>
				<div class="subject_name_warp">
			<span>판매자 선택</span>
		</div>
		<div class="content_wrap">
               	<!-- 게시물 표 영역 -->
				<div class="seller_table_wrap">
               		<!-- 게시물 O -->
               		<c:if test="${listCheck != 'empty'}">
               			<div class="table_exist">
	                    	<table class="seller_table">
	                    		<thead>
	                    			<tr>
	                    				<td class="th_column_1">판매자 번호</td>
	                    				<td>
	                    					<a class="move" href='<c:out value="${list.seller_id}"/>' data-name='<c:out value="${list.seller_name}"/>'>
												<c:out value="${list.seller_nmae}"></c:out>
											</a>
										</td>
	                    			</tr>
	                    		</thead>
	                    		<c:forEach items="${list}" var="list">
	                    		<tr>
	                    			<td><c:out value="${list.seller_id}"></c:out> </td>
	                    			<td><c:out value="${list.seller_name}"></c:out></td>
	                    		</tr>
	                    		</c:forEach>
	                    	</table>
                    	</div>                			
               		</c:if>
               		<!-- 게시물 x -->
               		<c:if test="${listCheck == 'empty'}">
               			<div class="table_empty">
               				등록된 판매자가 없습니다.
               			</div>
               		</c:if>
               		
                    <!-- 검색 영역 -->
                    <div class="search_wrap">
                    	<form id="searchForm" action="/admin/sellerPop" method="get">
                    		<div class="search_input">
                    			<input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"></c:out>'>
                    			<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum }"></c:out>'>
                    			<input type="hidden" name="rowsPerPage" value='${pageMaker.cri.rowsPerPage}'>
                    			<button class='btn search_btn'>검 색</button>
                    		</div>
                    	</form>
                    </div>
                    
                    <!-- 페이지 이동 인터페이스 영역 -->
                    <div class="PageMaker_wrap" >
                    
	                    <ul class="PageMaker">
	                    
	                    	<!-- 이전 버튼 -->
	                    	<c:if test="${PageMaker.prev}">
	                    		<li class="PageMaker_btn prev">
	                    			<a href="${PageMaker.spageNo - 1}">이전</a>
	                    		</li>
	                    	</c:if>
	                    	
	                    	<!-- 페이지 번호 -->
	                    	<c:forEach begin="${PageMaker.spageNo}" end="${PageMaker.epageNo}" var="num">
	                    		<li class="PageMaker_btn ${criteria.cri.currPage == num ? "active":""}">
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
               		
					<form id="moveForm" action="/admin/sellerPop" method="get">
						<input type="hidden" name="currPage" value="${criteria.cri.currPage}">
						<input type="hidden" name="rowsPerPage" value="${criteria.cri.rowsPerPage}">
						<input type="hidden" name="keyword" value="${criteria.cri.keyword}">
					</form>               		
               		
               		
		</div>

	</div>
	
	<script>

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
		$(".pageMaker_btn a").on("click", function(e){
			
			e.preventDefault();
			
			console.log($(this).attr("href"));
			
			moveForm.find("input[name='currPage']").val($(this).attr("href"));
			
			moveForm.submit();
			
		});	
		
		/* 작가 선택 및 팝업창 닫기 */
		$(".move").on("click", function(e){
			
			e.preventDefault();
			
			let seller_id = $(this).attr("href");
			let seller_name= $(this).data("name");
			$(opener.document).find("#seller_id_input").val(authorId);
			$(opener.document).find("#seller_name_input").val(authorName);
			
			window.close();

		});	
	
	</script>

</body>
</html>