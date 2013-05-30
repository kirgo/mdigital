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
package com.candyspace.morrisonFuelSaver.controller.preloader
{
	import com.candyspace.morrisonFuelSaver.core.FSConstants;

	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------

	import com.candyspace.morrisonFuelSaver.model.ConfigProxy;
	import com.candyspace.morrisonFuelSaver.model.UUIDProxy;
	import com.candyspace.puremvc.controller.startupmanager.PreloadCommand;
	import com.candyspace.puremvc.model.startupmanager.XMLResourceProxy;

	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.startupmanager.model.StartupResourceProxy;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * 
	 */
	public class FSPreloadCommand extends PreloadCommand implements ICommand
	{
		protected var _uuid:XMLResourceProxy;
		protected var _settings:XMLResourceProxy;
		protected var _uuidXmlResource:StartupResourceProxy;
		protected var _settingsXmlResource:StartupResourceProxy;

		override public function execute(notification:INotification):void
		{		
			super.execute(notification);
		}
		
		// --------------------------------------
		// Methods - OVERRIDEN
		// --------------------------------------
		
		override protected function registerDataResources():void
		{
			_uuid = new UUIDProxy();
			//_uuid.inject(FSConstants.UUID_ENDPOINT);

			_uuidXmlResource = new StartupResourceProxy(UUIDProxy.RNAME, _uuid);
			facade.registerProxy(_uuid);
			facade.registerProxy(_uuidXmlResource);
			monitor.addResource(_uuidXmlResource);
			
			_settings = new ConfigProxy();
			_settings.inject(FSConstants.configResouceURL);
			trace(FSConstants.configResouceURL);
			_settingsXmlResource = new StartupResourceProxy(ConfigProxy.RNAME, _settings);
			facade.registerProxy(_settings);
			facade.registerProxy(_settingsXmlResource);
			monitor.addResource(_settingsXmlResource);
		}
		
		override protected function setRequiresValue():void
		{
			_settingsXmlResource.requires = [_preloaderResource];
			_uuidXmlResource.requires = [_preloaderResource, _settingsXmlResource];
			_skinResource.requires = [_preloaderResource, _uuidXmlResource, _settingsXmlResource];			
		}
		
		// dependency injection methods
		override protected function getPreloaderURL():String
		{
			return FSConstants.preloaderURL;
		}
		
		override protected function getSkinURL():String
		{
			return FSConstants.skinURL;
		}
	}
}