// // // // ////////////////////////////////////////////////////////////////////////
//
// CANDYSPACE
// Copyright 2012 CANDYSPACE
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // // // ////////////////////////////////////////////////////////////////////////
package com.candyspace.morrisonFuelSaver.mediator
{
	
	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------

	import com.candyspace.morrisonFuelSaver.core.FSNotifications;
	import com.candyspace.morrisonFuelSaver.core.FSUserActions;
	import com.candyspace.morrisonFuelSaver.mediator.view.SingleButtonView;
	import com.candyspace.morrisonFuelSaver.mediator.view.TermsConditionsView;
	import com.candyspace.puremvc.events.ButtonActionEvent;

	import flash.utils.getQualifiedClassName;
	
	// --------------------------------------
	// CLASS
	// --------------------------------------
	
	/**
	 * Class Comment
	 */
	public class TermsConditionsMediator extends SuperOneButtonMediator
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		/**
		 * Returns the full name of the mediator (including packages to insure that the name is unique).
		 */
		public static function get NAME():String
		{
			return getQualifiedClassName(TermsConditionsMediator);
		}
		
		public function get view():TermsConditionsView
		{
			return viewComponent as TermsConditionsView;
		}

		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function TermsConditionsMediator(viewComponent:Object = null)
		{
			super(TermsConditionsMediator.NAME, viewComponent);
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
		
		override protected function onViewClick(event:ButtonActionEvent):void
		{
			switch (event.buttonName) { 
				case TermsConditionsView.NEXT_BUTTON_NAME: 
					view.showNextPage();
					break; 			  
				case TermsConditionsView.PREV_BUTTON_NAME: 
					view.showPrevPage();
					break; 
				case "conditionsLink": 
					sendNotification(FSNotifications.instance.USER_ACTION, null, FSUserActions.FINDOUT_MORE);
					break; 
				case SingleButtonView.SUBMIT_BUTTON_NAME: 
					sendNotification(FSNotifications.instance.USER_ACTION, null, FSUserActions.SELECT_MENU_CALCULATOR);
					break; 
				default: 
					trace( "TermsConditionsMediator :: add implementation for button :: " + event.buttonName );
			}
		}

	}
}