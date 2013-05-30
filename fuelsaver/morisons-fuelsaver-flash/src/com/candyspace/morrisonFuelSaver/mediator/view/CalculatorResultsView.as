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

	import com.candyspace.morrisonFuelSaver.core.FSSettings;

	import flash.display.Sprite;
	import flash.text.TextField;


	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class CalculatorResultsView extends SingleButtonView
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		public static const FIND_OUT_MORE_LABEL_TEXT:String = "Find out more";

		public static const CLOSE_LABEL_TEXT:String = "Close";

		public static const SAVINGS_TEXTFIELD_NAME:String = "savingsField";
		

		protected var _savingsField:TextField;

		protected var _buttonLabel:TextField;

		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function CalculatorResultsView(name:String, displayObjectClassRef:Class)
		{
			super(name, displayObjectClassRef);
		}

		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		
		override protected function initVars():void
		{
			super.initVars();

			_savingsField = displayObjectContainer.getChildByName(SAVINGS_TEXTFIELD_NAME) as TextField;
			
			_buttonLabel =  (displayObjectContainer.getChildByName(SingleButtonView.SUBMIT_BUTTON_NAME) as Sprite).getChildByName("label") as TextField;

			
//			if(FSSettings.instance.closeLink)
//			{
//				initButtonLabel();
//				_bttn.visible = false;
//			}


			enableButton(_bttn, true);
		}
		
		override protected function updateDisplay():void
		{
			_savingsField.text = "£" + String(_vo);
		}
		
		// --------------------------------------
		// Methods - Public
		// --------------------------------------

		public function resetButtonLabel():void
		{
			_buttonLabel.text = CLOSE_LABEL_TEXT;
		}

	}
}