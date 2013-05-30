// // // //////////////////////////////////////////////////////////////////////////
//
// CANDYSPACE
// Copyright 2012 CANDYSPACE
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // // //////////////////////////////////////////////////////////////////////////
package com.candyspace.morrisonFuelSaver.mediator.view
{
	import flash.display.SimpleButton;

	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;


	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Base class for the Menu buttons
	 */
	public class FuelSaverButton extends MovieClip implements IFuelSaverButton
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		private static const ON:String = "on";
		
		private static const OFF:String = "off";
		
		protected static const DOWN_BACKGROUND_Y:Number = -47.2;
		
		
		public var bg:MovieClip;
		
		public var icon:MovieClip;
		
		public var bttn:SimpleButton;
		
		
		protected var _originalBgY:Number;
		
		protected var _isSelected:Boolean = false;

		// --------------------------------------
		// Constructor
		// --------------------------------------
		public function FuelSaverButton()
		{
			_originalBgY = bg.y;
			initEventListener();
		}

		// --------------------------------------
		// Methods - Init
		// --------------------------------------
		
		private function initEventListener():void
		{
			bttn.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);

			bttn.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);

			bttn.addEventListener(MouseEvent.CLICK, onMouseClicked);
		}

		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		
		public function select():void
		{
			onMouseClicked();
			TweenLite.killTweensOf(bg);
			bg.y = DOWN_BACKGROUND_Y;
		}
		
		public function deselect():void
		{
			if(_isSelected)
			{
				_isSelected = false;
				bg.gotoAndStop(OFF);
				icon.gotoAndStop(OFF);
				bttn.useHandCursor = true;
				onMouseOut();
				bttn.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
		}

		// --------------------------------------
		// Event handlers
		// --------------------------------------
		
		private function onMouseClicked(event:MouseEvent = null):void
		{
			if(!_isSelected)
			{
				_isSelected = true;
				bg.gotoAndStop(ON);
				icon.gotoAndStop(ON);
				bttn.useHandCursor = false;
				bttn.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
		}

		private function onMouseOut(event:MouseEvent = null):void
		{
			TweenLite.to(bg, 1, {y:_originalBgY, ease:Strong.easeOut});
		}

		private function onMouseOver(event:MouseEvent):void
		{
			TweenLite.to(bg, 1, {y:DOWN_BACKGROUND_Y, ease:Strong.easeOut});
		}
	}
}
