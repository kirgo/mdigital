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

	import com.candyspace.puremvc.core.Notifications;
	import flash.text.ReturnKeyLabel;
	import com.candyspace.puremvc.model.vo.GeolocationVO;
	import flash.events.GeolocationEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.sensors.Geolocation;
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
	public class GeolocationProxy extends Proxy implements IProxy
	{
		// --------------------------------------
		// Properties - PUBLIC
		// --------------------------------------
		public static const GEOLOCATION_TIMEOUT:int = 10000;

		public static function get NAME():String
		{
			return getQualifiedClassName(GeolocationProxy);
		}

		// --------------------------------------
		// Properties - PROTECTED
		// --------------------------------------
		
		protected var _geolocation:Geolocation;
		
		protected var _timeoutTimer:Timer;
		
		protected function get vo():GeolocationVO
		{
			return data as GeolocationVO;
		}

		// --------------------------------------
		// Constructor
		// --------------------------------------
		public function GeolocationProxy()
		{
			super(NAME, new GeolocationVO());
		}

		// --------------------------------------
		// Methods - Init
		// --------------------------------------
		protected function initVars():void
		{
			_geolocation = new Geolocation();

			_timeoutTimer = new Timer(GEOLOCATION_TIMEOUT, 1);
		}

		protected function initListeners():void
		{
			if (_geolocation && !_geolocation.muted)
			{
				enableListeners();
			}
		}

		protected function startLocation():void
		{
			if (!_geolocation.muted)
			{
				_geolocation.setRequestedUpdateInterval(100);
				_timeoutTimer.start();
			}
		}

		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		public function getLocation():void
		{
			if (Geolocation.isSupported)
			{
				initVars();
				
				if(!_geolocation.muted)
				{
					enableListeners();
					
					startLocation();
				}
			}
		}

		// --------------------------------------
		// Methods - Protected
		// --------------------------------------
		protected function enableListeners(enabled:Boolean = true):void
		{
			if (enabled)
			{
				_geolocation.addEventListener(GeolocationEvent.UPDATE, geolocationUpdateHandler);
				_timeoutTimer.addEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);
			}
			else
			{
				_geolocation.removeEventListener(GeolocationEvent.UPDATE, geolocationUpdateHandler);
				_timeoutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);
			}
		}

		// --------------------------------------
		// Event handlers - Overriden
		// --------------------------------------
		// --------------------------------------
		// Event handlers
		// --------------------------------------
		private function geolocationUpdateHandler(e:GeolocationEvent):void
		{
			enableListeners(false);
			
			_timeoutTimer.stop();

			vo.latitude = e.latitude;

			vo.longitude = e.longitude;

			vo.altitude = e.altitude;

			vo.hAccuracy = e.horizontalAccuracy;

			vo.vAccuracy = e.verticalAccuracy;

			vo.speed = e.speed;

			vo.heading = e.heading;

			vo.timestamp = e.timestamp;

			sendNotification(Notifications.instance.GEOLOCATION_DATA_UPDATE, vo);
		}
		
		private function timerCompleteHandler(event:TimerEvent):void
		{
			enableListeners(false);
			
			_timeoutTimer.stop();	
			
			sendNotification(Notifications.instance.GEOLOCATION_DATA_TIMEOUT);		
		}	
		
	}
}
