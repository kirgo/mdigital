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
package com.candyspace.morrisonFuelSaver.core
{
	import com.candyspace.puremvc.core.fsm.States;
	/**
	 * @author Carlos D. Rodriguez
	 */

	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class FSStates extends States
	{
		// --------------------------------------
		// Properties - PUBLIC STATIC
		// --------------------------------------
		/**
		 * The only instance of the States class.
		 */
		protected static var _instance:FSStates = null;

		/**
		 * The only way to access an instance of the States class. The singletone pattern is 
		 * used because there can be only one instance in the application.
		 */
		public static function get instance():FSStates
		{
			if (!_instance)
			{
				_instance = new FSStates();
			}

			return _instance;
		}
		
		
		public const INTRO:String = "intro";
		
		public const CALCULATOR_INFO:String = "calculatorInfo";
		
		public const REGISTRATION_INFO:String = "registrationInfo";
		
		public const LOCATION_INFO:String = "locationInfo";
		
		public const SHARING_INFO:String = "sharingInfo";
		
		public const CALCULATOR_ENTRY:String = "calculatorEntry";
		
		public const CALCULATOR_RESULTS:String = "calculatorResults";
		
		public const REGISTRATION_ENTRY:String = "registrationEntry";
		
		public const REGISTRATION_CONFIRMATION:String = "registrationConfirmation";
		
		public const TERMS_CONDITIONS:String = "termsconditions";
		
		public const LOCATION_ENTRY:String = "locationEntry";
		
		public const MAP:String = "map";
		
		public const SHARING:String = "sharing";
		
		// --------------------------------------
		// CONSTRUCTOR
		// --------------------------------------
		public function FSStates()
		{
		}
		
	}
}
