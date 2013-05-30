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
	import com.candyspace.morrisonFuelSaver.model.vo.CalculatorCategoryVO;

	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**
	 * adds categories to the calculator proxy at setup on receiving config file
	 */
	public class AddCalculatorCategoryCommand extends SimpleCommand
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
			
			var calculatorCategoryVO:CalculatorCategoryVO = notification.getBody() as CalculatorCategoryVO;

			var calculatorProxy:CalculatorProxy = facade.retrieveProxy(CalculatorProxy.NAME) as CalculatorProxy;
			
			calculatorProxy.addCategory(calculatorCategoryVO);			
			
		}
	}
}