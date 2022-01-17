<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 작성</title>
<link rel="stylesheet" href="resources/lib/comment.css"/>
<!-- <script type="text/javascript" src="resources/lib/comment.js"></script> -->
<script src="resources/lib/jquery-3.2.1.min.js"></script>
<script src="resources/lib/inCheck.js"></script>
</head>
<body>
    <div class="wrap">
        <h1>댓글</h1>
        <form name="reviewform" class="reviewform" method="post" action="/save">
            <input type="hidden" name="rate" id="rate" value="0"/>
            <p class="title_star">리뷰에 대한 평가를 남겨주세요.</p>
			<div class="star-rating space-x-4 mx-auto">
				<input type="radio" id="5-stars" name="rating" value="5" v-model="ratings"/>
				<label for="5-stars" class="star pr-4">★</label>
				<input type="radio" id="4-stars" name="rating" value="4" v-model="ratings"/>
				<label for="4-stars" class="star">★</label>
				<input type="radio" id="3-stars" name="rating" value="3" v-model="ratings"/>
				<label for="3-stars" class="star">★</label>
				<input type="radio" id="2-stars" name="rating" value="2" v-model="ratings"/>
				<label for="2-stars" class="star">★</label>
				<input type="radio" id="1-star" name="rating" value="1" v-model="ratings" />
				<label for="1-star" class="star">★</label>
			</div>
            <div class="review_contents">
                <div class="warning_msg">5자 이상의 리뷰 내용을 작성해 주세요.</div>
                <textarea rows="5" cols="50" class="review_textarea"></textarea>
            </div>   
            <div class="cmd">
                <input type="button" name="save" id="save" value="등록">
            </div>
        </form>
    </div>
</body>
</html>