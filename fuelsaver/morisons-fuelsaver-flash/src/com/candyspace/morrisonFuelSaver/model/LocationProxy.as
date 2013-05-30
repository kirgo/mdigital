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
package com.candyspace.morrisonFuelSaver.model {

	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------
	
	import com.candyspace.morrisonFuelSaver.core.FSActions;
	import com.candyspace.morrisonFuelSaver.core.FSNotifications;
	import com.candyspace.morrisonFuelSaver.core.FSSettings;
	import com.candyspace.morrisonFuelSaver.model.vo.LocationSearchVO;
	import com.candyspace.morrisonFuelSaver.model.vo.StoreVO;
	import com.candyspace.puremvc.model.connection.XMLRequestProxy;

	import flash.net.URLVariables;
	
	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class LocationProxy extends XMLRequestProxy {
		// --------------------------------------
		// Properties
		// --------------------------------------
		/**
		 * Proxy name.
		 */
		public static const NAME : String = "LocationProxy";

		public function get stores() : Vector.<StoreVO> 
		{
			return (data as LocationSearchVO).results as Vector.<StoreVO>;
		}

		public function addStore(store : StoreVO) : void 
		{
			(data as LocationSearchVO).results.push(store);
		}

		public function set postcode(pc : String) : void 
		{
			(data as LocationSearchVO).postcodeQuerry = pc;
		}

		public function get postcode() : String 
		{
			return (data as LocationSearchVO).postcodeQuerry;
		}

		public function get vo() : LocationSearchVO 
		{
			return data as LocationSearchVO;
		}

		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function LocationProxy() 
		{
			super(NAME, new LocationSearchVO());
		}

		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------

		// GET http://{baseurl}/:uuid/stores?postcode=se23 2ez
		override protected function getVariables() : URLVariables {
			var requestVariables : URLVariables = new URLVariables();

			requestVariables.postcode = postcode;

			return requestVariables;
		}

		override protected function parseDataItem(xml : XML) : Boolean
		{

			var storeVO : StoreVO = new StoreVO();

			storeVO.name = xml.child("name");

			storeVO.street = xml.child("street");

			storeVO.city = xml.child("city");

			storeVO.postcode = xml.child("postcode");

			storeVO.tel = xml.child("tel");

			storeVO.lon = xml.child("long");

			storeVO.lat = xml.child("lat");

			var times : XMLList = xml.child("opening_times").children();

			for (var i : int = 0; i < times.length(); i++) 
			{
				storeVO.openingTimes.push(times[i]);
			}

			addStore(storeVO);

			return null;
		}

		override protected function sendLoadedNotification() : void 
		{
			sendNotification(FSNotifications.instance.SERVER_RESPONSE, null, FSActions.instance.STORES_RECEIVED)
		}
		
		// --------------------------------------
		// Methods - Public
		// --------------------------------------

		public function sendLocationRequest(pc : String) : void 
		{
			// parse variables in getVariables
			data = new LocationSearchVO();

			postcode = pc;

			load();
		}

	}
}
