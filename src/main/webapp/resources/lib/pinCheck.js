$(function(){
	fChecks.forEach(function(focusoutCheck){
		$('#'+focusoutCheck.product_id).focusout(function(){
			focusoutCheck.bool = focusoutCheck.func();
			if(focusoutCheck.bool) $('#'+focusoutCheck.product_id).css({border:original});
			else $('#'+focusoutCheck.product_id).css({border:redbox});
		}); //focusout
	}); //forEach
	$('#pForm input[type="reset"]').click(function(){
		$('#pForm #pidDup').prop('disabled',false);
		$('#pForm #submit').prop('disabled',true);	
		$('#myForm #member_id').prop('readonly',false);
		$('#pForm .peMessage').html('');
		$('#pForm input,#pForm select').css({border:original});
		$('#pForm .direct').hide();
		window.scrollTo(0,0);
	});
}); //ready

class FocusoutCheck{
	constructor(bool,product_id,func,Product_id,name){
		this.bool=bool;
		this.product_id=product_id;
		this.func=func;
		this.Product_id=Product_id;
		this.name=name;
	}	
} //class_pfCheck

function pinCheck(result){
	let check=1;
	pfChecks.forEach(function(focusoutCheck){
		if(!focusoutCheck.bool){
			$('#'+focusoutCheck.pId).html(focusoutCheck.name+' 확인하세요');
			$('#'+focusoutCheck.product_id).css({border:redbox});
			check*=0;
		}
	});
	if(check!=0){
		if (confirm("정말 "+result+" 하십니까 ? (Yes:확인 / No:취소)")==false) {   
			alert('~~ '+result+'이(가) 취소 되었습니다 ~~');
		 	return false;
		}else{
			pfChecks.forEach(function(focusoutCheck){
				if(focusoutCheck.product_id=='address3')
					$('#address3').val($('#address3').val()+' '+$('#extraAddress').val());
				if(focusoutCheck.product_id=='email_tail'){
					if($('#email_tail').val()=='direct')
						$('#email').val( $('#email').val()+'@'+$('#email_direct').val() );
					else $('#email').val( $('#email').val()+'@'+$('#email_tail').val() );
				}
			});
			if($('#else').is(':checked'))
				$('#else').val($('#else').val()+':'+$('#else_direct').val());
			return true;
		} 
	}else return false;
} //pinCheck