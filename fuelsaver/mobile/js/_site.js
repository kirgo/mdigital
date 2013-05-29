var maxSaving;
var barWidth;
var stepPerPixel;
var sliderDotWidth;
var categorySteps = {};
var hear_from_val = '1';
var terms_val = '0';

function isTouchDevice(){
  return (typeof(window.ontouchstart) != 'undefined') ? true : false;
}

$(document).ready(function() {
  
	
    /** generic form submission handler */
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
    

    if (isTouchDevice() == true) {
	  	$('.slider_dot img').first().load(function(){
			slidersPrep();
			$('.slider').each(function(){
				sliderInit(this);
			});
		});
    	$('.touch_disabled').remove();
    }else{
    	$('.touch_enabled').remove();
    	$('.touch_disabled').show();
    	pmButtonsPrep();
    	$('.plus_minus_bar').each(function(){
			pmBarInit(this);
		});
    }
    
    $(window).bind('orientationchange', deviceRotated);
    //$(window).bind('resize', deviceRotated);
	
});

function deviceRotated(){
	slidersPrep();
	$('.slider').each(function(){
		sliderInit(this);
	});
	$('.slider').each(function(){
		sliderId = $(this).attr("id");
		currentVal = $("#categories_"+sliderId).val();
		
		position = $('#' + sliderId + ' .slider_dot').position();
		position.left = (currentVal / stepPerPixel);
		$('#' + sliderId + ' .slider_dot').css('left', position.left);
    	$('#'+sliderId+' .slider_full').css('width',position.left + ($('.slider_dot').width()/2));	
	});
}

function slidersPrep(){
	$('.slider_dot').draggable({ containment: ".slider_empty", axis: "x", drag : dragging, stop: dragStopped });
	  	
	barWidth = $('.slider_empty').width() - $('.slider_empty').height();
 	  	
	$('.slider_full img').width($('.slider_empty img').width());
	$('.slider_full img').height($('.slider_empty img').height());
	  	
	positionDot();
	positionSlider();
	
}

function positionDot(){
	$('.slider_dot').each(function(){
		$('.slider_dot img').attr('width',$('.slider_empty').height()).attr('height',$('.slider_empty').height());
		$('.slider_dot').css('top','-3px');
	})
}

function positionSlider(){
	position = $('.slider_dot').position();
	$('.slider_full').each(function(){
		$('.slider_full').css('width',0);
	});
}

function sliderInit (sliderId) {
	maxSaving = $(sliderId).attr("data-max");
	sliderId = $(sliderId).attr("id");
	stepPerPixel = maxSaving / barWidth;
	categorySteps[sliderId] = stepPerPixel;
}

function dragging(){
	sliderId = $(this).parent().attr("id");
	position = $('#' + sliderId + ' .slider_dot').position();
	saving = position.left * categorySteps[sliderId];
	
    $('#'+sliderId+' .saving_number').html('<h2>&pound;<span>'+ Math.floor(saving) +'</span></h2>');
    $('#'+sliderId+' .slider_full').css('width',position.left + ($('.slider_dot').width()/2));
    
}

function dragStopped(){
	/** perform slider tracking */
	sliderId = $(this).parent().attr("id");
	position = $('#' + sliderId + ' .slider_dot').position();
	saving = position.left * categorySteps[sliderId];
	
    $('#'+sliderId+' .saving_number').html('<h2>&pound;<span>'+ Math.floor(saving) +'</span></h2>');
    $('#'+sliderId+' .slider_full').css('width',position.left + ($('.slider_dot').width()/2));
	
	
	$("#categories_"+sliderId).val($('#'+sliderId+' .saving_number h2 span').html());
	var categoryKVP = {
		category: sliderId,
		value : $('#touchForm input[name="categories[' + sliderId + ']"]').val()
	};
	$.post('http://dev.csmobi.cc/fuelsaver/services/' + UUID + '/slider-track', categoryKVP);
}

/* PLUS MINUS BUTTONS FOR NON-TOUCH DEVICES*/
var categoryMax = {};

function pmButtonsPrep(){
	
}

function pmBarInit(pmBarId){
	maxSaving = $(pmBarId).attr("data-max");
	barId = $(pmBarId).attr("id");
	stepInterval = 5;
	categoryMax[barId] = maxSaving;
}

var	currentNum;
var newNum;

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
	$.post('http://dev.csmobi.cc/fuelsaver/services/' + UUID + '/slider-track', categoryKVP);
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