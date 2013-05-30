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
	import com.candyspace.morrisonFuelSaver.core.FSSettings;


	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------
	
	import com.candyspace.puremvc.events.ButtonActionEvent;
	import com.candyspace.puremvc.view.AbstractView;
	import com.candyspace.puremvc.view.IView;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class FSMenuView extends AbstractView implements IView
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		// ASSETS NAMES
		
		public static const LOGO_BUTTON_NAME:String = "logo";
		
		public static const CALCULATOR_BUTTON_NAME:String = "calculatorBttn";
		
		public static const REGISTRATION_BUTTON_NAME:String = "registrationBttn";
		
		public static const LOCATION_BUTTON_NAME:String = "locationBttn";
		
		public static const SHARING_BUTTON_NAME:String = "sharingBttn";
		
		// ASSETS REF.
		
		protected var _logo:MovieClip;
		
		protected var _calculatorButton:MovieClip;
		
		protected var _locationButton:MovieClip;
		
		protected var _registrationButton:MovieClip;
		
		protected var _sharingButton:MovieClip;
		
		protected var _buttons:Vector.<MovieClip>;
		
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function FSMenuView(name:String, displayObjectClassRef:Class)
		{
			super(name, displayObjectClassRef, null,  orientation);
		}
		
		// --------------------------------------
		// Methods - Init
		// --------------------------------------
		
		override protected function initVars():void
		{
			super.initVars();
			
			_buttons = new Vector.<MovieClip>();

			display.x = 22;

			display.y = 6;

			_logo = displayObjectContainer.getChildByName(LOGO_BUTTON_NAME) as MovieClip;
			_buttons.push(_logo);
			enableButton(_logo);
			

			_calculatorButton = displayObjectContainer.getChildByName(CALCULATOR_BUTTON_NAME) as FuelSaverButton;
			_buttons.push(_calculatorButton);

			_locationButton = displayObjectContainer.getChildByName(LOCATION_BUTTON_NAME) as FuelSaverButton;
			_buttons.push(_locationButton);

			_registrationButton = displayObjectContainer.getChildByName(REGISTRATION_BUTTON_NAME) as FuelSaverButton;
			_buttons.push(_registrationButton);

			_sharingButton = displayObjectContainer.getChildByName(SHARING_BUTTON_NAME) as FuelSaverButton;
			_buttons.push(_sharingButton);
			
			
			_calculatorButton.select();
			
//			if(FSSettings.instance.enabledMenu)
//			{
//				//showMenuBar(true);
//			}
//			else
//			{
//				//showMenuBar(false);
//			}

		}
		
		
		override protected function initEventListeners():void
		{
			super.initEventListeners();
			
			for (var i:int = 0; i < _buttons.length; i++) 
			{
				_buttons[i].addEventListener(MouseEvent.CLICK, onButtonAction);
			}
		}

		// --------------------------------------
		// Methods - Protected
		// --------------------------------------
		
		public function showMenuBar(enabled:Boolean):void
		{
			_calculatorButton.visible = enabled;	
			_locationButton.visible = enabled;	
			_registrationButton.visible = enabled;	
			_sharingButton.visible = enabled;	
		}
		
		protected function deselectAllOtherButtons(button:MovieClip):void
		{
			for (var i:int = 0; i < _buttons.length; i++) 
			{
				if(_buttons[i] is IFuelSaverButton && _buttons[i] != button)
				{
					(_buttons[i] as IFuelSaverButton).deselect();
				}
			}
		}
		
		protected function enableButton(button:MovieClip, enabled:Boolean = true):void
		{
			if (enabled)
			{
				button.mouseEnabled = true;
				button.buttonMode = true;

				
			}
			else
			{
				button.mouseEnabled = false;
				button.buttonMode = false;
			}
		}

		// --------------------------------------
		// Event handlers
		// --------------------------------------
		
		private function onButtonAction(event:MouseEvent):void
		{
			deselectAllOtherButtons(event.target.parent as MovieClip);
			
			var actionEvent:ButtonActionEvent = new ButtonActionEvent(ButtonActionEvent.ACTION);
			actionEvent.event = event;
			actionEvent.buttonName = event.target.parent.name;
			
			if(actionEvent.buttonName == LOGO_BUTTON_NAME)
			{
				(_calculatorButton as IFuelSaverButton).select();
			}
			dispatchEvent(actionEvent);
		}
	}
}