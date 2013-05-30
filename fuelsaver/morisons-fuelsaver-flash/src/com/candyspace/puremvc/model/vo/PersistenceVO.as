// // // //////////////////////////////////////////////////////////////////////////
//
// CANDYSPACE
// Copyright 2012 CANDYSPACE
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // // //////////////////////////////////////////////////////////////////////////
package com.candyspace.puremvc.model.vo
{
	// TODO: time stamp
	
	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------
	// Flash
	import flash.utils.Dictionary;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class PersistenceVO
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		private var _properties:Dictionary;
		
		public var initializedAtStartup:Boolean;

		public function get data():Dictionary
		{
			return _properties;
		}

		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function PersistenceVO()
		{
			_properties = new Dictionary();
			
			initializedAtStartup = false;
		}
		
		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		
		public function setVar(name:String, value:*):void
		{
			_properties[name] = value;
		}
		
		public function getVar(name:String):*
		{
			return _properties[name];
		}
		
		public function parseObject(obj:Object):void
		{
			initializedAtStartup = true;
			for(var name:String in obj)
			{
				_properties[name] = obj[name];
			}
		}
		
		public function getSerializedObject():Object
		{
			var obj:Object = new Object();
			
			for(var name:String in _properties)
			{
				obj[name] = _properties[name];
			}
			
			return obj;
		}
		
		// --------------------------------------
		// Methods - Private
		// --------------------------------------
		
		
	}
}
