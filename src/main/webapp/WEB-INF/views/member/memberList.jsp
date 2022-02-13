<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<html>
<head>
	<meta charset="UTF-8">
	<title>징검다리 : 회원검색</title>
	<style>
		#searchBar input[type="checkbox"]{
			width:20px;
			margin:0
		}
		#searchBar input[name^="range"]{
			width:50px;
		}
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
		a:hover,
		label:hover,
		input:hover, 
		button:hover,
		select:hover {
			cursor:pointer;
		}
	</style>
	<script src="resources/lib/jquery-3.2.1.min.js"></script> 
	<script>	
		$('#searchBar #listSearch').click(function(e){
			let url = '?';
			url += 'column='+ $('#searchBar select[name="column"]').val()+"&order="+$('#searchBar input[name="order"]:checked').val();
			for(var i=0; i<$('#searchBar input[name="check1"]:checked').length; i++)
				url+='&check1='+$($('#searchBar input[name="check1"]:checked')[i]).val();
			for(var i=0; i<$('#searchBar input[name="check2"]:checked').length; i++)
				url+='&check2='+$($('#searchBar input[name="check2"]:checked')[i]).val();
			for(var i=1; i<=$('#searchBar input[name^="range"]').length/2; i++){
				url+='&range'+i+'='+$($('#searchBar input[name="range'+i+'"]')[0]).val();
				url+='&range'+i+'='+$($('#searchBar input[name="range'+i+'"]')[1]).val();
			}
			url += "&searchType="+$('#searchType').val()+'&keyword='+$('#keyword').val();
			console.log(url);
			$.ajax({
				type:'get',
				url:'msearchlist'+url,
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
		
		function paging(query){
			let url = query;
			url += '&column='+ $('#searchBar select[name="column"]').val()+"&order="+$('#searchBar input[name="order"]:checked').val();
			for(var i=0; i<$('#searchBar input[name="check1"]:checked').length; i++)
				url+='&check1='+$($('#searchBar input[name="check1"]:checked')[i]).val();
			for(var i=0; i<$('#searchBar input[name="check2"]:checked').length; i++)
				url+='&check2='+$($('#searchBar input[name="check2"]:checked')[i]).val();
			for(var i=1; i<=$('#searchBar input[name^="range"]').length/2; i++){
				url+='&range'+i+'='+$($('#searchBar input[name="range'+i+'"]')[0]).val();
				url+='&range'+i+'='+$($('#searchBar input[name="range'+i+'"]')[1]).val();
			}
			url += "&searchType="+$('#searchType').val()+'&keyword='+$('#keyword').val();
			console.log(url);
			$.ajax({
				type:'get',
				url:'msearchlist'+url,
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
		}
	</script>
</head>
<body>
<div class="wrapped">
	<h1>회원검색</h1>
	<form action="mlist" method="get" id="searchBar">
	<table>
		<tr><th>키워드</th>
			<td>
				<select name="searchType" id="searchType">
					<option value="n">---</option>
					<option value="i">ID</option>
					<option value="a">Name</option>
					<option value="ia">ID or Name</option>
				</select>
				<input type="text" name="keyword" id="keyword">
			</td>
		</tr>
		<tr><th>출생년도</th>
			<td>
				<input type="text" name="range1" value="1900">년&nbsp;~&nbsp;
				<input type="text" name="range1" value="2022">년
			</td>
		</tr>
		<tr><th>구매</th>
			<td>
				<input type="text" name="range2" value="0">건&nbsp;~&nbsp;
				<input type="text" name="range2" value="10000">건
			</td>
		</tr>
		<tr><th>팔로워수</th>
			<td>
				<input type="text" name="range3" value="0">명&nbsp;~&nbsp;
				<input type="text" name="range3" value="1000000">명
			</td>
		</tr>
		<tr><th>성별</th>
			<td>
				<label><input type="checkbox" name="check2" value="M">남&nbsp;</label>
				<label><input type="checkbox" name="check2" value="F">여&nbsp;</label>
				<label><input type="checkbox" name="check2" value="N">기타&nbsp;</label>
			</td>
		</tr>		
		<tr><th>주소지</th>
			<td>
				<label><input type="checkbox" name="check1" value="서울">서울&nbsp;</label>
				<label><input type="checkbox" name="check1" value="경기">경기&nbsp;</label>
				<label><input type="checkbox" name="check1" value="인천">인천&nbsp;</label>
				<label><input type="checkbox" name="check1" value="부산">부산&nbsp;</label>
				<label><input type="checkbox" name="check1" value="대구">대구&nbsp;</label><br>
				<label><input type="checkbox" name="check1" value="광주">광주&nbsp;</label>
				<label><input type="checkbox" name="check1" value="대전">대전&nbsp;</label>
				<label><input type="checkbox" name="check1" value="울산">울산&nbsp;</label>
				<label><input type="checkbox" name="check1" value="전북">전북&nbsp;</label>
				<label><input type="checkbox" name="check1" value="전남">전남&nbsp;</label><br>
				<label><input type="checkbox" name="check1" value="경북">경북&nbsp;</label>
				<label><input type="checkbox" name="check1" value="경남">경남&nbsp;</label>
				<label><input type="checkbox" name="check1" value="충북">충북&nbsp;</label>
				<label><input type="checkbox" name="check1" value="충남">충남&nbsp;</label>
				<label><input type="checkbox" name="check1" value="강원">강원&nbsp;</label><br>
				<label><input type="checkbox" name="check1" value="제주">제주&nbsp;</label>
				<label><input type="checkbox" name="check1" value="세종">세종&nbsp;</label>
			</td>
		</tr>
		<tr><th>출력순서</th>
			<td>
				<select name='column'>
					<option value="member_id">I D
					<option value="name">이름
					<option value="birthday">생일
					<option value="point">포인트
					<option value="last_access">최근접속일시
				</select>
				<label><input type="radio" name="order" value="asc" checked>오름차순&nbsp;</label>
				<label><input type="radio" name="order" value="desc">내림차순&nbsp;</label>
			</td>
		</tr>
		<tr>
			<td colspan="2">
		 		<button id="listSearch">검색</button>&nbsp;		
				<input type="reset" value="검색조건 초기화">
			</td>
		</tr>
	</table>
	</form>
	
	<div id="targetList">
<c:if test="${not empty message}">
=> ${message}<br>
</c:if>
<br>
		<table>
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
		<a href="mdetail?member_id=${list.member_id}">${list.member_id}</a></c:if>
	<c:if test="${loginID!='admin'}">
		${list.member_id}</c:if>
					</th>
					<td>${list.name}</td>
					<td>
						<c:if test="${list.gender=='F'}">여</c:if>
						<c:if test="${list.gender=='M'}">남</c:if>
						<c:if test="${list.gender=='N'}">N</c:if>
					</td>
					<td>${list.birthday}</td>
					<td>${list.address2}</td>
					<td>${list.point}</td>
					<td>${list.last_access}</td>
				</tr>
</c:forEach>
			</tbody>
		</table>				
		<div align="center">
			<!-- Paging 
				SearchCriteria 적용 -> pageMaker.searchQuery(?) 		
				 1)  First << ,  Prev <  처리 -->
			<c:if test="${pageMaker.prev && pageMaker.spageNo>1}">
				<a onclick="paging('${pageMaker.makeQuery(1)}')">FF</a>&nbsp;
				<a onclick="paging('${pageMaker.makeQuery(pageMaker.spageNo-1)}')">Prev</a>
			</c:if>
			<!-- 2) sPageNo ~ ePageNo 까지, displayPageNo 만큼 표시 -->
			<c:forEach var="i" begin="${pageMaker.spageNo}" end="${pageMaker.epageNo}">
				<c:if test="${i==pageMaker.cri.currPage}">
					<font size="5" color="#036">${i}</font>&nbsp;
				</c:if>
				<c:if test="${i!=pageMaker.cri.currPage}">
					<a onclick="paging('${pageMaker.makeQuery(i)}')">${i}</a>&nbsp;
				</c:if>
			</c:forEach>
			&nbsp;
			<!-- 3) Next >  ,  Last >>  처리 -->
			<c:if test="${pageMaker.next && pageMaker.epageNo>0}">
				<a onclick="paging('${pageMaker.makeQuery(pageMaker.epageNo+1)}')">Next</a>&nbsp;
				<a onclick="paging('${pageMaker.makeQuery(pageMaker.lastPageNo)}')">LL</a>&nbsp;&nbsp;
			</c:if>
		</div>
	</div>
</div>
</body>
</html>

