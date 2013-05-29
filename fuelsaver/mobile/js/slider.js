window.sliderController = (function () {
	this.sliders = $('.slider');
	this.sliderDots = $('.slider_dot');
	this.sliderConfigs = {};
	this.stepIncrements = 5;
	
	this.init = function () {
		var self = this;
		$(window).bind('orientationchange resize', function (event) {
    		self.recalibrate ();
      	});
		$('.slider_full').css('width', 0);
		this.calibrate ();
		this.sliderDots.draggable({ 
			containment: ".slider_empty", 
			axis: "x", 
			grid: [this.stepPixels, 0],
			drag: this.dragging, 
			stop: this.dragStop,
			snap: true
		});
	};
	
	this.recalibrate = function () {
		this.calibrate();
		var self = this;
		this.sliders.each(function (index, element) {
			var slider = $(element);
			var value = parseInt (slider.find('.saving_number').find('h2').find('span').text());
			var currentStep = value / self.stepIncrements;
			slider.find('.slider_dot').css('left', currentStep * self.stepPixels);
			var dotPos = slider.find('.slider_dot').position();
			slider.find('.slider_full').css('width', dotPos.left + (self.dotWidth * 0.5));
		});
	};
	
	this.calibrate = function () {
		this.resizeDots ();
		this.calculateWidths ();
		this.calculateSteps ();
	};
	
	this.resizeDots = function () {
		var emptyHeight = $('.slider_empty').first().find('img').height();
		var dots = $('.slider_dot');
		dots.find('img')
		    .attr('width',  emptyHeight)
		    .attr('height', emptyHeight);
		var ah = emptyHeight;
		var ph = emptyHeight;
		var mh = (ph - ah) / 2;
		dots.css('top', mh);
	};
	
	this.calculateWidths = function () {
		this.dotWidth = $('.slider_dot').width();
		var placeholder = $('.slider_empty').first();
		this.barWidth = placeholder.width() - this.dotWidth;
		$('.slider_full img').width  (placeholder.find('img').width());
		$('.slider_full img').height (placeholder.find('img').height());
	};
	
	this.calculateSteps = function () {
		var firstSlider    = this.sliders.first ();
		this.maxSaving     = firstSlider.attr("data-max");
		this.numberOfSteps = this.maxSaving / this.stepIncrements;
		this.stepPixels    = this.barWidth / this.numberOfSteps;
	};
	
	/** these two are used as event delegates for the draggable configuration*/
	this.dragging = function (event) {
		drag($(this).parent());
	};
	this.dragStop = function (event) {
		stop($(this).parent());
	};
	
	this.drag = function (slider) {
		var position = slider.find('.slider_dot').position();
		var currentStep = Math.round(position.left / this.stepPixels); 
		var saving = currentStep *  this.stepIncrements;
		slider.find('.saving_number').html('<h2>&pound;<span>'+ Math.round(saving) +'</span></h2>');
		slider.find('.slider_full').css('width', position.left + (this.dotWidth * 0.5));
	};
	
	this.stop = function (slider) {
		this.drag(slider);
		var value = $(slider).find('.saving_number h2 span').html();
		$("#touch_categories_" + $(slider).attr('id')).val(value);
		var categoryKVP = {category: $(slider).attr('id'), value : value};
		$.post('/fuelsaver/services/' + window.UUID + '/slider-track', categoryKVP);
	};
	
	return this;
})();

