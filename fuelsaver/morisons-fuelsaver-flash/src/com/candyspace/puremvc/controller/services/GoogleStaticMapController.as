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
package com.candyspace.puremvc.controller.services
{

	import com.candyspace.puremvc.model.services.GoogleStaticMapProxy;
	import com.candyspace.puremvc.model.services.GoogleStaticMapVO;

	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

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
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class GoogleStaticMapController extends SimpleCommand
	{
		// --------------------------------------
		// Methods - OVERRIDDEN
		// --------------------------------------
		override public function execute(notification:INotification):void
		{
			var staticMapProxy:GoogleStaticMapProxy = facade.retrieveProxy(GoogleStaticMapProxy.NAME) as GoogleStaticMapProxy;
			trace("googlemap::", staticMapProxy, facade.retrieveProxy(GoogleStaticMapProxy.NAME));

			var vo:GoogleStaticMapVO = notification.getBody() as GoogleStaticMapVO;
			
			var mapType:String = notification.getType();
			
			switch (mapType) 
			{ 
				case GoogleStaticMapProxy.INIT_MAP: 
					staticMapProxy.init(vo);
					trace( "GoogleStaticMapController :: initializing map settings" ); 
					break; 			  
				case GoogleStaticMapProxy.LOAD_ICON_CENTERED_MAP: 
					staticMapProxy.getIconCenteredMap(vo.latitude, vo.longitude);
				
					trace( "GoogleStaticMapController :: icon centered map" ); 
					break; 
				default: 
					trace( "Defaulting: neither value0 or value1 evaluated." );
			}

		}
	}
}
