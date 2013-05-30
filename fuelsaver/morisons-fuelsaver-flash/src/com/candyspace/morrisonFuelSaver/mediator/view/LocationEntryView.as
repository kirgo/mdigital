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
	public class LocationEntryView extends SingleButtonView
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		public static const POSTCODE_REG_NOSPACE_ALLOWED:RegExp = /^(GIR 0AA|[A-PR-UWYZ]([0-9]{1,2}|([A-HK-Y][0-9]|[A-HK-Y][0-9]([0-9]|[ABEHMNPRV-Y]))|[0-9][A-HJKS-UW])\s?[0-9][ABD-HJLNP-UW-Z]{2})$/;
		
		public static const POSTCODE_REG_SPACEONLY:RegExp = /^([A-PR-UWYZ]([0-9]{1,2}|([A-HK-Y][0-9]|[A-HK-Y][0-9]([0-9]|[ABEHMNPRV-Y]))|[0-9][A-HJKS-UW])\ [0-9][ABD-HJLNP-UW-Z]{2}|(GIR\ 0AA)|(SAN\ TA1)|(BFPO\ (C\/O\ )?[0-9]{1,4})|((ASCN|BBND|[BFS]IQQ|PCRN|STHL|TDCU|TKCA)\ 1ZZ))$/;
		
		public static const POSTCODE_TEXTFIELD_NAME:String = "postcodeField";
		
		public static const POSTCODE_INITIAL_TEXT:String = "Postcode";
		
		protected var _postcodeField:TextField;

		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function LocationEntryView(name:String, displayObjectClassRef:Class)
		{
			super(name, displayObjectClassRef);
		}

		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		
		override protected function initVars():void
		{
			super.initVars();

			_postcodeField = displayObjectContainer.getChildByName(POSTCODE_TEXTFIELD_NAME) as TextField;

			_postcodeField.text = POSTCODE_INITIAL_TEXT;

			enableButton(_bttn, false);
		}

		override protected function initEventListeners():void
		{
			super.initEventListeners();

			_postcodeField.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);

			_postcodeField.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);

			_postcodeField.addEventListener(Event.CHANGE, onChange);
		}

		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		
		public function getPoscode():String
		{
			return removeSpaces(_postcodeField.text);
		}
		
		public function resetPostcodeField():void
		{
			if(_postcodeField)
			{
				_postcodeField.text = POSTCODE_INITIAL_TEXT;
			}
		}

		// --------------------------------------
		// Event handlers
		// --------------------------------------
		
		private function onChange(event:Event):void
		{
			var postcode:String = _postcodeField.text.toUpperCase();
			var postcodeExpression:RegExp = POSTCODE_REG_NOSPACE_ALLOWED;
			var isValid:Boolean = postcodeExpression.test(postcode);
			_postcodeField.text = postcode;

			enableButton(_bttn, isValid)
		}

		private function onFocusIn(event:FocusEvent):void
		{
			if (_postcodeField.text == POSTCODE_INITIAL_TEXT)
			{
				_postcodeField.text = "";
			}
		}

		private function onFocusOut(event:FocusEvent):void
		{
			if (_postcodeField.text == "")
			{
				_postcodeField.text = POSTCODE_INITIAL_TEXT;
			}
		}

		private function onTextFielAction(event:CandyControlEvent):void
		{
			dispatchEvent(event);
		}
	}
}