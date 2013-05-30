 // // ////////////////////////////////////////////////////////////////////////////
//
// CANDYSPACE
// Copyright 2012 CANDYSPACE
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // // // ////////////////////////////////////////////////////////////////////////
package com.candyspace.morrisonFuelSaver.mediator.view
{

	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------

	import com.candyspace.controls.event.CandyControlEvent;
	import com.candyspace.morrisonFuelSaver.model.vo.CalculatorCategoryVO;

	import flash.display.DisplayObject;
	import flash.text.TextField;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	
	/**
	 * Class Comment
	 */
	public class CalculatorView extends SingleButtonView
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		public static const SLIDER_NAME_PREFIX:String = "slider00";
		
		public static const TITLE_NAME_PREFIX:String = "title00";
		
		public static const VALUE_TEXTFIELD_NAME_PREFIX:String = "valueField00";
		

		protected var _sliderSetupCounter:int = 1;
		
		protected var _sliders:Vector.<FuelCalculatorSlider>;
		
		protected var _valueTextfields:Vector.<TextField>;
		
		
		public function set vo(value:*):void
		{
			_vo = value;
		}
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function CalculatorView(name:String, displayObjectClassRef:Class)
		{
			super(name, displayObjectClassRef);
		}
		
		// --------------------------------------
		// Methods - Init
		// --------------------------------------
		
		protected function initAssets():void
		{
			var categories:Vector.<CalculatorCategoryVO> = _vo as Vector.<CalculatorCategoryVO>;
			
			for (var i:int = 0; i < categories.length; i++) 
			{
				setNextSlider(categories[i].name, int(categories[i].maxLimit));
			}
		}
		
		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		
		override protected function initVars():void
		{
			super.initVars();
			
			_sliders = new Vector.<FuelCalculatorSlider>();
			
			_valueTextfields = new Vector.<TextField>();			
		}

		override protected function updateDisplay():void
		{
			initAssets();
			
			addTextfieldToSliders();
		}
		

		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		
		public function resetView():void
		{
			if(_sliders)
			{
				for (var i:int = 0; i < _sliders.length; i++) 
				{
					_sliders[i].resetValue();
				}
			}
		}
		
		public function setNextSlider(name:String, maxValue:int):void
		{
			var currentChild:DisplayObject;
			var counterString:String;
			
			for (var i:int = 0; i < displayObjectContainer.numChildren; i++) 
			{
				currentChild = displayObjectContainer.getChildAt(i);
				
				counterString = "00" + _sliderSetupCounter;
				
				if(currentChild.name.indexOf(counterString) > -1)
				{
					if(currentChild.name.indexOf(SLIDER_NAME_PREFIX) > -1)
					{
						(currentChild as FuelCalculatorSlider).setValueRange(maxValue);
						(currentChild as FuelCalculatorSlider).setPropertyName(name);
						currentChild.addEventListener(CandyControlEvent.COMPLETE, onSliderAction);
						_sliders.push(currentChild as FuelCalculatorSlider);
					}
					if(currentChild.name.indexOf(TITLE_NAME_PREFIX) > -1)
					{
						(currentChild as TextField).text = getNoUnderscoreString(name);
					}
					if(currentChild.name.indexOf(VALUE_TEXTFIELD_NAME_PREFIX) > -1)
					{
						(currentChild as TextField).text = "£0";
						_valueTextfields.push(currentChild as TextField);
					}
				}
			}
			
			_sliderSetupCounter++;
		}
		
		// --------------------------------------
		// Methods - Protected
		// --------------------------------------
		
		protected function addTextfieldToSliders() : void 
		{
			for (var i:int = 0; i < _sliders.length; i++) 
			{
				_sliders[i].addTextfieldRef(_valueTextfields[i], "£");
			}
		}
		
		protected function getNoUnderscoreString(str:String):String
		{
			return str.split('_').join(' ');
		}

		// --------------------------------------
		// Event handlers
		// --------------------------------------
		
		private function onSliderAction(event:CandyControlEvent):void
		{
			dispatchEvent(event);
		}
	}
}