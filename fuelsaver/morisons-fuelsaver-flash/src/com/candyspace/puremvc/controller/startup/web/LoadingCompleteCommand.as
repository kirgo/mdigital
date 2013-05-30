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
package com.candyspace.puremvc.controller.startup.web
{

	import com.candyspace.puremvc.controller.WAInitViewsCommand;
	import com.candyspace.puremvc.controller.startupmanager.RemoveStartupManagerCommandsCommand;

	import org.puremvc.as3.multicore.patterns.command.MacroCommand;

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
	// EVENTS
	// --------------------------------------
	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class LoadingCompleteCommand extends MacroCommand
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		// --------------------------------------
		// Constructor
		// --------------------------------------
		// --------------------------------------
		// Methods - Init
		// --------------------------------------
		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		override protected function initializeMacroCommand():void
		{
			addSubCommand(RemoveStartupManagerCommandsCommand);
			addSubCommand(WAInitViewsCommand);
		}
		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		// --------------------------------------
		// Event handlers - Overriden
		// --------------------------------------
		// --------------------------------------
		// Event handlers
		// --------------------------------------
	}
}
