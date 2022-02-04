<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<html>
<head>
	<meta charset="UTF-8">
	<title>Member List</title>
	<style>	
		#searchBar input[type="checkbox"]{
			width:20px;
			margin:0
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
		label:hover,
		input:hover, 
		button:hover,
		select:hover {
			cursor:pointer;
		}
.slider {
	position: relative;
	z-index: 1;
	height: 10px;
	margin: 0 15px; 
}
.slider > .track {
	position: absolute;
	z-index: 1;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	border-radius: 5px;
	background-color: #c6aee7;
} 
.slider > .range {
	position: absolute;
	z-index: 2;
	left: 25%;
	right: 25%;
	top: 0;
	bottom: 0;
	border-radius: 5px;
	background-color: #6200ee;
}
.slider > .thumb { 
	position: absolute; z-index: 3; width: 30px; height: 30px; background-color: #6200ee; border-radius: 50%;
}
.slider > .thumb.left {
	left: 25%; transform: translate(-15px, -10px);
}
.slider > .thumb.right {
	right: 25%; transform: translate(15px, -10px);
}
input[type="range"] {
	position: absolute; /* opacity로 가린 것을 이벤트도 비활성화하기 위해 */
	pointer-events: none;
	-webkit-appearance: none;
	z-index: 2;/*2*/
	height: 10px;
	width: 100%;
	opacity: 0;
}
input[type="range"]::-webkit-slider-thumb { 
	/* 겹쳐진 두 thumb를 모두 활성화 */
	pointer-events: all;
	width: 30px;
	height: 30px;
	border-radius: 0;
	border: 0 none;
	background-color: red;
	cursor: pointer; /* appearance를 해야 위의 스타일들을 볼 수 있음 */
	-webkit-appearance: none;
}
	</style>
	<script src="resources/lib/jquery-3.2.1.min.js"></script> 
	<script>	
		$('#listSearch').click(function(e){
			let url = '';
			url += 'column='+ $('#searchBar select[name="column"]').val()+"&order="+$('#searchBar input[name="order"]:checked').val();
			for(var i=0; i<$('#searchBar input[name="check1"]:checked').length; i++)
				url+='&check1='+$($('#searchBar input[name="check1"]:checked')[i]).val();
			for(var i=0; i<$('#searchBar input[name="range1"]').length; i++)
				url+='&range1='+$($('#searchBar input[name="range1"]')[i]).val();
			url += "&searchType="+$('#searchType').val()+'&keyword='+$('#keyword').val();
			console.log(url);
			$.ajax({
				type:'get',
				url:'slist?'+url,
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

<div id="searchBar">

		<br><br>
		<div class="multi-range-slider"> 
			<!-- 진짜 슬라이더 --> 
			<input type="range" name="range1" id="input-left" min="1900" max="2022" value="1990" /> 
			<input type="range" name="range1" id="input-right" min="1900" max="2022" value="2022" />
 			<!-- 커스텀 슬라이더 -->
			<div class="slider"> 
				<div class="track"></div> 
				<div class="range"></div> 
				<div class="thumb left"></div>
 				<div class="thumb right"></div> 
			</div>
		</div>
		<br><br>

		<script>
	const inputLeft = document.getElementById("input-left"); 
	const inputRight = document.getElementById("input-right"); 
	const thumbLeft = document.querySelector(".slider > .thumb.left");
	const thumbRight = document.querySelector(".slider > .thumb.right"); 
	const range = document.querySelector(".slider > .range"); 

	const setLeftValue = () => { 
	const _this = inputLeft; 
	const [min, max] = [parseInt(_this.min), parseInt(_this.max)];
	// 교차되지 않게, 1을 빼준 건 완전히 겹치기보다는 어느 정도 간격을 남겨두기 위해.
	 _this.value = Math.min(parseInt(_this.value), parseInt(inputRight.value) - 1); 
	// input, thumb 같이 움직이도록
	 const percent = ((_this.value - min) / (max - min)) * 100; 
	thumbLeft.style.left = percent + "%"; 
	range.style.left = percent + "%";
	};

	 const setRightValue = () => {
	 const _this = inputRight;
	 const [min, max] = [parseInt(_this.min), parseInt(_this.max)];
	 // 교차되지 않게, 1을 더해준 건 완전히 겹치기보다는 어느 정도 간격을 남겨두기 위해. 
	_this.value = Math.max(parseInt(_this.value), parseInt(inputLeft.value) + 1);
	// input, thumb 같이 움직이도록 
	const percent = ((_this.value - min) / (max - min)) * 100;
	 thumbRight.style.right = 100 - percent + "%"; 
	range.style.right = 100 - percent + "%"; 
	};

	 inputLeft.addEventListener("input", setLeftValue); 
	inputRight.addEventListener("input", setRightValue);
		</script>

	<form action="slist" method="get">
		<select name="searchType" id="searchType">
			<option value="n">---</option>
			<option value="c">회사명</option>
			<option value="r">대표자</option>
			<option value="cr">회사명 or 대표자</option>
		</select>
		<input type="text" name="keyword" id="keyword">
		<br>사업장 소재지&nbsp;&nbsp;
		<label><input type="checkbox" name="check1" value="서울">서울&nbsp;</label>
		<label><input type="checkbox" name="check1" value="경기">경기&nbsp;</label>
		<label><input type="checkbox" name="check1" value="인천">인천&nbsp;</label>
		<br>
		<select name='column'>
			<option value="company_name">회사명
			<option value="representative">대표자
			<option value="launch_date">사업개시년
			<option value="location2">사업장 소재지
			<option value="employer_id">사업자등록번호
		</select>
		<label><input type="radio" name="order" value="asc" checked>오름차순&nbsp;</label>
		<label><input type="radio" name="order" value="desc">내림차순&nbsp;</label>
 		<button id="listSearch">검색</button>&nbsp;		
		<input type="reset" value="검색조건 초기화">
	</form>
</div>
<div class="wrapped">
<h1>판매자검색</h1>


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
	<th>I D</th><th>회사명</th><th>대표자</th><th>사업자등록번호</th>
	<th>사업개시</th><th>사업장</th>
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
	<td>${list.company_name}</td><td>${list.representative}</td><td>${list.employer_id}</td>
	<td>${list.launch_date}</td><td>${list.location2}</td>
</tr>
</tbody>
</c:forEach>
</table>
</div>
</div>
</body>
</html>

