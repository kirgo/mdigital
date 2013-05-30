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
	public class SharingView extends SingleButtonView
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		public static const CODE_TEXTFIELD_NAME:String = "codeField";
		
		public static const FACEBOOK_BUTTON_NAME:String = "facebookBttn";
		
		public static const TWITTER_BUTTON_NAME:String = "twitterBttn";
		
		public static const FACEBOOK_FIELD_NAME:String = "facebookField";
		
		public static const TWITTER_FIELD_NAME:String = "twitterField";

		
		protected var _codeField:TextField;
		
		protected var _facebookButton:MovieClip;
		
		protected var _twitterButton:MovieClip;
		
		protected var _facebookField:TextField;
		
		protected var _twitterField:TextField;

		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function SharingView(name:String, displayObjectClassRef:Class)
		{
			super(name, displayObjectClassRef);
		}
		
		public function reset():void
		{
			if(_bttn)
			{
				enableButton(_bttn, true);				
			}
		}
		
		public function setEmbedCodeField(code:String):void
		{
			_codeField.text = code;
		}

		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		
		override protected function initVars():void
		{
			super.initVars();
			
			_codeField = displayObjectContainer.getChildByName(CODE_TEXTFIELD_NAME) as TextField;
			
			_facebookField = displayObjectContainer.getChildByName(FACEBOOK_FIELD_NAME) as TextField;
			
			_twitterField = displayObjectContainer.getChildByName(TWITTER_FIELD_NAME) as TextField;
		
			_facebookButton = displayObjectContainer.getChildByName(FACEBOOK_BUTTON_NAME) as MovieClip;
		
			_twitterButton = displayObjectContainer.getChildByName(TWITTER_BUTTON_NAME) as MovieClip;
			
			// submit button is enable in the superclass
			enableButton(_facebookButton);
			
			enableButton(_twitterButton);
			
			_facebookField.styleSheet = FSConstants.linkStyle;
			_facebookField.htmlText = "Like Morrisons on Facebook <a href='event:facebook'>here</a>";
			_twitterField.styleSheet = FSConstants.linkStyle;
			_twitterField.htmlText = "Follow Morrisons on Twitter <a href='event:twitter'>here</a>";


			// init textfield
			_codeField.text = FSConstants.SHARING_EMBED_CODE;

		}

		override protected function initEventListeners():void
		{
			super.initEventListeners();

			_facebookButton.addEventListener(MouseEvent.CLICK, onButtonAction);

			_twitterButton.addEventListener(MouseEvent.CLICK, onButtonAction);
			
			_facebookField.addEventListener(TextEvent.LINK, onTermsClicked);
			
			_twitterField.addEventListener(TextEvent.LINK, onTermsClicked);
			
		}

		private function onTermsClicked(event:TextEvent):void
		{
			trace(event.text, event.type);
			
			var buttonActionEvent:ButtonActionEvent = new ButtonActionEvent(ButtonActionEvent.ACTION);
			buttonActionEvent.event = event;
			switch (event.text) { 
				case "facebook": 
					trace( "facebook was selected" ); 
					buttonActionEvent.buttonName = FACEBOOK_FIELD_NAME;
					break; 			  
				case "twitter": 
					trace( "twitter was selected" ); 
					buttonActionEvent.buttonName = TWITTER_FIELD_NAME;
					break; 
				default: 
					trace( "SharingView :: add implementation for link :: " + event.text);
			}
			dispatchEvent(buttonActionEvent);
		}

		
	}
}