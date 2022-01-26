$(function(){	
	if(document.getElementById("loginID")){
		$('#loginBt').hide();
		$('#logoutBt').show();
	}else{
		$('#loginBt').show();
		$('#logoutBt').hide();
	}
	
	// 스크롤 초기화
	window.scrollTo(0,0);
	
	// 뒤로가기 이벤트
/*	window.onpopstate = function(e){
		console.log("뒤로가기");
		history.go(-1);		
		alert('location:${document.location},state:${JSON.stringify(e.state)}');
	};*/
	
	// 서버 통신용 버튼에 click이벤트를 연결(AjaxBnt객체 배열의 forEach)
	ajaxBnts.forEach(function(ajaxButton){
		if(ajaxButton.opt.includes('scale')) scale(ajaxButton.id);
		if(ajaxButton.url!=null){
			let success;
			let url = ajaxButton.url;
			let container = '#container';
			if(ajaxButton.opt.includes('loginID')) url = url+$('#loginID').val();
			if(ajaxButton.convey=='data'){
				success = function(resultData) {
								location.href="home";
								alert(resultData.message);			
							}
			}else if(ajaxButton.convey=='page'){
				success = function(resultPage) {
								let body = resultPage.substring(resultPage.lastIndexOf('<body>')+6,
										resultPage.lastIndexOf('</body>'));
								if(body.indexOf('<img src="resources/image/logo.png"')!=-1)
									resultPage = body.substring(body.indexOf('<img src="resources/image/logo.png"'),
										body.indexOf('<div class="modal">'));
								if(ajaxButton.opt.includes('modal')){
									modal(300,350);
									container = '.modal_content';
								}
								$(container).html(resultPage);			
							}
			}
			$('#'+ajaxButton.id).click(function(e){	
				if(ajaxButton.opt.includes('banner')) $('.banner').css({display:"block"});
				else if(ajaxButton.opt.includes('hideBanner')) $('.banner').css({display:"none"});
/*				if(document.getElementById("R")) history.replaceState({data:url},ajaxButton.id,'/'+project+'/'+url);
				else history.pushState({data:'저장객체'},ajaxButton.id,'/'+project+'/'+url);	*/
				$.ajax({
					type:ajaxButton.method,
					url:url,
					
					success:success,
					error:function() {
								alert("~~ 서버오류!!! 잠시후 다시 하세요 ~~");
							}
				}); //ajax
				e.stopPropagation();
			}); //click
		}
	}); //ajaxBnts_forEach
	
	// modal창 실행 후 배경 누르면 창닫기
	$('.modal').click(function(e){
		if(!(document.getElementById('idOK'))) $('.modal,.modal_content').hide();
		e.stopPropagation();
	});
	
	// 요청처리 후 특정페이지로 연결		
	if(document.getElementById("R")){
		let R = $('#R').val();
		switch(R){
			case 'login': $('#loginBt').trigger('click'); break;
			case 'joinf': $('#joinf').trigger('click'); break;
		}
	}	
}); //ready

//let project = "Project";

class AjaxButton{
	constructor(opt,id,url,method,convey){
		this.opt=opt;
		this.id=id;
		this.url=url;
		this.method=method;
		this.convey=convey;
	}
}

let ajaxBnts = [
	new AjaxButton(['scale','banner'],'home',null,null,null),
	new AjaxButton(['scale','modal'],'loginBt','loginf','get','page'),
	//new AjaxButton(['scale','loginID','SS'],'logoutBt','logout?member_id=','post','data'),
	new AjaxButton(['scale','modal'],'logoutBt','logoutf','get','page'),	
	new AjaxButton(['hideBanner'],'joinf','joinf','get','page'),
	new AjaxButton(['hideBanner'],'comment','comments/comment','get','page'),
	new AjaxButton(['hideBanner','loginID'],'mypage','mypage?member_id=','get','page'),
	new AjaxButton(['hideBanner'],'mlist','mlist','get','page')
];

function scale(id){
	$('#'+id).hover(function(){
		$(this).css({
			transform:"scale(1.2)",
			cursor:"pointer"
		}); //css
	}, function(){
		$(this).css({
			transform:"scale(1)",
			cursor:"default"
		}); //css
	}); //hover
} //scale

function modal(width,height){
	$('.modal').css({
		position:"fixed",
		top:0,
		left:0,
		width:"100%",
		height:"100%", 
		background:"rgba(0,0,0,0.5)",
		display:"block"
	});
	$('.modal_content').css({
		position:"fixed",
		width:width,
		height:height,
		top:(window.innerHeight-height)/2,
		left:(window.innerWidth-width)/2,
		background:"white",
		display:"block",
		border:"0px solid gray",
		borderRadius:"5px 5px",
	});
} //modal