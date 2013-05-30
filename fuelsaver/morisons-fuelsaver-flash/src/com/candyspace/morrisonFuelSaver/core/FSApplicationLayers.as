// //////////////////////////////////////////////////////////////////////////////
//
// CANDYSPACE
// Copyright 2012 CANDYSPACE
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // ////////////////////////////////////////////////////////////////////////////
package com.candyspace.morrisonFuelSaver.core
{
	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------
	
	import com.candyspace.puremvc.core.layers.GeneralLayers;

	import flash.utils.getQualifiedClassName;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	
	/**
	 * Class Comment
	 */
	public class FSApplicationLayers extends GeneralLayers
    {
        
        //--------------------------------------
        // Properties - PUBLIC STATIC
        //--------------------------------------
        
        /**
         * The only instance of the CApplicationLayers class.
         */
        protected static var _instance:FSApplicationLayers = null;
		
        /**
         * The only way to access an instance of the GeneralLayers class. The singletone pattern is 
         * used because there can be only one instance in the application.
         */
        public static function get instance():FSApplicationLayers
        {
            if (!_instance)
            {
                _instance = new FSApplicationLayers();
            }
            
            return _instance;
        }       
        
        //--------------------------------------
        // CONSTRUCTOR
        //--------------------------------------
        
        public function FSApplicationLayers()
        {
			if (_instance)
            {
                throw new Error(
                                    getQualifiedClassName(FSApplicationLayers) + " is a singleton class. "
                                    + "Use '" + getQualifiedClassName(FSApplicationLayers) +  ".instance' to get access to the only instance of the class."
                               );
            }
            
            _instance = this;
            
        }
        
        //--------------------------------------
        //  Methods - PUBLIC
        //--------------------------------------
        
        override public function get layersOrder():Array
        {
            return [
                        { name: BACKGROUND, addToStage: true },
                        { name: MENU, addToStage: true },
                        { name: DYNAMIC, addToStage: true },
                        { name: PRELOADER, addToStage: true },
                        { name: WARNING, addToStage: true }
                   ];
        }
        
    }
}
