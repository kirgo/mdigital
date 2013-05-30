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

	import com.candyspace.puremvc.core.Settings;
	import com.candyspace.morrisonFuelSaver.model.vo.LocationVO;
	import com.candyspace.puremvc.model.startupmanager.XMLResourceProxy;

	/**
	 * @author Carlos D. Rodriguez
	 */
		public class LocationsProxy extends XMLResourceProxy
    {
		//--------------------------------------
		// Properties - PUBLIC
		//--------------------------------------
		
		/**
		 * Proxy name.
		 */
		public static const NAME:String = "LocationProxy";
		
		
		/**
		 * Resource name.
		 */
		public static const RNAME:String = "Resource_LocationProxy";
		
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
		
		
		protected var locations:Vector.<LocationVO> = new Vector.<LocationVO>();
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function LocationsProxy()
        {
			super(NAME);
		}
		
		//--------------------------------------
		// Methods - PROTECTED
		//--------------------------------------
		
		/*
			<location pc="S156PP">
	        <address>4 My Dear Drive</address>
	        <city>London</city>
	        <longitude>8888</longitude>
	        <latitude>2222</latitude>
	    	</location>
		 */
		override protected function parseDataItem(xml:XML):Boolean
		{
			var location:LocationVO = new LocationVO();
			
			location.postcode = xml.attribute("pc");
			
			location.address = xml.child("address");
			
			location.city = xml.child("city");
			
			location.longitude = xml.child("longitude");
			
			location.latitude = xml.child("latitude");
			
			trace("location:: ", location);
			
			return null;
		}
		
	}
}