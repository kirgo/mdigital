// // // // // // ////////////////////////////////////////////////////////////////////
//
// CANDYSPACE
// Copyright 2012 CANDYSPACE
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // // // // // ////////////////////////////////////////////////////////////////////
package com.candyspace.morrisonFuelSaver.model 
{
	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------
	
	import com.candyspace.morrisonFuelSaver.core.FSActions;
	import com.candyspace.morrisonFuelSaver.core.FSNotifications;
	import com.candyspace.morrisonFuelSaver.core.FSSettings;
	import com.candyspace.puremvc.model.connection.XMLRequestProxy;

	import flash.events.HTTPStatusEvent;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class EmailProxy extends XMLRequestProxy 
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		/**
		 * Proxy name.
		 */
		public static const NAME : String = "EmailProxy";
		
		public static const SUCCESS_CODE_STATUS : int = 200;
		
		public static const FAIL_CODE_STATUS : int = 400;
		
		
		protected var _emailString : String;
		
		protected var _optinString : String;

		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function EmailProxy() 
		{
			super(NAME);
		}

		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------

		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		
		override protected function getMethod() : String 
		{
			return URLRequestMethod.POST;
		}

		// connection
		// POST http://{baseurl}/:uuid/collect?email=someshit@gmail.com&optin=true
		override protected function getVariables() : URLVariables 
		{
			var requestVariables : URLVariables = new URLVariables();

			requestVariables.email = _emailString;
			requestVariables.optin = _optinString;

			return requestVariables;
		}

		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		
		public function sendRegistrationRequest(email : String, optin : String) : void 
		{
			_emailString = email;

			_optinString = optin;

			load();
		}
		
		// --------------------------------------
		// Event Handler - Overriden
		// --------------------------------------

		override protected function onHttpResponseStatus(event : HTTPStatusEvent) : void 
		{
			if (event.status == SUCCESS_CODE_STATUS) 
			{
				sendNotification(FSNotifications.instance.SERVER_RESPONSE, null, FSActions.instance.REGISTRATION_CONFIRMATION_RECEIVED);
			}
		}
	}
}
