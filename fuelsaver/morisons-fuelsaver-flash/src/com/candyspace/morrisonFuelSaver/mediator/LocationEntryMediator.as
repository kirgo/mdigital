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
	import com.candyspace.morrisonFuelSaver.mediator.view.LocationEntryView;
	import com.candyspace.puremvc.events.ButtonActionEvent;

	import org.puremvc.as3.multicore.interfaces.INotification;

	import flash.utils.getQualifiedClassName;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	
	/**
	 * Class Comment
	 */
	public class LocationEntryMediator extends SuperOneButtonMediator
	{
		
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		/**
		 * Returns the full name of the mediator (including packages to insure that the name is unique).
		 */
		public static function get NAME():String
		{
			return getQualifiedClassName(LocationEntryMediator);
		}
		
		
		private function get view():LocationEntryView
		{
			return viewComponent as LocationEntryView;
		}

		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function LocationEntryMediator(viewComponent:Object = null)
		{
			super(LocationEntryMediator.NAME, viewComponent);
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
		
		override public function listNotificationInterests() : Array 
		{
			var interests:Array = super.listNotificationInterests();

			interests.push(FSNotifications.instance.RESET_APPLICATION);

			return interests;
		}
		
		
		override public function handleNotification(notification : INotification) : void 
		{
			super.handleNotification(notification);
			
			switch (notification.getName()) 
			{ 
				case FSNotifications.instance.RESET_APPLICATION: 
					trace( "value0 was selected" ); 
					resetView();
					break; 			  
				default: 
					trace( "Defaulting: neither value0 or value1 evaluated." );
			}
		}
		
		override protected function onViewClick(event:ButtonActionEvent):void
		{
			sendNotification(FSNotifications.instance.USER_ACTION, view.getPoscode(), FSUserActions.FIND_NEAREST);
		}

		// --------------------------------------
		// Methods - Protected
		// --------------------------------------
		
		protected function resetView():void
		{
			view.resetPostcodeField();
		}

	}
}