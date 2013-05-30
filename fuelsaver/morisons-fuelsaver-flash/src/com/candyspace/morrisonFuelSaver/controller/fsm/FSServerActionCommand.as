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
package com.candyspace.morrisonFuelSaver.controller.fsm
{
	
	/**
	 * @author Carlos D. Rodriguez
	 */
	 
	// --------------------------------------
	// IMPORTS
	// --------------------------------------
	
	import com.candyspace.morrisonFuelSaver.core.FSActions;
	import com.candyspace.morrisonFuelSaver.mediator.RegistrationEntryMediator;
	import com.candyspace.morrisonFuelSaver.model.CalculatorProxy;
	import com.candyspace.morrisonFuelSaver.model.EmailProxy;
	import com.candyspace.morrisonFuelSaver.model.LocationProxy;

	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.utilities.statemachine.StateMachine;

	import flash.utils.getQualifiedClassName;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class FSServerActionCommand extends SimpleCommand
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		protected var _calculatorProxy:CalculatorProxy;

		protected function get calculatorProxy():CalculatorProxy
		{
			if (!_calculatorProxy)
			{
				_calculatorProxy = facade.retrieveProxy(CalculatorProxy.NAME) as CalculatorProxy;
				if (!_calculatorProxy)
				{
					trace(getQualifiedClassName(this) + "::execute - could not retrieve money proxy. Command will not execute.");
				}
			}

			return _calculatorProxy;
		}

		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		override public function execute(notification:INotification):void
		{

			switch (notification.getType())
			{
				case FSActions.instance.CALCULATE:
				{
					//trace("FSServerActionCommand :: CALCULATE");
					calculatorProxy.sendCalculationRequest();
					
					sendNotification(StateMachine.ACTION, null, FSActions.instance.CALCULATE);
					break;
				}
				case FSActions.instance.RETRIEVE_MAP:
				{
					//trace("FSServerActionCommand :: RETRIEVE_MAP");
					var mapProxy:LocationProxy = facade.retrieveProxy(LocationProxy.NAME) as LocationProxy;
					var postcode:String = String(notification.getBody());
					
					mapProxy.sendLocationRequest(postcode);
					
					sendNotification(StateMachine.ACTION, null, FSActions.instance.RETRIEVE_MAP);
					break;
				}
				case FSActions.instance.SUBMIT_REGISTRATION:
				{
					//trace("FSServerActionCommand :: SUBMIT_REGISTRATION");
					var regMediator:RegistrationEntryMediator = facade.retrieveMediator(RegistrationEntryMediator.NAME) as RegistrationEntryMediator;					
					var emailProxy:EmailProxy = facade.retrieveProxy(EmailProxy.NAME) as EmailProxy;
					
					emailProxy.sendRegistrationRequest(regMediator.getEmail(), regMediator.getOptin());
					
					sendNotification(StateMachine.ACTION, null, FSActions.instance.SUBMIT_REGISTRATION);
					break;
				}
				default:
					trace("FSServerActionCommand :: Add implementation for this action :: " + notification.getType());
			}
		}
	}
}
