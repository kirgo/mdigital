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

	import flash.utils.setTimeout;
	import com.candyspace.utils.logger.Logger;
	import com.candyspace.puremvc.core.Notifications;
	
	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------

	import com.candyspace.morrisonFuelSaver.core.FSNotifications;
	import com.candyspace.morrisonFuelSaver.core.FSUserActions;
	import com.candyspace.puremvc.events.ButtonActionEvent;

	import flash.utils.getQualifiedClassName;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	
	/**
	 * Class Comment
	 */
	public class RegistrationIntroMediator extends SuperOneButtonMediator
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		/**
		 * Returns the full name of the mediator (including packages to insure that the name is unique).
		 */
		public static function get NAME():String
		{
			return getQualifiedClassName(RegistrationIntroMediator);
		}

		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function RegistrationIntroMediator(viewComponent:Object = null)
		{
			super(RegistrationIntroMediator.NAME, viewComponent);
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
			sendNotification(FSNotifications.instance.USER_ACTION, null, FSUserActions.OPEN_REGISTRATION);	
		}
	}
}