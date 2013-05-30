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

	import com.candyspace.controls.event.CandyControlEvent;
	import com.candyspace.morrisonFuelSaver.core.FSNotifications;
	import com.candyspace.morrisonFuelSaver.core.FSUserActions;
	import com.candyspace.morrisonFuelSaver.mediator.view.CalculatorView;
	import com.candyspace.morrisonFuelSaver.model.CalculatorProxy;
	import com.candyspace.puremvc.events.ButtonActionEvent;
	import com.candyspace.puremvc.view.IView;

	import org.puremvc.as3.multicore.interfaces.INotification;

	import flash.utils.getQualifiedClassName;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	
	/**
	 * Class Comment
	 */
	public class CalculatorMediator extends SuperOneButtonMediator
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		/**
		 * Returns the full name of the mediator (including packages to insure that the name is unique).
		 */
		public static function get NAME():String
		{
			return getQualifiedClassName(CalculatorMediator);
		}

		
		private function get view():IView
		{
			return viewComponent as IView;
		}
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function CalculatorMediator(viewComponent:Object = null)
		{
			super(CalculatorMediator.NAME, viewComponent);
		}

		// --------------------------------------
		// Methods - Init
		// --------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			//trace("=================  This mediator has been registered :: \t", NAME);			
		}
		
		override protected function initEventListener():void
		{
			super.initEventListener();
			
			view.addEventListener(CandyControlEvent.COMPLETE, onSliderUpdate);
		}
		
		override protected function setInitialData():*
		{
			var calculatorProxy:CalculatorProxy = facade.retrieveProxy(CalculatorProxy.NAME) as CalculatorProxy;
			
			if (calculatorProxy && calculatorProxy.getAllCategoriesVector())
			{
				return calculatorProxy.getAllCategoriesVector();
			}
			
			return null;
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
					resetView();
					break; 			  
				default: 
					trace( "Defaulting: neither value0 or value1 evaluated." );
			}
		}

		override protected function onViewClick(event:ButtonActionEvent):void
		{
			sendNotification(FSNotifications.instance.USER_ACTION, null, FSUserActions.CALCULATE);
		}
		
		// --------------------------------------
		// Methods - Protected
		// --------------------------------------
		
		protected function resetView() : void 
		{
			(view as CalculatorView).resetView();
		}
		// --------------------------------------
		// Event handlers
		// --------------------------------------
		
		private function onSliderUpdate(event:CandyControlEvent):void
		{
			var data:Object = {
								 name:event.propertyName,
					 			 value:event.propertyValue
				  			  };
							  
			sendNotification(FSNotifications.instance.USER_ACTION, data, FSUserActions.CHANGE_CALCULATOR_ITEM);
		}
	}
}