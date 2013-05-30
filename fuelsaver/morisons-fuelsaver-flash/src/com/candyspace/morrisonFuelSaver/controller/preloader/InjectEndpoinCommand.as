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
package com.candyspace.morrisonFuelSaver.controller.preloader
{

	import com.candyspace.morrisonFuelSaver.model.TrackingProxy;
	import com.candyspace.morrisonFuelSaver.model.CalculatorProxy;
	import com.candyspace.morrisonFuelSaver.model.LocationProxy;
	import com.candyspace.morrisonFuelSaver.model.EmailProxy;
	import com.candyspace.morrisonFuelSaver.core.FSConstants;

	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------
	import com.candyspace.morrisonFuelSaver.model.ConfigProxy;
	import com.candyspace.morrisonFuelSaver.model.UUIDProxy;
	import com.candyspace.puremvc.controller.startupmanager.PreloadCommand;
	import com.candyspace.puremvc.model.startupmanager.XMLResourceProxy;

	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.startupmanager.model.StartupResourceProxy;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * 
	 */
	public class InjectEndpoinCommand extends PreloadCommand implements ICommand
	{
		// --------------------------------------
		// Methods - OVERRIDEN
		// --------------------------------------

		override public function execute(notification:INotification):void
		{
			var url:String = String(notification.getBody());
			
			switch (notification.getType())
			{
				case ConfigProxy.GET_UUID_NODE_NAME:
					var uuidProxy:UUIDProxy = facade.retrieveProxy(UUIDProxy.NAME) as UUIDProxy;
					uuidProxy.inject(url);
					break;
				case ConfigProxy.SEARCH_NODE_NAME:
					var locationProxy:LocationProxy = facade.retrieveProxy(LocationProxy.NAME) as LocationProxy;
					locationProxy.inject(url);
					break;
				case ConfigProxy.CALCULATOR_NODE_NAME:
					var calculatorProxy:CalculatorProxy = facade.retrieveProxy(CalculatorProxy.NAME) as CalculatorProxy;
					calculatorProxy.inject(url);
					break;
				case ConfigProxy.COLLECT_NODE_NAME:
					var emailProxy:EmailProxy = facade.retrieveProxy(EmailProxy.NAME) as EmailProxy;
					emailProxy.inject(url);
					break;
				case ConfigProxy.TRACKING_NODE_NAME:
					var trackingProxy:TrackingProxy = facade.retrieveProxy(TrackingProxy.NAME) as TrackingProxy;
					trackingProxy.inject(url);
					break;
				default:
					trace("InjectEndpointCommand :: execute :: default");
			}
		}

	}
}