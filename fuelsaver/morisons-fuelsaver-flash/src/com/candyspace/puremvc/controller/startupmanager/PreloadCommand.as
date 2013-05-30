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
package com.candyspace.puremvc.controller.startupmanager
{


	import com.candyspace.puremvc.model.startupmanager.SkinProxy;
	import com.candyspace.puremvc.model.startupmanager.PreloaderProxy;
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.utilities.startupmanager.model.RetryParameters;
	import org.puremvc.as3.multicore.utilities.startupmanager.model.RetryPolicy;
	import org.puremvc.as3.multicore.utilities.startupmanager.model.StartupMonitorProxy;
	import org.puremvc.as3.multicore.utilities.startupmanager.model.StartupResourceProxy;
	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------
	// PureMVC

    
	// Structure

	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * 
	 */
	public class PreloadCommand extends SimpleCommand implements ICommand
	{
		/**
		 * Max trys to load asset
		 */
		private const MAX_RETRIES:Number = 0;
		
		/**
		 * Retry delay to reload asset again
		 */
		private const RETRY_INTERVAL:Number = 0;
		
		/**
		 * Timeout for loading an asset
		 */
		private const TIMEOUT:Number = 0;
		
		/**
		 * Preload monitor
		 */
		protected var monitor:StartupMonitorProxy;
		
		protected var _preloader:PreloaderProxy;
		protected var _preloaderResource:StartupResourceProxy;
		protected var _skinResource : StartupResourceProxy;

		override public function execute(notification:INotification):void
		{
			// create monitor instance
			monitor = new StartupMonitorProxy();

			// set loading retry and timeout settings
			monitor.defaultRetryPolicy = new RetryPolicy(new RetryParameters(MAX_RETRIES, RETRY_INTERVAL, TIMEOUT));

			// register minitor in facade
			facade.registerProxy(monitor);


			// -------------------------
			// PRELOADER RESOURCE
			// -------------------------
			
			trace("registering preloader proxy")
			_preloader = new PreloaderProxy();
			_preloaderResource = new StartupResourceProxy(PreloaderProxy.RNAME, _preloader);
			facade.registerProxy(_preloader);
			facade.registerProxy(_preloaderResource);
			monitor.addResource(_preloaderResource);
			
			
			// -------------------------
			// DATA RESOURCE
			// -------------------------

			registerDataResources();

			// -------------------------
			// SKIN RESOURCE
			// -------------------------

			var skin:SkinProxy = new SkinProxy();
			_skinResource = new StartupResourceProxy(SkinProxy.RNAME, skin);
			facade.registerProxy(skin);
			facade.registerProxy(_skinResource);
			monitor.addResource(_skinResource);

			// -------------------------
			// REQUIRES
			// -------------------------
			setRequiresValue();

			// start preloading
			monitor.loadResources();
		}
		
		protected function registerDataResources():void
		{
			// this should be implemented in the project lower child
			
			//			var settings:SettingsProxy = new SettingsProxy();
//
//			var settingsResource:StartupResourceProxy = new StartupResourceProxy(SettingsProxy.RNAME, settings);
//			facade.registerProxy(settings);
//			facade.registerProxy(settingsResource);
//			monitor.addResource(settingsResource);
		}
		
		protected function setRequiresValue():void
		{
			// TODO need to make var global
//			preloaderResource.requires = [settingsResource];
//			skinResource.requires = [settingsResource, preloaderResource];
			
		}
	}
}