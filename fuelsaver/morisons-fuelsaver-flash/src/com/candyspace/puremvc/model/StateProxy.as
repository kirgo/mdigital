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
package com.candyspace.puremvc.model
{

	import com.candyspace.puremvc.view.IViewInitVO;
	import com.candyspace.puremvc.model.vo.PersistenceVO;
	import flash.utils.getQualifiedClassName;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	import org.puremvc.as3.multicore.interfaces.IProxy;

	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------
	// Flash
	// PureMVC
	// Structure
	// Custom
	// --------------------------------------
	// EVENTS
	// --------------------------------------
	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class StateProxy extends Proxy implements IProxy
	{
		//--------------------------------------
        // Properties - PUBLIC
        //--------------------------------------		
		public static function get NAME():String
		{
			return getQualifiedClassName(StateProxy);
		}
		
		/**
		 * Persistence object
		 * application state sub class should provide a interface 
		 * for those  persistence properties to be hold in this object
		 * & constant for the properties names
		 * The accesor should access the variables in the persistence object
		 */
		protected var _persistenceVO:PersistenceVO;
		public function initPersistenceData(obj:Object):void
		{
			_persistenceVO.parseObject(obj);
		}
		public function getPersistentDataObject():Object
		{
			return _persistenceVO.getSerializedObject();
		}
		
		/*
		 * USAGE:
		 * 
		public static const RAIN:String = "rain";
		public function get rain():uint
		{
			return uint(_persistenceObject.getVar(RAIN));
		}
		public function set rain(value:uint):void
		{
			_persistenceObject.setVar(RAIN, value);
		}
		*/
		
		
		// Device properties
		protected var _formFactor:String;
		public function get formFactor():String { return _formFactor; }
		public function set formFactor(formFactor:String):void
		{
			_formFactor = formFactor;
		}
		
		protected var _deviceCapability:String;
		public function get deviceCapability():String { return _deviceCapability; }
		public function set deviceCapability(deviceCapability:String):void
		{
			_deviceCapability = deviceCapability;
		}
		
		protected var _osVersion:String;
		public function get osVersion():String { return _osVersion; }
		public function set osVersion(osVersion:String):void
		{
			_osVersion = osVersion;
		}
		
		
		protected var _currentViewVo:IViewInitVO;
		public function get currentViewVo():IViewInitVO { return _currentViewVo; }
		public function set currentViewVo(osVersion:IViewInitVO):void
		{
			_currentViewVo = _currentViewVo;
		}
		
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		public function StateProxy(proxyName:String = null, data:Object = null)
		{
			super(NAME, data);
		}

		

		// --------------------------------------
		// Methods - Init
		// --------------------------------------
		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		override public function onRegister():void
		{
			super.onRegister();
			trace("State Proxy on Register =============================", NAME);
		}
		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		// --------------------------------------
		// Event handlers - Overriden
		// --------------------------------------
		// --------------------------------------
		// Event handlers
		// --------------------------------------
	}
}
