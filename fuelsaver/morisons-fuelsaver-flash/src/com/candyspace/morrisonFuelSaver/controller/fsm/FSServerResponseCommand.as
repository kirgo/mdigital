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
	import com.candyspace.morrisonFuelSaver.mediator.CalculatorResultsMediator;
	import com.candyspace.morrisonFuelSaver.mediator.LocationResultsMediator;
	import com.candyspace.morrisonFuelSaver.mediator.RegistrationConfirmationMediator;

	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.utilities.statemachine.StateMachine;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class FSServerResponseCommand extends SimpleCommand
	{
		// --------------------------------------
		// Properties
		// --------------------------------------


		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		override public function execute(notification:INotification):void
		{
			// check notification name
			var name:String = notification.getName();
			
			// parse data accordantly, store it (if need it) & send it in a notification
			switch (notification.getType())
			{
				case FSActions.instance.CALCULATION_RECEIVED:
				{
					trace("FSServerActionCommand :: CALCULATION_RECEIVED");

					var calculatorResultsMediator:CalculatorResultsMediator = facade.retrieveMediator(CalculatorResultsMediator.NAME) as CalculatorResultsMediator;
					calculatorResultsMediator.updateResult();
					
					sendNotification(StateMachine.ACTION, null, FSActions.instance.CALCULATION_RECEIVED);
					break;
				}
				case FSActions.instance.REGISTRATION_CONFIRMATION_RECEIVED:
				{
					trace("FSServerActionCommand :: REGISTRATION_CONFIRMATION_RECEIVED");

					var registrationConfirmationMediator:RegistrationConfirmationMediator = facade.retrieveMediator(RegistrationConfirmationMediator.NAME) as RegistrationConfirmationMediator;
					registrationConfirmationMediator.showView();
					
					sendNotification(StateMachine.ACTION, null, FSActions.instance.REGISTRATION_CONFIRMATION_RECEIVED);
					break;
				}
				case FSActions.instance.STORES_RECEIVED:
				{
					trace("FSServerActionCommand :: STORES_RECEIVED");
					
					var locationResultsMediator:LocationResultsMediator = facade.retrieveMediator(LocationResultsMediator.NAME) as LocationResultsMediator;
					locationResultsMediator.updateResult();

					sendNotification(StateMachine.ACTION, null, FSActions.instance.STORES_RECEIVED);
					break;
				}
				default:
					trace("FSServerResponseCommand :: add implementation for action :: " + notification.getType());
			}
		}
	}
}
