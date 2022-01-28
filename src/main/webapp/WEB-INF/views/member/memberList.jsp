<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<html>
<head>
	<meta charset="UTF-8">
	<title>Member List</title>
	<style>	
		#searchBar input[type="checkbox"]{width:20px;margin:0}
		table {
		  border-collapse: collapse;
		  text-align: center;
		  line-height: 1.5;
		
		}
		table thead th {
		  padding: 5px;
		  font-weight: bold;
		  vertical-align: top;
		  color: #369;
		  border-bottom: 3px solid #036;
		}
		table tbody th {
		  padding: 5px;
		  font-weight: bold;
		  vertical-align: top;
		  border-bottom: 1px solid #ccc;
		  background: #f3f6f7;
		}
		table td {
		  padding: 5px;
		  vertical-align: top;
		  border-bottom: 1px solid #ccc;
		}
		table a {
			color:gray;
			text-decoration:none;
		}
		table a:hover {
			color:black;
		}
	</style>
	<script src="resources/lib/jquery-3.2.1.min.js"></script> 
	<script>
		$('#listSearch1').click(function(e){
			let url = '';
			for(var i=0; i<$('#searchBar1 input[type="checkbox"]:checked').length; i++)
				url+='&check='+$($('#searchBar1 input[type="checkbox"]:checked')[i]).val();
			url = 'mlist?'+url.substring(1);
			console.log(url);
			$.ajax({
				type:'get',
				url:url,
				success:function(resultPage){
					resultPage = resultPage.substring(
							resultPage.lastIndexOf('"targetList">')+13,
							resultPage.lastIndexOf('</div>'));
					$('#targetList').html(resultPage);					
				},
				error:function() {
					alert("~~ 서버오류!!! 잠시후 다시 하세요 ~~");
				}
			}); //ajax
			return false;
		});
		
		$('#listSearch2').click(function(e){
			let url = 'masclist?searchType='+ $('#searchBar2 select').val();
			console.log(url);
			$.ajax({
				type:'get',
				url:url,
				success:function(resultPage){
					resultPage = resultPage.substring(
							resultPage.lastIndexOf('"targetList">')+13,
							resultPage.lastIndexOf('</div>'));
					$('#targetList').html(resultPage);					
				},
				error:function() {
					alert("~~ 서버오류!!! 잠시후 다시 하세요 ~~");
				}
			}); //ajax
			return false;
		});
	</script>
</head>
<body>
<div class="wrapped">
<h1>회원검색</h1>
<div id="searchBar1">
	<form action="mlist" method="get">
		<label><input type="checkbox" name="check" value="플레인">플레인&nbsp;</label>
		<label><input type="checkbox" name="check" value="브론즈">브론즈&nbsp;</label>
		<label><input type="checkbox" name="check" value="실버">실버&nbsp;</label>
		<label><input type="checkbox" name="check" value="골드">골드&nbsp;&nbsp;</label>
 		<button id="listSearch1">검색</button>&nbsp;		
		<input type="reset" value="취소">
	</form>
</div>
<div id="searchBar2">
	<form action="masclist" method="get">
		<select name='searchType'>
			<option value="member_id">I D
			<option value="name">이름
			<option value="birthday">생일
			<option value="point">포인트
		</select>
 		<button id="listSearch2">검색</button>&nbsp;		
		<input type="reset" value="취소">
	</form>
</div>




<!-- <script>
$(function() {	
	// SearchType 이 '---' 면 keyword 클리어
	$('#searchType').change(function() {
		if ($(this).val()=='n') $('#keyword').val('');
	}); //change
	// 검색후 요청
	$('#searchBtn').on("click", function() {
		self.location="mcplist"
			+"${pageMaker.makeQuery(1)}"
			+"&searchType="
			+$('#searchType').val()
			+'&keyword='
			+$('#keyword').val()
	}); //on_click
	
}) //ready

</script> -->
<!-- Paging2  ver02 : SearchCriteria 적용 -->
<%--  <div id="searchBar">
	<select name="searchType" id="searchType">
		<option value="n" <c:out value="${pageMaker.cri.searchType==null ? 'selected':''}"/> >---</option>
		<option value="i" <c:out value="${pageMaker.cri.searchType=='i' ? 'selected':''}"/> >ID</option>
		<option value="a" <c:out value="${pageMaker.cri.searchType=='a' ? 'selected':''}"/> >Name</option>
		<option value="l" <c:out value="${pageMaker.cri.searchType=='l' ? 'selected':''}"/> >Level</option>
		<option value="r" <c:out value="${pageMaker.cri.searchType=='r' ? 'selected':''}"/> >추천인</option>
		<option value="b" <c:out value="${pageMaker.cri.searchType=='b' ? 'selected':''}"/> >Birthday</option>
		<option value="ia" <c:out value="${pageMaker.cri.searchType=='ia' ? 'selected':''}"/> >ID or Name</option>
	</select>
	<input type="text" name="keyword" id="keyword" value="${pageMaker.cri.keyword}">
	<button id="searchBtn">Search</button>
</div> --%>


<div id="targetList">
<c:if test="${not empty message}">
=> ${message}<br>
</c:if>
<br>

<table width=100%>
<thead>
<tr>
	<th>I D</th><th>이름</th><th>성별</th><th>생년</th>
	<th>주소지</th><th>point</th><th>Last Access</th>
</tr>
</thead>
<tbody>	
<c:forEach var="list" items="${banana}">
<tr>
	<th> <!-- 관리자 기능 추가하기 -->
	<c:if test="${loginID=='admin'}">
		<a href="mdetail?member_id=${list.member_id}">${list.member_id}</a>
	</c:if>
	<c:if test="${loginID!='admin'}">
		${list.member_id} 
	</c:if>
	</th>
	<td>${list.name}</td>
	<td>
		<c:if test="${list.gender=='F'}">여</c:if>
		<c:if test="${list.gender=='M'}">남</c:if>
		<c:if test="${list.gender=='N'}">N</c:if>
	</td>
	<td>${list.birthday}</td><td>${list.address2}</td><td>${list.point}</td><td>${list.last_access}</td>
</tr>
</tbody>
</c:forEach>
</table>
</div>
</div>
</body>
</html>

