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

	import com.candyspace.controls.TwoStateEnableButtonMovieClip;
	import com.candyspace.puremvc.events.ButtonActionEvent;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	
	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------


	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class TermsConditionsView extends SingleButtonView
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		public static const COPY001_TEXTFIELD_NAME:String = "copy001";
		public static const COPY002_TEXTFIELD_NAME:String = "copy002";
		public static const COPY004_TEXTFIELD_NAME:String = "copy004";
		public static const COPY005_TEXTFIELD_NAME:String = "titles";
		
		public static const NEXT_BUTTON_NAME:String = "nextBttn";
		
		public static const PREV_BUTTON_NAME:String = "prevBttn";


		protected var _code001Field:TextField;
		protected var _code002Field:TextField;
		protected var _code004Field:TextField;
		protected var _code005Field:DisplayObject;
		
		protected var _nextButton:MovieClip;
		
		protected var _prevButton:MovieClip;

		protected var _pageOn:String;

		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function TermsConditionsView(name:String, displayObjectClassRef:Class)
		{
			super(name, displayObjectClassRef);
		}
		
		// --------------------------------------
		// Methods - Init
		// --------------------------------------
		
		override protected function initVars():void
		{
			super.initVars();
			
			_code001Field = displayObjectContainer.getChildByName(COPY001_TEXTFIELD_NAME) as TextField;
			_code002Field = displayObjectContainer.getChildByName(COPY002_TEXTFIELD_NAME) as TextField;
			_code004Field = displayObjectContainer.getChildByName(COPY004_TEXTFIELD_NAME) as TextField;
			_code005Field = displayObjectContainer.getChildByName(COPY005_TEXTFIELD_NAME);

			_nextButton = displayObjectContainer.getChildByName(NEXT_BUTTON_NAME) as MovieClip;
		
			_prevButton = displayObjectContainer.getChildByName(PREV_BUTTON_NAME) as MovieClip;
			
			showFirstPage();
		}
		
		
		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		
		public function showNextPage():void
		{
			switch (_pageOn) { 
				case "first": 
					showSecondPage(); 
					break; 			  
				case "second": 
					showThirdPage(); 
					break; 
				case "third": 
					showFirstPage(); 
					break; 
				default: 
					trace( "Defaulting: neither first or second evaluated." );
			}
		}
		
		public function showPrevPage():void
		{
			switch (_pageOn) { 
				case "first": 
					showThirdPage(); 
					break; 			  
				case "second": 
					showFirstPage(); 
					break; 
				case "third": 
					showSecondPage(); 
					break; 
				default: 
					trace( "Defaulting: neither first or second evaluated." );
			}
		}
		
		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------	

		override protected function initEventListeners():void
		{
			super.initEventListeners();

			_nextButton.addEventListener(MouseEvent.CLICK, onButtonAction);

			_prevButton.addEventListener(MouseEvent.CLICK, onButtonAction);
			
			_code004Field.addEventListener(TextEvent.LINK, onTermsClicked);
			
		}
		
		// --------------------------------------
		// Methods - Protected
		// --------------------------------------
		
		// not been used
		protected function getLinkedString(str:String):String
		{
			var url:String = "www.morrisonsfuelsaver.co.uk";
			
			var original:Array=str.split(url);
			return original.join ("<a href='event:condition'>www.morrisonsfuelsaver.co.uk</a>");
			
			return null;
		}
		
		protected function showFirstPage():void
		{
			_pageOn = "first";
			_code001Field.alpha = 1;
			_code002Field.alpha = 0;
			_code004Field.alpha = 0;
			_code005Field.alpha = 0;
			
			enableButton(_nextButton, true);
			enableButton(_prevButton, false);
		}
		
		protected function showSecondPage():void
		{
			_pageOn = "second";
			_code001Field.alpha = 0;
			_code002Field.alpha = 1;
			_code004Field.alpha = 0;
			_code005Field.alpha = 0;
			
			enableButton(_nextButton, true);
			enableButton(_prevButton, true);
		}
		
		protected function showThirdPage():void
		{
			_pageOn = "third";
			_code001Field.alpha = 0;
			_code002Field.alpha = 0;
			_code004Field.alpha = 1;
			_code005Field.alpha = 1;
			
			enableButton(_nextButton, false);
			enableButton(_prevButton, true);
		}
		
		// --------------------------------------
		// Event handlers - Overriden
		// --------------------------------------
		
		// not been used
		private function onTermsClicked(event:TextEvent):void
		{
			var buttonActionEvent:ButtonActionEvent = new ButtonActionEvent(ButtonActionEvent.ACTION);
			buttonActionEvent.event = event;
			buttonActionEvent.buttonName = "conditionsLink";
			dispatchEvent(buttonActionEvent);
		}

	}
}