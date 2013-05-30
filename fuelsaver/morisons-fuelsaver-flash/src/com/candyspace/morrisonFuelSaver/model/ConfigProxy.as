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

	import flash.utils.Dictionary;
	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.morrisonFuelSaver.core.FSConstants;
	import com.candyspace.morrisonFuelSaver.core.FSNotifications;
	import com.candyspace.morrisonFuelSaver.core.FSSettings;
	import com.candyspace.morrisonFuelSaver.model.vo.CalculatorCategoryVO;
	import com.candyspace.puremvc.core.Settings;
	import com.candyspace.puremvc.model.startupmanager.XMLResourceProxy;

	/**
	 * @author Carlos D. Rodriguez
	 */
		public class ConfigProxy extends XMLResourceProxy
    {
		//--------------------------------------
		// Properties - PUBLIC
		//--------------------------------------
		
		/**
		 * Proxy name.
		 */
		public static const NAME:String = "ConfigProxy";
		
		
		/**
		 * Resource name.
		 */
		public static const RNAME:String = "Resource_ConfigProxy";
		
		// XML STRUCTURE CONST
		
		public static const CATEGORIES_NODE_NAME:String = "categories";
		
		
		public static const VARIABLES_NODE_NAME:String = "variables";
		
		public static const TANK_SIZE_NODE_NAME:String = "tank_size";
		
		public static const SAVING_NODE_NAME:String = "saving";
		
		
		public static const ENDPOINT_NODE_NAME:String = "endpoints";
		
		public static const GET_UUID_NODE_NAME:String = "getUUID";
		
		public static const SEARCH_NODE_NAME:String = "storeSearch";
		
		public static const CALCULATOR_NODE_NAME:String = "calculator";
		
		public static const COLLECT_NODE_NAME:String = "collect";
		
		public static const TRACKING_NODE_NAME:String = "sliderTracking";

		
		public static var TANK_SIZE:Number;
		
		public static var SAVING:Number;
		
		
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
		
		
		protected var baseUrl:String;
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function ConfigProxy()
        {
			super(NAME);
		}
		
		//--------------------------------------
		// Methods - Overriden
		//--------------------------------------		
		
		
		override protected function parseDataItem(xml:XML):Boolean
		{
			switch (String(xml.name())) 
			{ 
				case CATEGORIES_NODE_NAME: 
					trace( CATEGORIES_NODE_NAME ); 
					parseCategories(xml);
					break; 			  
				case VARIABLES_NODE_NAME: 
					trace( VARIABLES_NODE_NAME ); 
					parseVariables(xml);
					break; 
				case ENDPOINT_NODE_NAME: 
					trace( VARIABLES_NODE_NAME ); 
					parseEndPoints(xml);
					break; 
				default: 
					trace( "ConfigProxy :: parseDataItem :: default" );
			}

			return null;
		}
		
		//--------------------------------------
		// Methods - Private
		//--------------------------------------

		private function parseCategories(xml:XML):void
		{
			var list:XMLList = xml.children();
			var categoryVO:CalculatorCategoryVO;
			var categoryXml:XML;
			
			//parse categories
			for(var i:int = 0; i < list.length(); i++)
			{
				categoryXml = list[i];

				categoryVO = new CalculatorCategoryVO();
	
				categoryVO.name = categoryXml.child("name");
	
				categoryVO.maxLimit = categoryXml.child("max");
				
				trace(categoryXml, categoryVO);
				
				sendNotification(FSNotifications.instance.ADD_CALCULATOR_CATEGORY, categoryVO);
			}
		}
		
		private function parseVariables(xml:XML):void
		{
			var list:XMLList = xml.children();
			
			//parse variables
			for(var i:int = 0; i < list.length(); i++)
			{
				
				switch (String(list[i].name())) { 
					case TANK_SIZE_NODE_NAME: 
						//trace( "TANK_SIZE_NODE_NAME was selected" ); 
						TANK_SIZE = list[i];
						break; 			  
					case SAVING_NODE_NAME: 
						//trace( "value1 was selected" ); 
						SAVING = list[i];
						break; 
					default: 
						trace( "ConfigProxy :: parseVariables :: default" );
				}
			}
		}
		
		protected var _endPoints : Dictionary;
		private function parseEndPoints(xml:XML):void
		{
			var list:XMLList = xml.children();
			_endPoints = new Dictionary();
		
			//parse end points			
			var nodeName : String;

			for(var i:int = 0; i < list.length(); i++)
			{				
				nodeName = String(list[i].child("name"));
				_endPoints[nodeName] = list[i].child("url");
			}
			
			sendNotification(FSNotifications.instance.INJECT_ENDPOINT, _endPoints[GET_UUID_NODE_NAME], GET_UUID_NODE_NAME);
			
		}
		
		public function injectRemainingEndPoints():void
		{			
			var nodeName : String;
			var endPoint:String;
			
			for (var name:Object in _endPoints)
			{
				nodeName = String(name);
								
				switch (nodeName) 
				{ 			  
					case SEARCH_NODE_NAME: 
					case CALCULATOR_NODE_NAME: 
					case COLLECT_NODE_NAME: 
					case TRACKING_NODE_NAME: 
						endPoint = insertUUID(String(_endPoints[name]));
						sendNotification(FSNotifications.instance.INJECT_ENDPOINT, endPoint, nodeName)
					default: 
						trace( "ConfigProxy :: injectRemainingEndPoints :: default" );
				}
			}
		}
		
		private function insertUUID(url:String):String
		{
			var uuidProxy:UUIDProxy = facade.retrieveProxy(UUIDProxy.NAME) as UUIDProxy;
			var uuid:String = uuidProxy.uuid;
			
			var urlParts:Array = url.split('{uuid}');
			return urlParts[0] + uuid + urlParts[1];
		}
		
	}
}