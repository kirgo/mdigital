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

	public class RetrievePersistenceDataCommand extends SimpleCommand
	{

		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		override public function execute(notification:INotification):void
		{
			var homeObject : Object = DataStoreHelper.readObjectFromFile(Settings.instance.PERSISTANCE_FILE_HOME);
			
			var stateProxy : StateProxy = facade.retrieveProxy(StateProxy.NAME) as StateProxy;
			
			if(homeObject)
			{
				stateProxy.initPersistenceData(homeObject);
				sendNotification(Notifications.instance.PERSISTENCE_DATA_RETRIEVE);
			}
			else
			{
				sendNotification(Notifications.instance.PERSISTENCE_DATA_NO_PRESENT);
				// application first run				
			}
		}

	}
}
