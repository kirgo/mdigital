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
	import com.candyspace.morrisonFuelSaver.core.FSNotifications;
	import com.candyspace.morrisonFuelSaver.mediator.CalculatorIntroMediator;
	import com.candyspace.morrisonFuelSaver.mediator.CalculatorMediator;
	import com.candyspace.morrisonFuelSaver.mediator.LocationEntryMediator;
	import com.candyspace.morrisonFuelSaver.mediator.LocationIntroMediator;
	import com.candyspace.morrisonFuelSaver.mediator.RegistrationEntryMediator;
	import com.candyspace.morrisonFuelSaver.mediator.RegistrationIntroMediator;
	import com.candyspace.morrisonFuelSaver.mediator.SharingIntroMediator;
	import com.candyspace.morrisonFuelSaver.mediator.SharingMediator;
	import com.candyspace.morrisonFuelSaver.mediator.TermsConditionsMediator;
	import com.candyspace.morrisonFuelSaver.model.CalculatorProxy;

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
	public class FSClientActionCommand extends SimpleCommand
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
				case FSActions.instance.RELOAD_APP:
				{
					trace("FSClientActionCommand :: RELOAD_APP");					
					
					var calculatorIntroMediator:CalculatorIntroMediator = facade.retrieveMediator(CalculatorIntroMediator.NAME) as CalculatorIntroMediator;
					calculatorIntroMediator.showView();
					
					var calculatorProxy:CalculatorProxy = facade.retrieveProxy(CalculatorProxy.NAME) as CalculatorProxy;
					calculatorProxy.resetValues();
					
					// this will reset views
					sendNotification(FSNotifications.instance.RESET_APPLICATION);
					
					sendNotification(StateMachine.ACTION, null, FSActions.instance.SELECT_MENU_CALCULATOR);
					break;
				}
				case FSActions.instance.SELECT_MENU_CALCULATOR:
				{
					trace("FSClientActionCommand :: SELECT_MENU_CALCULATOR");
					
					var calculatorIntroMediator:CalculatorIntroMediator = facade.retrieveMediator(CalculatorIntroMediator.NAME) as CalculatorIntroMediator;
					calculatorIntroMediator.showView();
					
					sendNotification(StateMachine.ACTION, null, FSActions.instance.SELECT_MENU_CALCULATOR);
					break;
				}
				case FSActions.instance.SELECT_MENU_REGISTRATION:
				{
					trace("FSClientActionCommand :: SELECT_MENU_REGISTRATION");
					
					var registrationIntroMediator:RegistrationIntroMediator = facade.retrieveMediator(RegistrationIntroMediator.NAME) as RegistrationIntroMediator;
					registrationIntroMediator.showView();

					sendNotification(StateMachine.ACTION, null, FSActions.instance.SELECT_MENU_REGISTRATION);
					break;
				}
				case FSActions.instance.SELECT_MENU_LOCATION:
				{
					trace("FSClientActionCommand :: SELECT_MENU_LOCATION");
					
					var locationIntroMediator:LocationIntroMediator = facade.retrieveMediator(LocationIntroMediator.NAME) as LocationIntroMediator;
					locationIntroMediator.showView();
					
					sendNotification(StateMachine.ACTION, null, FSActions.instance.SELECT_MENU_LOCATION);
					break;
				}
				case FSActions.instance.SELECT_MENU_SHARING:
				{
					trace("FSClientActionCommand :: SELECT_MENU_SHARING");
					
					var sharingIntroMediator:SharingIntroMediator = facade.retrieveMediator(SharingIntroMediator.NAME) as SharingIntroMediator;
					sharingIntroMediator.showView();
					
					sendNotification(StateMachine.ACTION, null, FSActions.instance.SELECT_MENU_SHARING);
					break;
				}
				case FSActions.instance.OPEN_CALCULATOR:
				{
					trace("FSClientActionCommand :: OPEN_CALCULATOR");
					
					var calculatorMediator:CalculatorMediator = facade.retrieveMediator(CalculatorMediator.NAME) as CalculatorMediator;
					calculatorMediator.showView();
					
					sendNotification(StateMachine.ACTION, null, FSActions.instance.OPEN_CALCULATOR);
					break;
				}
				case FSActions.instance.OPEN_REGISTRATION:
				{
					trace("FSClientActionCommand :: OPEN_REGISTRATION");

					var registrationEntryMediator:RegistrationEntryMediator = facade.retrieveMediator(RegistrationEntryMediator.NAME) as RegistrationEntryMediator;
					registrationEntryMediator.showView();
					
					sendNotification(StateMachine.ACTION, null, FSActions.instance.OPEN_REGISTRATION);
					break;
				}
				case FSActions.instance.OPEN_LOCATION:
				{
					trace("FSClientActionCommand :: OPEN_LOCATION");

					var locationEntryMediator:LocationEntryMediator = facade.retrieveMediator(LocationEntryMediator.NAME) as LocationEntryMediator;
					locationEntryMediator.showView();

					sendNotification(StateMachine.ACTION, null, FSActions.instance.OPEN_LOCATION);
					break;
				}
				case FSActions.instance.OPEN_SHARING:
				{
					trace("FSClientActionCommand :: OPEN_SHARING");

					var sharingMediator:SharingMediator = facade.retrieveMediator(SharingMediator.NAME) as SharingMediator;
					sharingMediator.showView();
					
					sendNotification(StateMachine.ACTION, null, FSActions.instance.OPEN_SHARING);
					break;
				}
				case FSActions.instance.SHOW_TC:
				{
					trace("FSClientActionCommand :: SHOW_TC");
					var tcMediator:TermsConditionsMediator = facade.retrieveMediator(TermsConditionsMediator.NAME) as TermsConditionsMediator;
					tcMediator.showView();					
					
					sendNotification(StateMachine.ACTION, null, FSActions.instance.SHOW_TC);
					break;
				}
				default:
					trace( "FSClientActionCommand :: ACTION IS NOT DEFINED: ", notification.getType() );
			}
		}
	}
}
