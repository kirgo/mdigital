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
	import flash.text.TextFormat;
	import flash.text.StyleSheet;
	import com.candyspace.puremvc.events.ButtonActionEvent;
	import flash.events.TextEvent;
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
	public class RegistrationEntryView extends SingleButtonView
	{
		// --------------------------------------
		// Properties
		// --------------------------------------

		public static const EMAIL_TEXTFIELD_INITIAL_TEXT:String = "Email Address";
		
		public static const EMAIL_REG:RegExp = /^[0-9a-zA-Z][-._'a-zA-Z0-9]*@([0-9a-zA-Z][-._0-9a-zA-Z]*\.)+[a-zA-Z]{2,6}$/;
		
		
		
		public static const EMAIL_TEXTFIELD_NAME:String = "emailField";
		
		public static const MORE_INFO_CHECKBOX_NAME:String = "infoCheckBox";
		
		public static const AGREE_CHECKBOX_NAME:String = "agreeCheckBox";
		
		public static const SIGN_UP_FIELD_NAME:String = "signupLinkedField";
		
		public static const TERMS_CONDITIONS_FIELD_NAME:String = "termsLinkedField";

		
		protected var _emailField:TextField;
		
		protected var _moreInforCheckBox:MovieClip;
		
		protected var _agreeCheckBox:MovieClip;
		
		protected var _isEmailValid:Boolean;
		
		protected var _termsField : TextField;
		
		protected var _signupField : TextField;
		

		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function RegistrationEntryView(name:String, displayObjectClassRef:Class)
		{
			super(name, displayObjectClassRef);
		}

		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		
		override protected function initVars():void
		{
			super.initVars();
			
			_emailField = displayObjectContainer.getChildByName(EMAIL_TEXTFIELD_NAME) as TextField;
			
			_moreInforCheckBox = displayObjectContainer.getChildByName(MORE_INFO_CHECKBOX_NAME) as MovieClip;
		
			_agreeCheckBox = displayObjectContainer.getChildByName(AGREE_CHECKBOX_NAME) as MovieClip;
			
			
			_signupField = displayObjectContainer.getChildByName(SIGN_UP_FIELD_NAME) as TextField;
			
			_termsField = displayObjectContainer.getChildByName(TERMS_CONDITIONS_FIELD_NAME) as TextField;

			
			_termsField.styleSheet = FSConstants.linkStyle;
			_termsField.htmlText = "I agree to the <a href='event:terms'>terms &amp; conditions</a>";
			
			_signupField.styleSheet = FSConstants.linkStyle;
			_signupField.htmlText = "Yes, I'd like to hear from the <a href='event:signup'>Morrisons family</a>";


			_moreInforCheckBox.selected = true;
			
			_emailField.text = EMAIL_TEXTFIELD_INITIAL_TEXT;

			enableButton(_bttn, false);
		}

		override protected function initEventListeners():void
		{
			super.initEventListeners();

			_emailField.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);

			_emailField.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);

			_emailField.addEventListener(Event.CHANGE, onChange);
			
			_termsField.addEventListener(TextEvent.LINK, onTermsClicked);
			
			_signupField.addEventListener(TextEvent.LINK, onTermsClicked);

			_agreeCheckBox.addEventListener(CandyControlEvent.SELECTION_CHANGE, onAgreedChange);
		}


		// --------------------------------------
		// Methods = Public
		// --------------------------------------
		
		public function getEmailString():String
		{
			return _emailField.text;
		}
		
		public function getOptinValue():String
		{
			return _moreInforCheckBox.selected;
		}
		
		public function resetView():void
		{
			if(_emailField)
			{
				_emailField.text = EMAIL_TEXTFIELD_INITIAL_TEXT;
				
				_moreInforCheckBox.selected = true;
				
				_agreeCheckBox.selected = false;
			}
		}
		
		// --------------------------------------
		// Methods = Private
		// --------------------------------------
		
		private function checkValidation():void
		{
			if (_agreeCheckBox.selected && _isEmailValid)
			{
				enableButton(_bttn, true);
			}
			else
			{
				enableButton(_bttn, false);
			}
		}
		
		// --------------------------------------
		// Event handlers
		// --------------------------------------

		private function onChange(event:Event):void
		{
			var email:String = _emailField.text;
			var emailExpression:RegExp = EMAIL_REG;
			_isEmailValid = emailExpression.test(email);

			checkValidation();

		}

		private function onAgreedChange(event:CandyControlEvent):void
		{
			var isTermsAgreed:Boolean = Boolean(event.propertyValue);
			switch (event.propertyValue) { 
				case "true": 
					isTermsAgreed = true;
					break; 			  
				case "false": 
					isTermsAgreed = false;
					break; 
			}
			
			checkValidation();
		}

		private function onFocusIn(event:FocusEvent):void
		{
			if (_emailField.text == EMAIL_TEXTFIELD_INITIAL_TEXT)
			{
				_emailField.text = "";
			}
		}

		private function onFocusOut(event:FocusEvent):void
		{
			if (_emailField.text == "")
			{
				_emailField.text = EMAIL_TEXTFIELD_INITIAL_TEXT;
			}
		}	
		
		private function onTermsClicked(event:TextEvent):void
		{
			var buttonActionEvent:ButtonActionEvent = new ButtonActionEvent(ButtonActionEvent.ACTION);
			buttonActionEvent.event = event;
			
			switch (event.text) 
			{ 
				case "terms": 
					trace( "facebook was selected" ); 
					buttonActionEvent.buttonName = TERMS_CONDITIONS_FIELD_NAME;
					break; 			  
				case "signup": 
					trace( "twitter was selected" ); 
					buttonActionEvent.buttonName = SIGN_UP_FIELD_NAME;
					break; 
				default: 
					trace( "RegistrationEntryView :: add implementation for link :: " + event.text );
			}

			dispatchEvent(buttonActionEvent);
		}
		
	}
}