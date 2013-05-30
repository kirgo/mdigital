// //////////////////////////////////////////////////////////////////////////////
//
// CANDYSPACE
// Copyright 2012 CANDYSPACE
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// //////////////////////////////////////////////////////////////////////////////
package com.candyspace.morrisonFuelSaver.model
{

	import com.candyspace.morrisonFuelSaver.core.FSSettings;
	import com.candyspace.puremvc.model.startupmanager.XMLResourceProxy;

	/**
	 * @author Carlos D. Rodriguez
	 */
	public class UUIDProxy extends XMLResourceProxy
    {
		//--------------------------------------
		// Properties - PUBLIC
		//--------------------------------------
		
		/**
		 * Proxy name.
		 */
		public static const NAME:String = "UUIDProxy";
		
		
		/**
		 * Resource name.
		 */
		public static const RNAME:String = "Resource_UUIDProxy";
		
		
		protected var _uuid:String;
		public function get uuid():String
		{
			return _uuid;
		}
		
		
		//--------------------------------------
		// Properties - PROTECTED
		// --------------------------------------
		
		override protected function get name():String
		{
			return NAME;
		}

		override protected function get rName():String
		{
			return RNAME;
		}
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function UUIDProxy()
        {
			super(NAME);
		}

		//--------------------------------------
		// Methods - Overriden
		//--------------------------------------		

		override protected function parseDataItem(xml:XML):Boolean
		{			
			_uuid = String(xml);
			
			var configProxy:ConfigProxy = facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy;
			configProxy.injectRemainingEndPoints();			

			return null;
		}

	}
}