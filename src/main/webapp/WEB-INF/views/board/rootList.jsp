<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title><c:if test="${not empty title}">${title}</c:if>글 목록</title>
	<link rel="stylesheet" type="text/css" href="resources/lib/main.css">
	<script src="resources/lib/jquery-3.2.1.min.js"></script>
	<script>
	$(function(){
		if("${role}".indexOf("ROLE_SELLER")!=-1){
			$('#seller_root').show();
		}else {
			$('#seller_root').hide();
		}
	});
	</script>
</head>
<body>
<h1><c:if test="${not empty title}">${title}</c:if>글 목록</h1>
<br>
<c:if test="${not empty message}">
=> ${message}<br>
</c:if>
<hr>
<table width=100%>
<tr height="30" bgcolor="RosyBrown">
	<th>글번호</th><th>글제목</th><th>ID</th><th>글등록일</th><th>조회수</th> 
</tr>	
<c:forEach var="list" items="${banana}">
<tr  height="30" align="center">
	<td>${list.root_seq}</td>
	<td align="left"> -
	 <!-- 답글 등록후 indent 에 따른 들여쓰기 
			=> 답글인 경우에만 적용  -->
	<%-- <c:if test="${list.indent>0}">
		<c:forEach begin="1" end="${list.indent}">
			<span>&nbsp;&nbsp;</span>
		</c:forEach>
		<span style="color:purple">re..</span>
	</c:if>  --%>
	
	 <!-- 글내용보기 기능 추가하기 -> login한 경우에만 허용 -->
	<c:if test="${not empty loginID}">
		<a href="rdetail?root_seq=${list.root_seq}">${list.title}</a>
	</c:if>
	<c:if test="${empty loginID}">
		${list.title} 
	</c:if>
	</td>
	<td align="left">${list.member_id}</td><td>${list.regdate}</td><td>${list.cnt}</td>
</tr>
</c:forEach>
</table>
<hr>
<div align="center">
	<!-- Paging 1 
	=> 현재Page (currPage) : 강조 / 아니면 : Link 적용 
	<c:forEach var="i" begin="1" end="${totalPageNo}">
		<c:if test="${i==currPage}">
			<font size="5" color="Orange">${i}</font>&nbsp;
		</c:if>
		<c:if test="${i!=currPage}">
			<a href="bpagelist?currPage=${i}">${i}</a>&nbsp;
		</c:if>
	</c:forEach> 
	-->
	<!-- Paging 2 : PageBlock 적용 
		=> 기호 사용  < &lt;   > &gt; 
	-->
	<c:choose>
		<c:when test="${sPageNo>pageNoCount}">
			<a href="rpagelist?currPage=1">첫페이지</a>&nbsp;
			<a href="rpagelist?currPage=${sPageNo-1}">&lt;</a>&nbsp;&nbsp;
		</c:when>
		<c:otherwise>
			<font color="gray">FF&nbsp;&lt;</font>&nbsp;&nbsp;
		</c:otherwise>
	</c:choose>
	
	<c:forEach var="i" begin="${sPageNo}" end="${ePageNo}">
		<c:if test="${i==currPage}">
			<font size="5" color="Orange">${i}</font>&nbsp;
		</c:if>
		<c:if test="${i!=currPage}">
			<a href="bpagelist?currPage=${i}">${i}</a>&nbsp;
		</c:if>
	</c:forEach>
	&nbsp;
	<c:choose>
		<c:when test="${ePageNo<totalPageNo}">
			<a href="rpagelist?currPage=${ePageNo+1}">&gt;</a>&nbsp;
			<a href="rpagelist?currPage=${totalPageNo}">끝페이지</a>
		</c:when>
		<c:otherwise>
			<font color="gray">&gt;&nbsp;끝페이지</font>
		</c:otherwise>
	</c:choose>
	
</div>
<hr>

<c:if test="${not empty loginID}">
	<c:if test='${type!="1"}'><a href="rinsertf?type=0" id="seller_root">홍보글등록</a>&nbsp;&nbsp;</c:if>
	<c:if test='${type!="0"}'><a href="rinsertf?type=1">리뷰글등록</a></c:if>
	<br>
</c:if>
<c:if test="${not empty title}">
	<c:if test='${title=="내 홍보" || title=="내 리뷰"}'>
	<a href="mypage?R=mypage">[mypage]</a>
	</c:if>
</c:if>
<!-- <a href='javascript:history.go(-1)'>이전으로</a>&nbsp;&nbsp; -->
<a href="home" >[Home]</a>
</body>
</html>