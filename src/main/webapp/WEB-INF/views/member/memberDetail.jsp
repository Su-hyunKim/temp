<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Spring Mybatis MemberDetail **</title>
<link rel="stylesheet" type="text/css" href="resources/lib/myinfo.css">
</head>
<body>
<div class="myContainer">
	<div class="text"><h2>마이페이지</h2></div>
</div>
<div class="wrap">
  <div class="mintContainer">
    <div>
      <div class="grade">Rank</div>
      <div class="name">${apple.name}</div>
    </div>    
    <div class="modify">i</div>    
  </div>
  <div class="summaryContainer">
    <div class="item">
        <div class="number">0</div>
        <div>단골상점</div>
      </div>
      <div class="item">
        <div class="number">0</div>
        <div>상품후기</div>
      </div>
      <div class="item">
        <div class="number">0</div>
        <div>포인트(초코)</div>
      </div>
  </div>  
  <div class="shippingStatusContainer">
    <div class="title">
      주문/배송조회
    </div>
    <div class="status">
      
      <div class="item">
        <div>
          <div class="green number">0</div>
          <div class="text">장바구니</div>
        </div>
        <div class="icon"> > </div>
      </div>     
      <div class="item">
        <div>
          <div class="number">0</div>
          <div class="text">결제완료</div>
        </div>
        <div class="icon"> > </div>
      </div>     
      <div class="item">
        <div>
          <div class="green number">0</div>
          <div class="text">배송중</div>
        </div>
        <div class="icon"> > </div>
      </div>     
      <div class="item">
        <div>
          <div class="green number">0</div>
          <div class="text">구매확정</div>
        </div>
      </div>     
      
    </div>
    
  </div>  
  <div class="listContainer">
    <a href="#" class="item">
        <div class="icon"><img src="resources/image/footprint.jpg" width="30" height="30"></div>
        <div class="text">내 홍보글<span class="circle"></span></div>
        <div class="right"> > </div>
    </a>
    <a href="#" class="item">
        <div class="icon"><img src="resources/image/footprint.jpg" width="30" height="30"></div>
        <div class="text">내 상품</div>
        <div class="right"> > </div>
    </a>
    <a href="#" class="item">
        <div class="icon"><img src="resources/image/footprint.jpg" width="30" height="30"></div>
        <div class="text">내 리뷰</div>
        <div class="right"> > </div>
    </a>
    <a href="#" class="item">
        <div class="icon"><img src="resources/image/footprint.jpg" width="30" height="30"></div>
        <div class="text">내 댓글</div>
        <div class="right"> > </div>
    </a>
    <a href="#" class="item">
        <div class="icon"><img src="resources/image/footprint.jpg" width="30" height="30"></div>
        <div class="text">
          <span>내 지갑</span>
          <span class="smallLight">
            <span>|</span>
            <span>보유 포인트(초코)</span>
          </span>          
        </div>                
        <div class="right">
          <span class="blct">0 초코</span>
          > </div>
    </a>
    <a href="#" class="item">
        <div class="icon"><img src="resources/image/footprint.jpg" width="30" height="30"></div>
        <div class="text">추천인</div>
        <div class="right"> > </div>
    </a>
  </div>
  <div class="infoContainer">
    <a href="mdetail?jcode=U&id=${apple.member_id}" class="item">
      <div><h3>내 정보수정</h3></div>
    </a>    
    <a href="mdelete?id=${apple.member_id}" class="item">
      <div><h3>회원탈퇴</h3></div>
    </a>    
    <a href="home" class="item">
      <div><h3>HOME</h3></div>
    </a>
  </div>
</div>
</body>
</html>