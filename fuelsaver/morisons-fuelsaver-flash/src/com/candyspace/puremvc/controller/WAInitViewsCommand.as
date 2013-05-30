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
package com.candyspace.puremvc.controller
{


	import com.candyspace.morrisonFuelSaver.core.FSSettings;
	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.puremvc.core.Settings;
	import com.candyspace.puremvc.model.services.GoogleStaticMapProxy;
	import com.candyspace.puremvc.model.services.GoogleStaticMapVO;
	import flash.utils.getQualifiedClassName;
	import flash.utils.setTimeout;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	/**
	 * @author Carlos D. Rodriguez
	 */
   //--------------------------------------
    // IMPORTS
    //--------------------------------------
    
	// Flash
    
    // PureMVC
  
    
    // Structure

    
    // Custom
    
    //--------------------------------------
    // CLASS
    //--------------------------------------
    
    /**
    * Class Comment
    */
    
    public class WAInitViewsCommand extends SimpleCommand
    {
        //--------------------------------------
        // Methods - OVERRIDDEN
        //--------------------------------------
        
        override public function execute(notification:INotification):void 
        {
			//debug
            trace(getQualifiedClassName(this) + "::execute - Loading complete. Start views initalization process with startInit()");
            
            sendNotification(Notifications.instance.INIT_LAYER_DISPLAY);
			
			// initialized map service (this could be added somewhere else maybe
			// TODO create this values in the settings
			var initMapVO:GoogleStaticMapVO = new GoogleStaticMapVO();
			initMapVO.width = 444;
			initMapVO.height = 333;
			initMapVO.hasSensor = false;
			initMapVO.addIcon(FSSettings.instance.GOOGLE_MAP_ICON_URL, false)
			//sendNotification(Notifications.instance.GOOGLE_STATIC_MAP_ACTION, initMapVO, GoogleStaticMapProxy.INIT_MAP);
			
			var mapVO:GoogleStaticMapVO = new GoogleStaticMapVO();
			mapVO.latitude = 51;
			mapVO.longitude = 0;
			//sendNotification(Notifications.instance.GOOGLE_STATIC_MAP_ACTION, mapVO, GoogleStaticMapProxy.LOAD_ICON_CENTERED_MAP);
			//setTimeout(sendNotification, 5000, Notifications.instance.GOOGLE_STATIC_MAP_ACTION, mapVO, GoogleStaticMapProxy.LOAD_ICON_CENTERED_MAP);
        }
    }
}
