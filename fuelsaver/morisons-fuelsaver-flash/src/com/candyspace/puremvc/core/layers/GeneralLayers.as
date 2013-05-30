// //////////////////////////////////////////////////////////////////////////////
//
// CANDYMEDIA
// Copyright 2012 CANDYMEDIA
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// //////////////////////////////////////////////////////////////////////////////
package com.candyspace.puremvc.core.layers
{
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
	 public class GeneralLayers
    {
        
        //--------------------------------------
        // Properties - PUBLIC STATIC
        //--------------------------------------
        
        /**
         * The only instance of the GeneralLayers class.
         */
        protected static var _instance:GeneralLayers = null;
        /**
         * The only way to access an instance of the GeneralLayers class. The singletone pattern is 
         * used because there can be only one instance in the application.
         */
        public static function get instance():GeneralLayers
        {
            if (!_instance)
            {
                _instance = new GeneralLayers();
            }
            
            return _instance;
        }
        
        //--------------------------------------
        // Properties - PUBLIC STATIC
        //--------------------------------------
        
        public const BACKGROUND:String = "backgroundLayer";
        
		public const LOGO:String = "logoLayer";
        
        public const MENU:String = "menuLayer";
		
        public const STRIP:String = "stripLayer";
        
        public const GAMEPLAY_BUTTONS:String = "gameplayButtonsLayer";
        
        public const GAMEPLAY_BUTTONS_BACKGROUND:String = "gameplayButtonsBackgroundLayer";
        
		public const NEW_FEATURES:String = "newFeatures";
		
        public const WINDOWS:String = "windowsLayer";
        
        public const DYNAMIC:String = "dynamicLayer";
        
        public const TOOLTIP:String = "tooltipLayer";
        
        public const DIALOG_WINDOWS:String = "dialogWindowsLayer";
        
        public const PRELOADER:String = "preloaderLayer";
        
        public const MESSAGES_QUEUE:String = "messagesQueueLayer";
		
		public const FRAME:String = "frameLayer";
        
		/**
         * Displays warning messages.
         */
        public const WARNING:String = "warningLayer";
        
        //--------------------------------------
        // CONSTRUCTOR
        //--------------------------------------
        
        public function GeneralLayers()
        {
            
        }
        
        //--------------------------------------
        //  Methods - PUBLIC
        //--------------------------------------
        
        public function get layersOrder():Array
        {
            return [
                        { name: BACKGROUND, addToStage: true },
                        { name: STRIP, addToStage: true },
                        { name: GAMEPLAY_BUTTONS, addToStage: true },
                        { name: MESSAGES_QUEUE, addToStage: true },
                        { name: MENU, addToStage: true },
                        { name: WINDOWS, addToStage: true },
                        { name: DYNAMIC, addToStage: true },
                        { name: FRAME, addToStage: true },
                        { name: TOOLTIP, addToStage: true }, 
                        { name: PRELOADER, addToStage: true },
                        { name: WARNING, addToStage: true }
                   ];
        }
        
    }
}
