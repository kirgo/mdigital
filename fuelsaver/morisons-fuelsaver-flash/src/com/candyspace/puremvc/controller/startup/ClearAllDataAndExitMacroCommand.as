// // // //////////////////////////////////////////////////////////////////////////
//
// CANDYMEDIA
// Copyright 2012 CANDYMEDIA
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // // //////////////////////////////////////////////////////////////////////////
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
	import org.puremvc.as3.multicore.patterns.command.MacroCommand;


	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class ClearAllDataAndExitMacroCommand extends MacroCommand
	{
		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		override protected function initializeMacroCommand():void
		{
			addSubCommand(ClearLocalPersistenceDataCommand);
			
			addSubCommand(ExitApplicationCommand);
		}
	}
}
