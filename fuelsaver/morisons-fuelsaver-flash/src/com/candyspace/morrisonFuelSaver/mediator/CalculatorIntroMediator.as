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
package com.candyspace.morrisonFuelSaver.mediator
{
	
	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------
	
	import com.candyspace.morrisonFuelSaver.core.FSApplicationLayers;
	import com.candyspace.morrisonFuelSaver.core.FSNotifications;
	import com.candyspace.morrisonFuelSaver.core.FSUserActions;
	import com.candyspace.morrisonFuelSaver.mediator.view.CalculatorIntroView;
	import com.candyspace.morrisonFuelSaver.mediator.view.SingleButtonView;
	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.puremvc.events.ButtonActionEvent;
	import com.candyspace.puremvc.events.ViewEvent;

	import flash.utils.getQualifiedClassName;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	
	/**
	 * Class Comment
	 */
	public class CalculatorIntroMediator extends SuperOneButtonMediator
	{
		
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		/**
		 * Returns the full name of the mediator (including packages to insure that the name is unique).
		 */
		public static function get NAME():String
		{
			return getQualifiedClassName(CalculatorIntroMediator);
		}
		
		private function get view():SingleButtonView
		{
			return viewComponent as SingleButtonView;
		}

		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function CalculatorIntroMediator(viewComponent:Object = null)
		{
			super(CalculatorIntroMediator.NAME, viewComponent);
		}

		// --------------------------------------
		// Methods - Init
		// --------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			//trace("=================  This mediator has been registered :: \t", NAME);
		}
		
		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		
		override protected function addViewsStartup():void
		{
			// adds view to the display init procedure
			sendNotification(Notifications.instance.REGISTER_VIEW_FOR_STARTUP, {child:view}, FSApplicationLayers.instance.DYNAMIC);
		}

		override protected function onViewClick(event:ButtonActionEvent):void
		{
			switch (event.buttonName) { 
				case CalculatorIntroView.TERMS_TEXTFIELD_NAME: 
					//trace( "value0 was selected" ); 
					sendNotification(FSNotifications.instance.USER_ACTION, null, FSUserActions.SHOW_TC);
					break; 			  
				case SingleButtonView.SUBMIT_BUTTON_NAME: 
					//trace( "value1 was selected" ); 
					sendNotification(FSNotifications.instance.USER_ACTION, null, FSUserActions.OPEN_CALCULATOR);
					break; 
				default: 
					trace( "CalculatorIntroMediator :: add implementation for button :: " + event.buttonName);
			}
		}

	}
}