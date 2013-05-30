// // ////////////////////////////////////////////////////////////////////////////
//
// CANDYMEDIA
// Copyright 2012 CANDYMEDIA
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // ////////////////////////////////////////////////////////////////////////////
package com.candyspace.puremvc.controller.startup
{
	import com.candyspace.puremvc.model.GeolocationProxy;
	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------

	// PureMVC
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	// Structure
	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.puremvc.core.Settings;
	import com.candyspace.puremvc.core.utils.DataStoreHelper;
	import com.candyspace.puremvc.model.StateProxy;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */

	public class RetrieveGeolocationDataCommand extends SimpleCommand
	{

		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		override public function execute(notification:INotification):void
		{
			if (!facade.hasProxy(GeolocationProxy.NAME))
			{
				facade.registerProxy(new GeolocationProxy());				
			}
			
			var locationProxy : GeolocationProxy = facade.retrieveProxy(GeolocationProxy.NAME) as GeolocationProxy;
			
			// proxy will send either GEOLOCATION_DATA_UPDATE or GEOLOCATION_DATA_TIMEOUT after this call
			locationProxy.getLocation();
			
			// TODO: proxy should be removed as the data come through
		}

	}
}
