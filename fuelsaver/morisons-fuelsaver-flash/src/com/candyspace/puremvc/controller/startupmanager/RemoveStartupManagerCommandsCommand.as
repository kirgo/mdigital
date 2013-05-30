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
package com.candyspace.puremvc.controller.startupmanager
{

	import com.candyspace.puremvc.core.Notifications;

	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	import flash.utils.getQualifiedClassName;

	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------
	// Flash
	// PureMVC
	// Structure
	// Custom
	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class RemoveStartupManagerCommandsCommand extends SimpleCommand
	{
		// --------------------------------------
		// Methods - OVERRIDDEN
		// --------------------------------------
		override public function execute(notification:INotification):void
		{
			// debug
			trace(getQualifiedClassName(this) + "::execute - LOADING_COMPLETE -> Remove irelevant startup manager commands");

			// remove unused commands
			facade.removeCommand(Notifications.instance.PRELOADER_LOADED);
			facade.removeCommand(Notifications.instance.PRELOADER_LOADING_FAIL);

			facade.removeCommand(Notifications.instance.SKIN_LOADED);
			facade.removeCommand(Notifications.instance.SKIN_LOADING_FAIL);
		}
	}
}
