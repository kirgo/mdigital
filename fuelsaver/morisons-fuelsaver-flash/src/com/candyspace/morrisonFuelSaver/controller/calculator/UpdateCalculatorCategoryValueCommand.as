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
package com.candyspace.morrisonFuelSaver.controller.calculator
{

	import com.candyspace.morrisonFuelSaver.model.CalculatorProxy;
	import com.candyspace.morrisonFuelSaver.model.TrackingProxy;

	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**
	 * update calculator category value
	 * on user interaction with the sliders
	 */

	public class UpdateCalculatorCategoryValueCommand extends SimpleCommand
	{
		// --------------------------------------
		// Methods - OVERRIDDEN
		// --------------------------------------
		/**
		 * @param	notification
		 */
		override public function execute(notification:INotification):void
		{
			super.execute(notification);
			
			var sliderName:String = notification.getBody().name;
			
			var sliderValue:Number = notification.getBody().value;
			
						
			// track slider used
			var trackinProxy:TrackingProxy = facade.retrieveProxy(TrackingProxy.NAME) as TrackingProxy;
			
			trackinProxy.sendSliderInteraction(sliderName, String(sliderValue));
			
			// update slider value in the proxy
			var calculatorProxy:CalculatorProxy = facade.retrieveProxy(CalculatorProxy.NAME) as CalculatorProxy;
			
			calculatorProxy.updateCategoryValue(sliderName, sliderValue);			
			
			//trace("UpdateCalculatorCategoryValueCommand :: execute :: ", sliderName, sliderValue);
		}
	}
}