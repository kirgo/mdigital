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
package com.candyspace.puremvc.core.fsm
{
	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------
	// Flash

	import flash.utils.getQualifiedClassName;

	// PureMVC
	// Structure
	// Custom
	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class States
	{
		// --------------------------------------
		// Properties - PUBLIC STATIC
		// --------------------------------------
		/**
		 * The only instance of the States class.
		 */
		protected static var _instance:States = null;

		/**
		 * The only way to access an instance of the States class. The singletone pattern is 
		 * used because there can be only one instance in the application.
		 */
		public static function get instance():States
		{
			if (!_instance)
			{
				_instance = new States();
			}

			return _instance;
		}

		// --------------------------------------
		// Properties - PUBLIC
		// --------------------------------------
		/**
		 * @STATES -> general states go here.
		 */
		/**
		 * Initial state of a application. The application is in this state only 
		 * at the beginning of the game. After is exits the state, it will never
		 * enter it again.
		 */
		public const INITIAL:String = "initial";
		/**
		 * State in which the application enters if the server had no chance to write
		 * all the information in the data base. This will send the application into
		 * an error state, requesting the user to reload.
		 */
		public const WAIT_FOR_NEXT_ACTION:String = "waitForNextAction";
		/**
		 * Used to display a message received from the server. Usualy used to display
		 * that the game will be blocked after the current round ends.
		 */
		public const WARNING:String = "warning";
		/**
		 * State in which the game enter is a fatal error occured. This will determine
		 * the application to close the server connection (if it wasn't already closed
		 * by the server) and disable all user interaction. The application cannot enter 
		 * any other state if is in this state.
		 */
		public const ERROR:String = "error";
		
		public const CLOSE_APP:String = "closeApp";


		// --------------------------------------
		// CONSTRUCTOR
		// --------------------------------------
		public function States()
		{
		}
	}
}
