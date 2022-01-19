$(function(){	
	if(document.getElementById("loginID")){
		$('#loginBt').hide();
		$('#logoutBt').show();
	}else{
		$('#loginBt').show();
		$('#logoutBt').hide();
	}
	
	ajaxBnts.forEach(function(ajaxButton){
		if(ajaxButton.opt.includes('scale')) scale(ajaxButton.id);
		if(ajaxButton.url!=null){
			let success;
			let url = ajaxButton.url;
			let container = '#container'
			if(ajaxButton.opt.includes('loginID')) url = url+$('#loginID').val();
			if(ajaxButton.opt.includes('modal')){
				modal('#'+ajaxButton.id,300,300);
				container = '.modal_content';
			}
			if(ajaxButton.convey=='data'){
				success = function(resultData) {
								location.reload();
								alert(resultData.message);				
							}
			}else if(ajaxButton.convey=='page'){
				success = function(resultPage) {
								let body = resultPage.substring(resultPage.lastIndexOf('<body>')+6,
										resultPage.lastIndexOf('</body>'));
								if(body.indexOf("<P>징검다리</P>")!=-1)
									resultPage = body.substring(body.indexOf('<P>징검다리</P>'),
										body.indexOf('<div class="modal">'));
								$(container).html(resultPage);	
							}
			}
			$('#'+ajaxButton.id).click(function(e){	
					if(ajaxButton.opt.includes('banner')) banner();
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
		} //if
	}); //ajaxBnts_forEach
	
	$('.modal').click(function(e){
		$('.modal,.modal_content').hide();
		e.stopPropagation();
	});
	
		
	if(document.getElementById("R")){
		let R = $('#R').val();
		console.log(R);
		switch(R){
			case 'login': $('#loginBt').trigger('click'); break;
			case 'joinf': $('#joinf').trigger('click'); break;
		}
	}
	
}); //ready

class AjaxButton{
	constructor(opt,id,url,method,convey){
		this.opt=opt;
		this.id=id;
		this.url=url;
		this.method=method;
		this.convey=convey;
	}
}

class Home extends AjaxButton{}
class LoginBt extends AjaxButton{}
class LogoutBt extends AjaxButton{}
class Joinf extends AjaxButton{}
class Comment extends AjaxButton{}
class Mypage extends AjaxButton{}

const ajaxBnts = [new Home(['scale'],'home',null,null,null),
				new LoginBt(['scale','modal'],'loginBt','loginf','get','page'),
				new LogoutBt(['scale','loginID'],'logoutBt','logout?member_id=','get','page'),
				new Joinf(['banner'],'joinf','joinf','get','page'),
				new Comment(['banner'],'comment','comment','get','page'),
				new Mypage(['banner','loginID'],'mypage','mdetail?member_id=','get','page')
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

function modal(button,width,height){
	$(button).click(function(e){
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
		e.stopPropagation();
	}); //button_click
} //modal

function banner(){
	$('.banner').css({display:"none"});
}