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
	import com.candyspace.morrisonFuelSaver.core.FSConstants;
	
	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------

	import com.candyspace.morrisonFuelSaver.core.FSSettings;
	import com.candyspace.puremvc.events.ButtonActionEvent;

	import flash.events.TextEvent;
	import flash.text.TextField;


	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class CalculatorIntroView extends SingleButtonView
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		public static const TERMS_TEXTFIELD_NAME:String = "termsField";
		
		
		protected var _termsField:TextField;

		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function CalculatorIntroView(name:String, displayObjectClassRef:Class)
		{
			super(name, displayObjectClassRef);
		}

		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		
		override protected function initVars():void
		{
			super.initVars();
			
			_termsField = displayObjectContainer.getChildByName(TERMS_TEXTFIELD_NAME) as TextField;

			
			_termsField.styleSheet = FSConstants.linkStyle;
			_termsField.htmlText = "<a href='event:terms'>Fuel Saver Terms &amp; Conditions</a>";

		}

		override protected function initEventListeners():void
		{
			super.initEventListeners();

			_termsField.addEventListener(TextEvent.LINK, onTermsClicked);
			
		}

		// --------------------------------------
		// Event Handlers
		// --------------------------------------
		
		private function onTermsClicked(event:TextEvent):void
		{
			trace(event.text, event.type);
			
			var buttonActionEvent:ButtonActionEvent = new ButtonActionEvent(ButtonActionEvent.ACTION);
			buttonActionEvent.event = event;
			buttonActionEvent.buttonName = TERMS_TEXTFIELD_NAME;

			dispatchEvent(buttonActionEvent);
		}

	}
}