// // ////////////////////////////////////////////////////////////////////////////
//
// CANDYSPACE
// Copyright 2012 CANDYSPACE
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // ////////////////////////////////////////////////////////////////////////////
package com.candyspace.puremvc.model
{

	import com.candyspace.puremvc.view.TracerView;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import com.candyspace.morrisonFuelSaver.core.FSApplicationLayers;
	import com.candyspace.morrisonFuelSaver.core.FSNotifications;
	import com.candyspace.morrisonFuelSaver.core.FSUserActions;
	import com.candyspace.morrisonFuelSaver.mediator.view.FSMenuView;
	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.puremvc.events.ButtonActionEvent;
	import com.candyspace.puremvc.mediator.SuperMediator;
	import com.candyspace.puremvc.view.IView;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------
	


	// --------------------------------------
	// CLASS
	// --------------------------------------
	
	/**
	 * Class Comment
	 */
	public class TraceMediator extends SuperMediator
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		/**
		 * Returns the full name of the mediator (including packages to insure that the name is unique).
		 */
		public static function get NAME():String
		{
			return getQualifiedClassName(TraceMediator);
		}
		
		private function get view():IView
		{
			return viewComponent as IView;
		}
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function TraceMediator(viewComponent:Object = null)
		{
			super(TraceMediator.NAME, viewComponent);
		}
		
		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		
		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		
		// TODO TESTING ONLY
		override public function onRegister():void
		{
			super.onRegister();
			trace("=================  This mediator has been registered :: \t", NAME);
		}
		
		
		override public function listNotificationInterests():Array
		{
			return [Notifications.instance.TRACE];
		}
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName()) { 
				case Notifications.instance.TRACE: 
					(view as TracerView).addTrace(String(notification.getBody()));
					break; 			  
				default: 
					trace( "Defaulting: neither value0 or value1 evaluated." );
			}
		}
		
		override protected function addViewsStartup():void
		{
			// adds view to the display init procedure
			trace("BackgroundMediator :: addViewsStartup :: Sending Register view startup notification");
			sendNotification(Notifications.instance.REGISTER_VIEW_FOR_STARTUP,
							{
								child: view
							},
							FSApplicationLayers.instance.WARNING
							);
		}
		
		
		override protected function initEventListener():void
		{
			super.initEventListener();
		}

		// --------------------------------------
		// Event handlers
		// --------------------------------------
		
	}
}