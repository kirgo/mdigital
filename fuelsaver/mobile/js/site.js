var maxSaving;
var barWidth;
var stepPerPixel;
var sliderDotWidth;
var categorySteps = {};
var hear_from_val = '1';
var terms_val = '0';

/* PLUS MINUS BUTTONS FOR NON-TOUCH DEVICES*/
var categoryMax = {};
var	currentNum;
var newNum;

function isTouchDevice(){
  return (typeof(window.ontouchstart) != 'undefined') ? true : false;
}

function formFieldFocus(elem){
	if( $(elem).val() == $(elem).attr("data-default") ){
		$(elem).val("");
		$(elem).removeClass("placeholder");
		$(elem).addClass("nonplaceholder");
	}
};
function formFieldBlur(elem){
	if( $(elem).val() == "" ){
		$(elem).val( $(elem).attr("data-default") );
		$(elem).addClass("placeholder");
		$(elem).removeClass("nonplaceholder");
	}
};

$(document).ready(function() {
	$(".js_enabled").css("display","block");
	$(".no_js").css("display","none");
	
	if (isTouchDevice() == true) {
		$('.touch_enabled').css("display","block");
		sliderDots = $('.slider_dot');
		if( $(sliderDots[0]).find('img').width() > 0 ){
			window.sliderController.init();
		}else{
			$(sliderDots[0]).find('img').load(function() {
				window.sliderController.init();
			});
		}
		$('.touch_disabled').remove(); 
	}else{
		$('.touch_disabled').css("display","none");
		$('.touch_enabled').remove();
		$('.touch_disabled').show();
		pmButtonsPrep();
		$('.plus_minus_bar').each(function(){
			pmBarInit(this);
		});
	}
	
	$( ".no_js_box" ).css("display","none");
	
    $('#formSubmit').click(function () {
    	if($('#touchForm').length) {
    		if (isTouchDevice() == true) {
    			$('#touchForm').submit();
    		} else {
    			$('#touchDisabledForm').submit();
    		}
    	}else {
    	  $('form').submit();
    	}
    });
});


function pmButtonsPrep(){}
function pmBarInit(pmBarId){
	maxSaving = $(pmBarId).attr("data-max");
	barId = $(pmBarId).attr("id");
	stepInterval = 5;
	categoryMax[barId] = maxSaving;
}

function minusClick(buttonId){
	barId = $(buttonId).parent().attr("id");
	currentNum = $("#"+barId+" .saving_number span").html();
	currentNum = parseInt(currentNum);
	if(currentNum == 0){
		currentNum = 0;
	}else{
		currentNum = (currentNum-5);
	}
	$('#'+barId+' .saving_number').html('<h2>&pound;<span>'+ currentNum +'</span></h2>');
	updateTotal(buttonId);
}


function plusClick(buttonId){
	barId = $(buttonId).parent().attr("id");
	currentNum = $("#"+barId+" .saving_number span").html();
	currentNum = parseInt(currentNum);
	
	if(currentNum == categoryMax[barId]){
		currentNum = currentNum;
	}else{
		currentNum = (currentNum+5);
	}
	$('#'+barId+' .saving_number').html('<h2>&pound;<span>'+ currentNum +'</span></h2>');
	updateTotal(buttonId);
}

function updateTotal(buttonId){
	barId = $(buttonId).parent().attr("id");
	$("#categories_"+barId).val($('#'+barId+' .saving_number h2 span').html());
	var categoryKVP = {
		category: barId,
		value : $('#touchDisabledForm input[name="categories[' + barId + ']"]').val()
	};
	$.post('/fuelsaver/services/' + UUID + '/slider-track', categoryKVP);
}

function swapImage( image, imageSrc ){
	image.src = imageSrc;
}

function swap_fear_from_value(image){
	if(hear_from_val == '1'){
		hear_from_val = '0';
		$('#optin').val('0');
		swapImage(image,'/fuelsaver/mobile/images/empty_checkbox.png');
	}else{
		hear_from_val = '1';
		$('#optin').val('1');
		swapImage(image,'/fuelsaver/mobile/images/checked_checkbox.png');
	}
}

function swap_terms_value(image){
	if(terms_val == '1'){
		terms_val = '0';
		$('#terms').val('0');
		swapImage(image,'/fuelsaver/mobile/images/empty_checkbox.png');
	}else{
		$('#terms').val('1');
		terms_val = '1';
		swapImage(image,'/fuelsaver/mobile/images/checked_checkbox.png');
	}
}