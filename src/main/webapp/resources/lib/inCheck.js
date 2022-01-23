$(function(){
	fChecks.forEach(function(focusoutCheck){
		$('#'+focusoutCheck.id).focusout(function(){
			focusoutCheck.bool = focusoutCheck.func();
			if(focusoutCheck.bool) $('#'+focusoutCheck.id).css({border:original});
			else $('#'+focusoutCheck.id).css({border:redbox});
		}); //focusout
	}); //forEach
	$('#myForm input[type="reset"]').click(function(){
		$('#myForm #idDup').prop('disabled',false);
		$('#myForm #submit').prop('disabled',true);	
		$('#myForm #member_id').prop('readonly',false);
		$('#myForm .eMessage').html('');
		$('#myForm input,#myForm select').css({border:original});
		$('#myForm .direct').hide();
		window.scrollTo(0,0);
	});
}); //ready

class FocusoutCheck{
	constructor(id,func,mId,name){
		this.bool=false;
		this.id=id;
		this.func=func;
		this.mId=mId;
		this.name=name;
	}	
} //class_fCheck

function inCheck(result){
	let check=1;
	fChecks.forEach(function(focusoutCheck){
		if(!focusoutCheck.bool){
			$('#'+focusoutCheck.mId).html(focusoutCheck.name+' 확인하세요');
			$('#'+focusoutCheck.id).css({border:redbox});
			check*=0;
		}
	});
	if(check!=0){
		if (confirm("정말 "+result+" 하십니까 ? (Yes:확인 / No:취소)")==false) {   
			alert('~~ '+result+'이(가) 취소 되었습니다 ~~');
		 	return false;
		}else{
			fChecks.forEach(function(focusoutCheck){
				if(focusoutCheck.id=='address3')
					$('#address3').val($('#address3').val()+' '+$('#extraAddress').val());
				if(focusoutCheck.id=='email')
					$('#email').val($('#email').val()+'@'+$('#email_tail').val());
				if($('#email').val().includes('direct'))
					$('#email').val($('#email').val().replace('direct',$('#email_direct').val()));
			});
			if($('#else').is(':checked'))
				$('#else').val($('#else').val()+':'+$('#else_direct').val());
			return true;
		} 
	}else return false;
} //inCheck