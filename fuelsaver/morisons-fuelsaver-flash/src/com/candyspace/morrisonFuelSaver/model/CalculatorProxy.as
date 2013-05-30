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

	import com.candyspace.morrisonFuelSaver.core.FSActions;
	import com.candyspace.morrisonFuelSaver.core.FSNotifications;
	import com.candyspace.morrisonFuelSaver.core.FSSettings;
	import com.candyspace.morrisonFuelSaver.model.vo.CalculatorCategoryVO;
	import com.candyspace.morrisonFuelSaver.model.vo.CalculatorVO;
	import com.candyspace.puremvc.model.connection.XMLRequestProxy;

	import flash.net.URLVariables;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	
	/**
	 * Class Comment
	 */
	public class CalculatorProxy extends XMLRequestProxy 
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		/**
		 * Proxy name.
		 */
		public static const NAME : String = "CalculatorProxy";
		
		protected var _savings : String;

		public function get savings() : String 
		{
			return _savings;
		}

		private function get vo() : CalculatorVO 
		{
			return data as CalculatorVO;
		}

		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function CalculatorProxy() 
		{
			super(NAME, new CalculatorVO());
		}

		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		
		override protected function parseDataItem(xml : XML) : Boolean 
		{
			_savings = String(xml);
			sendNotification(FSNotifications.instance.SERVER_RESPONSE, null, FSActions.instance.CALCULATION_RECEIVED);

			return null;
		}

		// connection
		// http://{baseurl}/:uuid/calculate?categories[beauty]=2&categories[Devil Worship]=10
		override protected function getVariables() : URLVariables 
		{
			var categories : Vector.<CalculatorCategoryVO> = getAllCategoriesVector();
			var requestVariables : URLVariables = new URLVariables();

			for (var i : int = 0; i < categories.length; i++) 
			{
				var varName : String = "categories[" + categories[i].name + "]";
				requestVariables[varName] = categories[i].value;
			}
			return requestVariables;
		}
		
		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		
		public function addCategory(categoryVO : CalculatorCategoryVO) : void 
		{
			vo.addProperty(categoryVO);
		}

		public function getAllCategoriesVector() : Vector.<CalculatorCategoryVO> 
		{
			var data : Vector.<CalculatorCategoryVO> = new Vector.<CalculatorCategoryVO>;
			var name : String;

			var nameOrder : Vector.<String> = vo.propertyNameOrder;
			for (var i : int = 0; i < nameOrder.length; i++) 
			{
				data.push(vo.getPropertyVO(nameOrder[i]));
			}

			return data;
		}

		public function updateCategoryValue(name : String, value : Number) : void 
		{
			vo.setPropertyValue(name, value);
		}


		public function sendCalculationRequest() : void 
		{
			load();
		}

		public function resetValues() : void 
		{
			var nameList : Vector.<String> = vo.order;
			for (var i : int = 0; i < nameList.length; i++) 
			{
				updateCategoryValue(nameList[i], 0);
			}
		}

	}
}
