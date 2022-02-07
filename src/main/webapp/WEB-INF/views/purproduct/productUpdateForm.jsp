<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0,
	user-scalable=no, maximum-scale=1.0,minimum-scale=1.0">
<title>징검다리 : 상품정보수정</title>
<script src="resources/lib/jquery-3.2.1.min.js"></script>
<script src="resources/lib/pinCheck.js"></script>
<script>
	let pfChecks = [
		new FocusoutCheck(false,'product_id',pidCheck,'piMessage','상품아이디를'),
		new FocusoutCheck(false,'product_imgfile',puCheck,'puMessage','상품사진을'),
		new FocusoutCheck(false,'detprod_num',pdnCheck,'pdMessage','상품세부번호를'),
		new FocusoutCheck(false,'idtprod_num',pipCheck,'ipMessage','상품식별번호를'),
		new FocusoutCheck(false,'category',pcgCheck,'pgMessage','카테고리를'),
		new FocusoutCheck(false,'name',pnmCheck,'pnMessage','상품명을'),
		new FocusoutCheck(false,'currency',pcCheck,'pcMessage','통화를'),
		new FocusoutCheck(false,'price',ppiCheck,'ppMessage','가격을'),
		new FocusoutCheck(false,'quantity',pqtCheck,'pqMessage','수량을'),
		new FocusoutCheck(false,'regdate',prgCheck,'prMessage','상품제조일을'),
		new FocusoutCheck(false,'member_id',idCheck,'iMessage','판매자를'),
		new FocusoutCheck(false,'status',pstCheck,'psMessage','상품상태를'),
		new FocusoutCheck(false,'product_desc',pdcCheck,'pdMessage','상품설명을')
	];

	let redbox = '3px solid red';
	let original = '1px solid #ddd';
	
	function pidCheck() {
		let product_id=$('#product_id').val(); 	
		if (product_id.length<6) {
			$('#piMessage').html('~~ 상품 id 는 6자 이상 입니다 ~~');
			return false;
		}else if ( product_id.replace(/[a-z.0-9]/gi ,'').length > 0 ) {
			$('#piMessage').html('~~ 상품 id 는 영문자, 숫자로만 입력 하세요 ~~');
			return false;
		}else {
			$('#piMessage').html('');
			return true;
		}
	} //product_id
	
	function puCheck() {
		let product_imgfile=$('#product_imgfile').val()
		if (product_imgfile==null) {
			$('#puMessage').html('~~ 상품사진은 필수사항입니다 ~~');
			return false
		}else {
			$('#puMessage').html('');
			return true;
		}
	} //product_url
	
	/* function pu2Check() {
		let product_url2=$('#product_url2').val()
		if (product_url2==null) {
			$('#pu2Message').html('~~ 상품사진은 필수사항입니다 ~~');
			return false
		}else {
			$('#pu2Message').html('');
			return true;
		}
	} //product_url2  */
	
	function pdnCheck() {
		let detprod_num=$('#detprod_num').val()
		if (detprod_num.length<8) {
			$('#pdMessage').html('~~ 세부번호는 8자 이상 입니다 ~~');
			return false;
		}else if ( detprod_num.replace(/[0-9]/gi ,'').length > 0 ) {
			$('#pdMessage').html('~~ 세부번호는 숫자로만 입력 하세요');
			return false;
		}else {
			$('#pdMessage').html('');
			return true;
		}
	} //detprod_num
	
	function pipCheck() {
		let idtprod_num=$('#idtprod_num').val()
		if (idtprod_num.length<6) {
			$('#ipMessage').html('~~ 세부번호는 6자 이상 입니다 ~~');
			return false;
		}else if ( idtprod_num.replace(/[0-9]/gi ,'').length > 0 ) {
			$('#ipMessage').html('~~ 세부번호는 숫자로만 입력 하세요');
			return false;
		}else {
			$('#ipMessage').html('');
			return true;
		}
	} //idtprod_num
	
	function pcgCheck() {
		let category=$('#category').val();
		if(category==null) {
			$('#pgMessage').html(' ~~ 카테고리 를 골라주세요 ~~');
			return false;
		}else {
			$('#pgMessage').html('');
			return true;
		}	 
	}

	function pnmCheck() {
		let name=$('#name').val();
		if (name.length<1) {
			$('#pnMessage').html(' ~~ 상품명 은 1자 이상 입니다 ~~');
			return false;
		}else if (name.replace(/[a-z.가-힣]/gi,'').length > 0) {
			$('#pnMessage').html(' ~~ 상품명 은 한글 또는 영문 으로만 입력 하세요 ~~');
			return false;
		}else {
			$('#pnMessage').html('');
			return true;
		}	
	} //name (상품명)
	
	function pcCheck() {
		let currency=$('#currency').val();
		if (currency == null) {
			$('pcMessage').html('~~ 상품 화폐를 선택 해주세요 ~~');
			return false;
		}else
			$('#pcMessage').html('');
			return true;
		}
	} //currency
	
	function ppiCheck() {
		let price=$('#price').val();
		if (price == null) {
			$('#ppMessage').html('~~ 가격을 입력해주세요 ~~')
		}else if (price.replace(/[^0-9]/g,'')>0)
			$('#ppMessage').html('~~ 가격은 숫자로만 입력 하세요 ~~');
	} //price
	

	function pqtCheck() {
		let quantity=$('#quantity').val();
		if (quantity == null) {
			$('#pqMessage').html('~~ 수량을 입력해주세요 ~~')
		}else if (quantity.replace(/[^0-9]/g,'')>0)
			$('#pqMessage').html('~~ 수량은 숫자로만 입력 하세요 ~~');
	} //quantity 
	
	

	function prgCheck() {
		let regdate=$('#regdate').val();
		if (regdate.length != 10) {
			$('#prMessage').html(' ~~ 상품 제조일을 정확하게 입력 하세요 (yyyy-mm-dd) ~~');
			return false;
		}else {
			$('#prMessage').html('');
			return true;
		}	
	} //regdate
	
	function idCheck() {
		let id=$('#member_id').val(); 	
		if (id.length<4) {
			$('#iMessage').html('~~ 판매자 는 4자 이상 입니다 ~~');
			return false;
		}else if ( id.replace(/[a-z.0-9]/gi ,'').length > 0 ) {
			$('#iMessage').html('~~ 판매자 는 영문자, 숫자로만 입력 하세요 ~~');
			return false;
		}else {
			$('#iMessage').html('');
			return true;
		}
	} //member_id
	
	function pstCheck() {
		let status=$('#status').val();
		if (status == null){
			$('#psMessage').html(' ~~ 상품 상태를 선택해주세요 ~~');
			return false;
		}else {
			$('#psMessage').html('');
			return true;
		}
	} //status
	
	function pdcCheck() {
		let product_desc=$('#product_desc').val();
		if (product_desc == null) {
			$('#pdMessage').html('~~ 상품설명을 적어주세요 ~~')
			return false;
		}else {
			$('#psMessage').html('');
			return true;
	} //product_desc
	
	
</script>
<style>
	hr {
		width:100%;
	}
	table {
		/* width:350px; */
		border-collapse:collapse;
		text-align:left;
		line-height:1.5;
		border-top:1px solid #ccc;
		border-bottom:1px solid #ccc;
		margin:20px auto;
	}
	th {
		width:64px;
		padding:5px;
		font-weight:bold;
		vertical-align:top;
	}
	td {
		width:280px;
		padding:10px;
		vertical-align:top;
	}
	tr:nth-child(2n) {
		background:#efefef;
	}
	a {
		width:100px;
		text-decoration-line:none;
		font-weight:bold;
		margin:5px 0;
		border:0;
	}
	.center {
		text-align:center;
	}
	
	td span:not(.eMessage) {
		display: block;
		font-weight: bold;
		font-size: 20px;
		margin-bottom: 10px;
		margin-top: 10px;
	}

	td input {
		padding: 5px 5px;
		width: 95%;
		border: 1px solid #ddd;
	}
	#email,#email_tail,
	#email_direct {
		width:25%;
	}
	td input[type="submit"],
	td input[type="reset"] {
		width:46%;
	}
	td input[type="submit"]:hover,
	td input[type="reset"]:hover {
		background:snow;
	}
	td input[type="radio"] {
		width:15px;margin:0 20px 0 0;
	}	
	td input[type="checkbox"] {
		width:20px;margin:0
	}
	#email_direct,
	#else_direct {
		display:none;
	}
	.eMessage {
		padding:0;
		border:0;
		margin:0px;
		color:red;
		font-style:italic;
		font-family:굴림;
		font-size:12px;
	}
</style>
</head>

<body>
<div class="center">
	<h1>상품수정</h1>
	<form action="pupdate" method="post" enctype="multipart/form-data" id="pForm">
		<table>
			<tr>
			<th><lavel for="product_id">상품ID</lavel></th>
			<td>
				<input type="text" name="product_id" id="product_id" value='${apple.product_id}' size="20" style="width:50%" readonly><br>
				<span id="piMessage" class="peMessage"></span>
			</td>
			<tr>
				<th>상품사진</th>
				<td>
					<img src="${apple.product_img}" class="select_img" width="600" height="500"><br>
					<input type="hidden" name="product_img" value="${apple.product_img}"><br>
					<input type="file" name="product_imgfile" id="product_imgfile">
				<script>	  		
				$('#product_imgfile').change(function(){
					if(this.files && this.files[0]) {
						var reader = new FileReader;
				 			reader.onload = function(e) {
			 				$(".select_img").attr("src", e.target.result)
			 					.width(100).height(100); 
			 				} // onload_function
			 				reader.readAsDataURL(this.files[0]);
			 		} // if
				}); // change
	/* 			$('td input[type="reset"]').click(function(){
					$(".select_img").attr("src","${apple.profile}");
				}); */
				</script>
				</td>	
			</tr>
			<tr>
				<th><label for="detprod_num">상품세부번호</label></th>
				<td>
					<input type="text" name="detprod_num" id="detprod_num" value="${apple.detprod_num}" size="20"><br>
					<span id="pdMessage" class="peMessage"></span>			
				</td>
			</tr>
			<tr>
				<th><label for="idtprod_num">상품식별번호</label></th>
				<td>
					<input type="text" name="idtprod_num" id="idtprod_num" value="${apple.idtprod_num}" size="20"><br>
					<span id="ipMessage" class="peMessage"></span>			
				</td>
			</tr>
			<tr>
				<th>카테고리</th>
				<td>
					<label for="cloth">의류</label>
					<input type="radio" name="category" class="category_radio" id="cloth" value="C">
					<label for="eats">식품</label>
					<input type="radio" name="category" class="category_radio" id="eats" value="E">
					<label for="needs">생활용품</label>
					<input type="radio" name="category" class="category_radio" id="needs" value="N">
					<label for="book">도서</label>
					<input type="radio" name="category" class="category_radio" id="book" value="B">
					<label for="furniture">가구</label>
					<input type="radio" name="category" class="category_radio" id="furniture" value="F">
					<script>
/* 					$('input[name="category"]').each(function(){
						if($(this).val()=="${apple.category}") $(this).prop('checked',true);
					});  */
					</script>
				</td>
			</tr>
			<tr>
				<th><label for="name">상품명</label></th>
				<td>
					<input type="text" name="name" id="name" value="${apple.name}" size="20"><br>
					<span id="pnMessage" class="peMessage"></span>			
				</td>
			</tr>
			<tr>
				<th><label for="currency">통화</label></th>
				<td>
					<input type="text" name="currency" id="currency">&nbsp;&nbsp;
					<select id="status_tail">
						<option value="">선택</option>
						<option value="원">Won</option>
						<option value="달러">Dollar</option>
						<option value="엔">Yen</option>
						<option value="유로">Euro</option>
						<option value="초코">Choco</option>
					</select>
					<span id="pcMessage" class="peMessage"></span>		
				</td>
			</tr>
			<tr>
				<th><label for="price">가격</label></th>
				<td>
					<input type="number" name="price" id="price" value="${apple.price}" size="20"><br>
					<span id="ppMessage" class="peMessage"></span>			
				</td>
			</tr>
			<tr>
				<th><label for="quantity">수량</label></th>
				<td>
					<input type="number" name="quantity" id="quantity" value="${apple.quantity}" size="20"><br>
					<span id="pqMessage" class="peMessage"></span>			
				</td>
			</tr>
			<tr>
				<th><label for="regdate">상품제조일</label></th>
				<td>
					<input type="date" name="regdate" id="regdate" value="${apple.regdate}" size="20"><br>
					<span id="prMessage" class="peMessage"></span>			
				</td>
			</tr>
			<tr>
				<th><label for="member_id">판매자</label></th>
				<td>
					<input type="text" name="member_id" id="member_id" value="${apple.member_id}" size="20"><br>
					<input type="button" value="확인" id="idup" style="width:30%"><br>
					<span id="iMessage" class="peMessage"></span>			
				</td>
			</tr>
			<tr>
				<th><label for="status">상품상태</label></th>
				<td>
					<input type="text" name="status" id="status">&nbsp;&nbsp;
					<select id="status_tail">
						<option value="">선택</option>
						<option value="excelent">Excellent</option>
						<option value="good">Good</option>
						<option value="soso">So-so</option>
						<option value="bad">Bad</option>
						<option value="terrible">Terrible</option>
					</select>
					<span id="psMessage" class="peMessage"></span>		
				</td>
			</tr>
			<tr>
				<th><label for="product_desc">상품상태</label></th>
				<td>
					<input type="text" name="product_desc" id="product_desc" value="${apple.product_desc}" size="100"><br>
					<span id="pdMessage" class="peMessage"></span>			
				</td>
			</tr>
			
			
			
		
		
		
		
		
		</table>
	<div class="input_div">
		<label for="product_id">
			<span>*상품 아이디</span>
			<input type="text" name="product_id" id="product_id" placeholder="6자 이상 영문 또는 숫자" size="20" style="width:61%">&nbsp;
			<input type="button" value="상품ID중복확인" id="pidDup" style="width:30%"><br>
			<span id="piMessage" class="peMessage"></span>
		</label>
	</div>

	<!-- <div class="input_div">
		<span>Img</span>
		<img src="resources/uploadImage/box.png" class="default_img" width="100" height="100"><br>
		<input type="file" name="product_url" id="product_url">
		<script>
		
  		
			$('#product_url').change(function(){
				if(this.files && this.files[0]) {
					var reader = new FileReader;
			 			reader.onload = function(e) {
		 				$(".default_img").attr("src", e.target.result)
		 					.width(100).height(100); 
		 				} // onload_function
		 				reader.readAsDataURL(this.files[0]);
		 		} // if
			}); // change
			$('.input_div input[type="reset"]').click(function(){
				$(".default_img").attr("src","resources/uploadImage/box.png");
			});
		</script>
	</div> -->
	
	<div class="input_div">
		<span>*상품사진</span>
		<img src="resources/uploadImage/box.png" class="default_img" width="100" height="100"><br>
		<input type="file" name="product_imgfile" id="product_imgfile">
		<script>
		// 해당 파일의 서버상의 경로를 src로 지정하는것으로는 클라이언트 영역에서 이미지는 표시될수 없기 때문에
		// 이를 해결하기 위해 FileReader이라는 Web API를 사용
		// => 이 를 통해 url data를 얻을 수 있음.
		//    ( https://developer.mozilla.org/ko/docs/Web/API/FileReader)
		// ** FileReader
		// => 웹 애플리케이션이 비동기적으로 데이터를 읽기 위하여 읽을 파일을 가리키는File
		//    혹은 Blob 객체를 이용해 파일의 내용을(혹은 raw data버퍼로) 읽고 
		//    사용자의 컴퓨터에 저장하는 것을 가능하게 해줌.	
		// => FileReader.onload 이벤트의 핸들러.
		//    읽기 동작이 성공적으로 완료 되었을 때마다 발생.
		// => e.target : 이벤트를 유발시킨 DOM 객체
  		
			$('#product_imgfile').change(function(){
				if(this.files && this.files[0]) {
					var reader = new FileReader;
			 			reader.onload = function(e) {
		 				$(".default_img").attr("src", e.target.result)
		 					.width(100).height(100); 
		 				} // onload_function
		 				reader.readAsDataURL(this.files[0]);
		 		} // if
			}); // change
			$('.input_div input[type="reset"]').click(function(){
				$(".default_img").attr("src","resources/uploadImage/box.png");
			});
		</script>
	</div>
	
	<div class="input_div">
		<label for ="detprod_num">
			<span>*상품세부번호</span>
			<input type="text" name="detprod_num" id="detprod_num" placeholder='"-" 없이 번호만 8자 입력해주세요' size="60"><br>
			<span id="pdMessage" class="peMessage"></span>
		</label>
	</div>
	
	<div class="input_div">
		<label for ="idtprod_num">
			<span>*상품식별번호</span>
			<input type="text" name="idtprod_num" id="idtprod_num" placeholder='"-" 없이 번호만 6자 입력해주세요' size="60"><br>
			<span id="ipMessage" class="peMessage"></span>
		</label>
	</div>
	
	<div class="input_div">
		<span>*카테고리</span>
			<label for="cloth">의류</label>
			<input type="radio" name="category" class="category_radio" id="cloth" value="C" checked>
			<label for="eats">식품</label>
			<input type="radio" name="category" class="category_radio" id="eats" value="E">
			<label for="needs">생활용품</label>
			<input type="radio" name="category" class="category_radio" id="needs" value="N" ><br><br>
			<label for="book">도서</label>
			<input type="radio" name="category" class="category_radio" id="book" value="B" >
			<label for="furniture">가구</label>
			<input type="radio" name="category" class="category_radio" id="furniture" value="F" >	
	</div>
	
	<div class="input_div">
		<label for="name">
			<span>*상품명</span>
			<input type="text" name="name" id="name" placeholder="1자 이상 한글 또는 영문" size="40"><br>
			<span id="pnMessage" class="peMessage"></span>
		</label>
	</div>
	
	<div class="input_div">
		<label for="currency">
			<span>*통화</span>
			<select id="currency_tail">
				<option value="">선택</option>
				<option value="원">won</option>
				<option value="달러">dollar</option>
				<option value="엔">yen</option>
				<option value="유로">euro</option>	
				<option value="초코">choco</option>
			</select>
			<span id="psMessage" class="peMessage"></span>
		</label>
	</div>	
	
	<div class="input_div">
		<label for="price">
			<span>*상품가격</span>
			<input type="number" name="price" id="price"><br>
			<span id="ppMessage" class="peMassage"></span>
		</label>
	</div>
	
	<div class="input_div">
		<label for="quantity">
			<span>*상품수량</span>
			<input type="number" name="quantity" id="quantity"><br>
			<span id="pqMessage" class="peMassage"></span>
		</label>
	</div>
	
	<div class="input_div">
		<label for="regdate">
			<span>*상품제조일</span>
			<input type="date" name="regdate" id="regdate"><br>
			<span id="prMessage" class="peMessage"></span>
		</label>
	</div>	
			
	<div class="input_div">
		<label for="member_id">
			<span>*판매자</span>
			<input type="text" name="member_id" id="member_id" placeholder="4자 이상 영문 또는 숫자" size="20" style="width:61%">&nbsp;
			<input type="button" value="확인" id="" style="width:30%"><br>
			<span id="iMessage" class="peMessage"></span>
		</label>
	</div>
	
	<div class="input_div">
		<label for="status">
			<span>*상품상태</span>
				<select id="status_tail">
					<option value="">선택</option>
					<option value="excelent">Excelent</option>
					<option value="best">Best</option>
					<option value="soso">Soso</option>
					<option value="bad">Bad</option>
					<option value="terrible">Terrible</option>
				</select>
			<span id="psMessage" class="peMessage"></span>
		</label>
	</div>
		
	<div class="input_div">
		<label for="product_desc">
			<span>*상품설명</span>
			<textarea id="product_desc" name="product_desc" placeholder="간략히 적어주세요"></textarea>
		</label>
	</div>

	<div class="input_div">
		<span id="finalMessage" class="peMessage"></span>
		<input type="submit" value="수정" onclick="return ㅔinCheck('수정')" id="submit">&nbsp;&nbsp;
		<input type="reset" value="입력 초기화">&nbsp;&nbsp;
	</div>	
	</form>
	<c:if test="${not empty message}">
	<br>=> ${message}<br><br> 
	</c:if>
</div> 
</body>
</html>