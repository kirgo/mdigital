// // // //////////////////////////////////////////////////////////////////////////
//
// CANDYSPACE
// Copyright 2012 CANDYSPACE
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // // // // //////////////////////////////////////////////////////////////////////
package com.candyspace.morrisonFuelSaver.mediator.view
{

	import flash.display.DisplayObject;
	import flash.display.Bitmap;
	import flash.text.TextFieldAutoSize;
	import com.candyspace.morrisonFuelSaver.model.vo.LocationSearchVO;
	import com.candyspace.morrisonFuelSaver.model.vo.StoreVO;
	import com.candyspace.morrisonFuelSaver.core.FSSettings;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------

	import com.candyspace.controls.event.CandyControlEvent;

	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.TextField;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class LocationResultView extends SingleButtonView
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		public static const TITLE_TEXTFIELD_NAME:String = "titleField";
		
		public static const ADDRESS_TEXTFIELD_NAME:String = "addressField";
		
		public static const TIMES_TEXTFIELD_NAME:String = "hoursField";
		
		public static const NEXT_BUTTON_NAME:String = "nextBttn";
		
		public static const PREV_BUTTON_NAME:String = "prevBttn";
		
		public static const MAP_NAME:String = "map";
		
		public static const MAP_CONTAINER_NAME:String = "mapContainer";
		
		public static const EMPTY_MAP_NAME:String = "emptyMap";

		
		protected var _titleField:TextField;
		
		protected var _addressField:TextField;
		
		protected var _timesField:TextField;
		
		protected var _nextButton:MovieClip;
		
		protected var _prevButton:MovieClip;
		
		protected var _displayResultCounter:int;		
		
		protected var _emptyMap:MovieClip;
		
		protected var _mapContainer:MovieClip;
		
		// true if map is been loaded as part of view setup procedure
		protected var _isFirstMap:Boolean = true;
		
		public function get stores():Vector.<StoreVO>
		{
			return (_vo as LocationSearchVO).results;
		}

		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function LocationResultView(name:String, displayObjectClassRef:Class)
		{
			super(name, displayObjectClassRef);
		}

		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		
		override protected function initVars():void
		{
			super.initVars();
			
			_titleField = displayObjectContainer.getChildByName(TITLE_TEXTFIELD_NAME) as TextField;
			
			_addressField = displayObjectContainer.getChildByName(ADDRESS_TEXTFIELD_NAME) as TextField;
			
			_timesField = displayObjectContainer.getChildByName(TIMES_TEXTFIELD_NAME) as TextField;
		
			_nextButton = displayObjectContainer.getChildByName(NEXT_BUTTON_NAME) as MovieClip;
		
			_prevButton = displayObjectContainer.getChildByName(PREV_BUTTON_NAME) as MovieClip;
			
			_mapContainer = (displayObjectContainer.getChildByName(MAP_NAME) as MovieClip)[MAP_CONTAINER_NAME];
			
			_emptyMap = _mapContainer[EMPTY_MAP_NAME] as MovieClip;
	 
	 
			// submit button is enable in the superclass
			enableButton(_nextButton);
			
			enableButton(_prevButton);
			
			enableButton(_mapContainer);

		}

		override protected function initEventListeners():void
		{
			super.initEventListeners();

			_nextButton.addEventListener(MouseEvent.CLICK, onButtonAction);

			_prevButton.addEventListener(MouseEvent.CLICK, onButtonAction);
			
			_mapContainer.addEventListener(MouseEvent.CLICK, onButtonAction);

		}	
		
		override protected function updateDisplay():void
		{			
			dispatchEvent(new Event("requestInitialMap"));
		}
		
		override public function updateDisplayData(vo:*):void
		{
			_vo = vo;
			
			var stores:Vector.<StoreVO> = (_vo as LocationSearchVO).results;
			var storeVO:StoreVO = stores[_displayResultCounter];

			updateDisplay();		
			
			updateProcessComplete();
		}
		
		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		
		public function showMap(map:DisplayObject):void
		{
			var k:int = _mapContainer.numChildren;
			while( k-- )
			{
				_mapContainer.removeChildAt( k );
			}
			
			_mapContainer.addChild(map);
			
			if(_isFirstMap)
			{
				updateProcessComplete();
				_isFirstMap = false;	
			}
		}		
		
		public function showNextResult():void
		{
			_displayResultCounter++;
			
			if(_displayResultCounter > 2)
			{
				_displayResultCounter = 0;
			}
			
			showNewResult(_displayResultCounter);
		}
		
		public function showPrevResult():void
		{
			_displayResultCounter--;
			
			if(_displayResultCounter < 0)
			{
				_displayResultCounter = 2;
			}
			
			showNewResult(_displayResultCounter);
		}
		
		public function showNewResult(counter:int):void
		{
			var stores:Vector.<StoreVO> = (_vo as LocationSearchVO).results;
			var pc:String = (_vo as LocationSearchVO).postcodeQuerry;
			
			var storeVO:StoreVO = stores[counter];
			
			_titleField.text = getFormatedTitleString(pc);
			
			_addressField.htmlText = getFormatedAddressString(storeVO);
			
			_timesField.htmlText = getFormatedOpeningTimesString(storeVO);
		}
		
		// --------------------------------------
		// Methods - Protected
		// --------------------------------------		
		
		protected function getFormatedTitleString(pc:String):String
		{
			return  "3 results near " + pc;			
		}
		
		protected function getFormatedAddressString(vo:StoreVO):String
		{
			var address:String = vo.street + "<br />";
			
			if(vo.city)
			{
				address += vo.city + "<br />";
			}
				
			if(vo.postcode)
			{
				address += vo.postcode + "<br />";
			}

			if(vo.tel)
			{
				address += "<br />";
				address += vo.tel;
			}
			
			return address;
		}
		
		protected function getFormatedOpeningTimesString(vo:StoreVO):String
		{
			var timeString:String = "";
			
			var dayNames:Vector.<String> = new <String>["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
			
			var times:Vector.<String> = vo.openingTimes;
			
			for (var i:int = 0; i < times.length; i++) 
			{
				timeString += dayNames[i] + " - " + times[i] + "<br />";
			}

			return timeString;
		}

	}
}