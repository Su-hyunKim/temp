<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Spring Mybatis Cri_PageList **</title>
<link rel="stylesheet" type="text/css" href="resources/lib/main.css" >
<script src="resources/lib/jquery-3.2.1.min.js"></script>
<script>
$(function() {	
	// SearchType 이 '---' 면 keyword 클리어
	$('#searchType').change(function() {
		if ($(this).val()=='n') $('#keyword').val('');
	}); //change
	// 검색후 요청
	$('#searchBtn').on("click", function() {
		self.location="pcplist"
			+"${pageMaker.makeQuery(1)}"
			+"&searchType="
			+$('#searchType').val()
			+'&keyword='
			+$('#keyword').val()
	}); //on_click
	
}) //ready
</script>
</head>
<body>
<h2>** Spring Mybatis Cri_PageList **</h2>
<br>
<c:if test="${message!=null}">
 => ${message}<br> 
</c:if>
<!-- Paging2 : SearchCriteria 적용 -->
 <div id="searchBar">
	<select name="searchType" id="searchType">
		<option value="n" <c:out value="${pageMaker.cri.searchType==null ? 'selected':''}"/> >---</option>
		<option value="i" <c:out value="${pageMaker.cri.searchType=='i' ? 'selected':''}"/> >상품ID</option>
		<option value="a" <c:out value="${pageMaker.cri.searchType=='a' ? 'selected':''}"/> >상품명</option>
		<option value="m" <c:out value="${pageMaker.cri.searchType=='m' ? 'selected':''}"/> >판매자</option>
		<option value="ia" <c:out value="${pageMaker.cri.searchType=='ia' ? 'selected':''}"/> >상품ID or 상품명</option>
		<option value="ti" <c:out value="${pageMaker.cri.searchType=='im' ? 'selected':''}"/> >상품ID or 판매자</option>
		<option value="tci" <c:out value="${pageMaker.cri.searchType=='iam' ? 'selected':''}"/> >상품ID or 상품명 or 판매자</option>
	</select>
	<input type="text" name="keyword" id="keyword" value="${pageMaker.cri.keyword}">
	<button id="searchBtn">Search</button>
</div>
<br><hr>
<table  width=100%>
<tr height="40" bgcolor="PaleTurquoise">
	<th>상품ID</th><th>Img</th><th>상품명</th><th>RegDate</th><th>조회수</th>
</tr>
<c:forEach var="list" items="${banana}"><tr height="40">
	<td>${list.seq}</td>
	<td>
		<!-- 답글 등록후 indent 에 따른 들여쓰기 
			=> 답글인 경우에만 적용  -->
		<%-- <c:if test="${list.indent>0}">
			<c:forEach begin="1" end="${list.indent}">
				<span>&nbsp;&nbsp;</span>
			</c:forEach>
			<span style="color:Purple">re..</span>
		</c:if> --%>
	
		<!-- 로그인 했을때만 글내용을 볼 수 있도록 -->
		<c:if test="${loginID!=null}">
			<a href="pdetail?product_id=${list.product_id}&name=${list.name}">${list.product_url}</a>
		</c:if>
		<c:if test="${loginID==null}">
			${list.product_url}
		</c:if>
	</td>
	<td>${list.name}</td><td>${list.regdate}</td><td align="center">${list.cnt}</td>
</tr></c:forEach>
</table>
<br><hr>

<div align="center">
<!-- Paging 2 
		=> ver01 : Criteria 적용 -> pageMaker.makeQuery(?)
		=> ver02 : SearchCriteria 적용 -> pageMaker.searchQuery(?) 
		
		 1)  First << ,  Prev <  처리 -->
	<c:if test="${pageMaker.prev && pageMaker.spageNo>1}">
		<a href="pcplist${pageMaker.searchQuery(1)}">FF</a>&nbsp;
		<a href="pcplist${pageMaker.searchQuery(pageMaker.spageNo-1)}">Prev</a>
	</c:if>
	<!-- 2) sPageNo ~ ePageNo 까지, displayPageNo 만큼 표시 -->
	<c:forEach var="i" begin="${pageMaker.spageNo}" end="${pageMaker.epageNo}">
		<c:if test="${i==pageMaker.cri.currPage}">
			<font size="5" color="Orange">${i}</font>&nbsp;
		</c:if>
		<c:if test="${i!=pageMaker.cri.currPage}">
			<a href="bcplist${pageMaker.searchQuery(i)}">${i}</a>&nbsp;
		</c:if>
	</c:forEach>
	&nbsp;
	<!-- 3) Next >  ,  Last >>  처리 -->
	<c:if test="${pageMaker.next && pageMaker.epageNo>0}">
		<a href="pcplist${pageMaker.searchQuery(pageMaker.epageNo+1)}">Next</a>&nbsp;
		<a href="pcplist${pageMaker.searchQuery(pageMaker.lastPageNo)}">LL</a>&nbsp;&nbsp;
	</c:if>
</div>

<br><hr>
<c:if test="${loginID!=null}"> 	
	<a href="pregistf">상품등록</a>&nbsp;&nbsp;
	<a href="logout">Logout</a>&nbsp;&nbsp;
</c:if>  
<c:if test="${loginID==null}"> 
	<a href="loginf">로그인</a>&nbsp;&nbsp;
	<a href="joinf">회원가입</a>&nbsp;&nbsp;
</c:if>
<a href="home">[HOME]</a>
</body>
</html>