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
package com.candyspace.morrisonFuelSaver.model
{

	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------
	
	import com.candyspace.morrisonFuelSaver.core.FSSettings;
	import com.candyspace.morrisonFuelSaver.model.vo.CalculatorVO;
	import com.candyspace.puremvc.model.connection.XMLRequestProxy;

	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	// --------------------------------------
	// CLASS
	// --------------------------------------
	
	/**
	 * Class Comment
	 */
	public class TrackingProxy extends XMLRequestProxy
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		/**
		 * Proxy name.
		 */
		public static const NAME:String = "TrackingProxy";

		private function get vo():CalculatorVO
		{
			return data as CalculatorVO;
		}

		protected var _categoryName:String;
		
		protected var _categoryValue:String;

		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function TrackingProxy()
		{
			super(NAME);
		}

		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		
		override protected function getMethod():String
		{
			return URLRequestMethod.POST;
		}

		// POST http://{baseurl}/:uuid/slider-track?category=Beauty&value=100
		override protected function getVariables():URLVariables
		{
			var requestVariables:URLVariables = new URLVariables();

			requestVariables.category = _categoryName;
			requestVariables.value = _categoryValue;

			return requestVariables;
		}
		
		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		
		public function sendSliderInteraction(name:String, value:String):void
		{
			_categoryName = name;
			_categoryValue = value;

			load();
		}
	}
}
