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
	
	// Flash
	import flash.desktop.NativeApplication;
	
	// PureMVC
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;


	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class ExitApplicationCommand extends SimpleCommand
	{
		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		override public function execute(notification:INotification):void
		{
			
			NativeApplication.nativeApplication.exit();
			
		}
	}
}
