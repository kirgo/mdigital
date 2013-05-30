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
	import com.candyspace.morrisonFuelSaver.core.FSConstants;
	import com.candyspace.puremvc.facade.IAppFacade;
	
	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------

	import com.candyspace.morrisonFuelSaver.core.FSNotifications;
	import com.candyspace.morrisonFuelSaver.core.FSSettings;
	import com.candyspace.morrisonFuelSaver.core.FSUserActions;
	import com.candyspace.morrisonFuelSaver.mediator.view.CalculatorResultsView;
	import com.candyspace.morrisonFuelSaver.model.CalculatorProxy;
	import com.candyspace.puremvc.events.ButtonActionEvent;

	import flash.utils.getQualifiedClassName;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	
	/**
	 * Class Comment
	 */
	public class CalculatorResultsMediator extends SuperOneButtonMediator
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		/**
		 * Returns the full name of the mediator (including packages to insure that the name is unique).
		 */
		public static function get NAME():String
		{
			return getQualifiedClassName(CalculatorResultsMediator);
		}
		
		private function get view():CalculatorResultsView
		{
			return viewComponent as CalculatorResultsView;
		}

		protected var calculatorProxy : CalculatorProxy;
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function CalculatorResultsMediator(viewComponent:Object = null)
		{
			super(CalculatorResultsMediator.NAME, viewComponent);
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
		
		
		override protected function initializedComplete():void
		{
			if((facade as IAppFacade).getParameter(FSConstants.CLOSE_LINK_PARAMETER_NAME, FSConstants.CLOSE_LINK_PARAMETER_DEFAULT_VALUE) == "true")
			{
				view.resetButtonLabel();
			}
		}
		
		override protected function onViewClick(event:ButtonActionEvent):void
		{
			if((facade as IAppFacade).getParameter(FSConstants.CLOSE_LINK_PARAMETER_NAME, FSConstants.CLOSE_LINK_PARAMETER_DEFAULT_VALUE) == "true")
			{
				sendNotification(FSNotifications.instance.USER_ACTION, null, FSUserActions.CLOSE_APP);
			}
			else
			{
				sendNotification(FSNotifications.instance.USER_ACTION, null, FSUserActions.FINDOUT_MORE);
			}
		}
		
		override protected function setInitialData():*
		{
			calculatorProxy = facade.retrieveProxy(CalculatorProxy.NAME) as CalculatorProxy;
			
			return calculatorProxy.savings;
		}
		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		
		public function updateResult():void
		{			
			if((viewComponent as CalculatorResultsView).isInitialized)
			{
				view.updateDisplayData(calculatorProxy.savings)
			}
			else
			{
				showView();
			}
		}
	}
}