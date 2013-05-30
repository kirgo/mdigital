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
	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.puremvc.events.ButtonActionEvent;
	import com.candyspace.puremvc.mediator.SuperMediator;
	import com.candyspace.puremvc.view.IView;

	import flash.utils.getQualifiedClassName;
	
	// --------------------------------------
	// CLASS
	// --------------------------------------
	
	/**
	 * Class Comment
	 */
	public class SuperOneButtonMediator extends SuperMediator
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		/**
		 * Returns the full name of the mediator (including packages to insure that the name is unique).
		 */
		public static function get NAME():String
		{
			return getQualifiedClassName(SuperOneButtonMediator);
		}

		private function get view():IView
		{
			return viewComponent as IView;
		}

		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function SuperOneButtonMediator(mediatorName:String = null, viewComponent:Object = null)
		{
			super(mediatorName, viewComponent);
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

		override protected function initEventListener():void
		{
			super.initEventListener();

			view.addEventListener(ButtonActionEvent.ACTION, onViewClick);
		}

		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		
		public function showView():void
		{
			sendNotification(Notifications.instance.ADD_UNIQUE_VIEW, {child:view}, FSApplicationLayers.instance.DYNAMIC);
		}
		
		// --------------------------------------
		// Methods - Protected
		// --------------------------------------
		
		protected function onViewClick(event:ButtonActionEvent):void
		{
			throw new Error("SuperOneButtonMediator :: onViewClick :: Please override this method in your subclass");
		}
	}
}