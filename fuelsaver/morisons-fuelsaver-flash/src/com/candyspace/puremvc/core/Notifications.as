// // // //////////////////////////////////////////////////////////////////////////
//
// CANDYSPACE
// Copyright 2012 CANDYSPACE
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // // //////////////////////////////////////////////////////////////////////////
package com.candyspace.puremvc.core
{

	import org.puremvc.as3.multicore.utilities.startupmanager.model.StartupMonitorProxy;
	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------

	import flash.utils.getQualifiedClassName;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class Notifications
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		protected static var _instance:Notifications = null;

		public static function get instance():Notifications
		{
			if (!_instance)
			{
				_instance = new Notifications();
			}

			return _instance;
		}
		
		//--------------------------------------
		// STARTUP MANAGER NOTIFICATIONS - web only
		//--------------------------------------
		
		/**
		 * Notification used to signal the starting of the resources loading (includes settings, 
		 * translations and other assets).
		 * 
		 * The notification has no body.
		 */
		public const PRELOAD_APPLICATION:String	= getQualifiedClassName(this) + ".PRELOAD_APPLICATION";
		
		/**
		 * Notification used to signal the ending of the preloader loading. The notification is 
		 * captured by the imo.puremvc.commandShowPreloaderCommand.
		 * 
		 * The body of the notification is the name of the proxy that handles the loading (i.e.
		 * PreloaderProxy).
		 * 
		 * The type of the notification is the name of the resource that handles the loading (i.e.
		 * the PreloaderProxy). This name is used by the strtup manager proxy utility.
		 */
		public const PRELOADER_LOADED:String = getQualifiedClassName(this) + ".PRELOADER_LOADED";
		
		public const XML_RESOURCE_LOADED:String = getQualifiedClassName(this) + ".XML_RESOURCE_LOADED";
		
		/**
		 * Notification used to signal the ending of the skin loading. 
		 * 
		 * The body of the notification is the name of the proxy that handles the loading (i.e.
		 * SkinProxy).
		 * 
		 * The type of the notification is the name of the resource that handles the loading (i.e.
		 * the SkinProxy). This name is used by the strtup manager proxy utility.
		 */
        public const SKIN_LOADED:String = getQualifiedClassName(this) + ".SKIN_LOADED";
		
		/**
		 * The notification is sent by the SkinProxy every time when bytes are loaded and it is
		 * caught by the PreloaderMediator.
		 * 
		 * The body of the notification is a number in the [0, 1] interval which represents the 
		 * percent of the total size of the assets that has been loaded until now.
		 */
		public const PRELOADER_PROGRESS:String = getQualifiedClassName(this) + "preloaderProgress";
		
        public const LOADING_COMPLETE:String = StartupMonitorProxy.LOADING_COMPLETE;
		
		/**
		 * Notification used to remove the preloader asset from the stage, and display the loaded
		 * application. This notificaion needs to be sent by each application. It IS NOT SENT
		 * AUTOMATICALLY.
		 * 
		 * The notification has no body.
		 */
		public const REMOVE_PRELOADER:String = getQualifiedClassName(this) + ".REMOVE_PRELOADER";
		
		
		public const PRELOADER_LOADING_FAIL:String = getQualifiedClassName(this) + ".PRELOADER_LOADING_FAIL";	
		
		public const XML_RESOURCE_LOADING_FAIL:String = getQualifiedClassName(this) + ".XML_RESOURCE_LOADING_FAIL";		
		
        public const SKIN_LOADING_FAIL:String = getQualifiedClassName(this) + ".SKIN_LOADING_FAIL";
		
		
		
		

		/**
		 * Notification sent to start application
		 * 
		 * The notification has no body.
		 * 
		 * The notification has no type.

		 */
		public const STARTUP:String = getQualifiedClassName(this) + "STARTUP";
		
		/**
		 * Notification sent to register device details
		 * 
		 * The notification has no body.
		 * 
		 * The notification has no type.

		 */
		public const GET_DEVICE_PROPERTIES:String = getQualifiedClassName(this) + "GET_DEVICE_PROPERTIES";
		
		/**
		 * Notification sent when device details are succesfully stored
		 * 
		 * The notification has no body.
		 * 
		 * The notification has no type.

		 */
		public const DEVICE_PROPERTIES_PARSED:String = getQualifiedClassName(this) + "DEVICE_PROPERTIES_PARSED";
		
		/**
		 * Notification sent if device details parsing fails
		 * 
		 * The notification has no body.
		 * 
		 * The notification has no type.

		 */
		public const DEVICE_PROPERTIES_FAILED:String = getQualifiedClassName(this) + "DEVICE_PROPERTIES_FAILED";
		
		
		
		/**
		 * Notification sent to see if a connection is present
		 * 
		 * The notification has no body.
		 * 
		 * The notification has no type.

		 */
		public const CHECK_NETWORK_STATUS:String = getQualifiedClassName(this) + "CHECK_CONNECTION_STATUS";
		
		/**
		 * Notification sent to broadcast connection status
		 * 
		 * The notification body is the current network state as String
		 * Posible values: STATE_OFFLINE, STATE_ONLINE & STATE_WIFI as defined in NetWorkMonitorProxy
		 * 
		 * The notification has no type.
		 */
		public const NETWORK_STATUS_UPDATE:String = getQualifiedClassName(this) + "UPDATE_CONNECTION_STATUS";
		
		
		/**
		 * Notification sent to save data to local file previous to closing the app
		 * 
		 * The notification has no body.
		 * 
		 * The notification has no type.

		 */
		public const SAVE_PERSISTENCE_DATA:String = getQualifiedClassName(this) + "SAVE_PERSISTENCE_DATA";
		
		/**
		 * Notification sent to retrieve persistence data from local file and save it in the state proxy
		 * 
		 * The notification has no body.
		 * 
		 * The notification has no type.

		 */
		public const RETRIEVE_PERSISTENCE_DATA:String = getQualifiedClassName(this) + "RETRIEVE_PERSISTENCE_DATA";
		
		/**
		 * Notification sent to delete local persistence file
		 * 
		 * The notification has no body.
		 * 
		 * The notification has no type.
		 */
		public const CLEAR_LOCAL_PERSISTENCE_DATA:String = getQualifiedClassName(this) + "CLEAR_LOCAL_PERSISTENCE_DATA";
		
		/**
		 * Notification sent to close native application
		 * 
		 * The notification has no body.
		 * 
		 * The notification has no type.
		 */
		public const EXIT_APPLICATION:String = getQualifiedClassName(this) + "EXIT_APPLICATION";
		
		/**
		 * Notification sent to close native application and clear local persistent data
		 * 
		 * The notification has no body.
		 * 
		 * The notification has no type.
		 */
		public const EXIT_AND_CLEAR_DATA_APPLICATION:String = getQualifiedClassName(this) + "EXIT_AND_CLEAR_DATA_APPLICATION";
		
		/**
		 * Notification sent to broadcast that no persistence data was present ( could be the first run of the application)
		 * 
		 * The notification has no body.
		 * 
		 * The notification has no type.
		 */
		 
		public const PERSISTENCE_DATA_NO_PRESENT:String = getQualifiedClassName(this) + "PERSISTENCE_DATA_NO_PRESENT";
		/**
		 * Notification sent to confirm that the data was saved
		 * 
		 * The notification has no body.
		 * 
		 * The notification has no type.

		 */
		public const PERSISTENCE_DATA_RETRIEVE:String = getQualifiedClassName(this) + "PERSISTENCE_DATA_RETRIEVE";
		
		
		/**
		 * Notification sent to get location data
		 * 
		 * The notification has no body.
		 * 
		 * The notification has no type.
		 */
		public const RETRIEVE_GEOLOCATION_DATA:String = getQualifiedClassName(this) + "RETRIEVE_GEOLOCATION_DATA";
		
		/**
		 * Notification sent after to get location data
		 * 
		 * The notification has a GeolocationVO object as its body.
		 * 
		 * The notification has no type.
		 */
		public const GEOLOCATION_DATA_UPDATE:String = getQualifiedClassName(this) + "GEOLOCATION_DATA_UPDATE";
		
		/**
		 * Notification sent to get location data
		 * 
		 * The notification has no body.
		 * 
		 * The notification has no type.
		 */
		public const GEOLOCATION_DATA_TIMEOUT:String = getQualifiedClassName(this) + "GEOLOCATION_DATA_TIMEOUT";
		
		
		
		
		/**
		 * Notification sent when the state of the game is changed.
		 * 
		 * The notification has no body.
		 * 
		 * The type of notification is a string with the new state.
		 */
		public const CHANGE_STATE:String = getQualifiedClassName(this) + "CHANGE_STATE";
		
		/**
		 * Notification sent when the NativeApplication is activated.
		 * 
		 * The notification has no body.
		 * 
		 * The notification has no type.
		 */
		public const APP_ACTIVATED:String = getQualifiedClassName(this) + "APP_ACTIVATED";
		
		/**
		 * Notification sent when the NativeApplication is activated.
		 * 
		 * The notification has no body.
		 * 
		 * The notification has no type.
		 */
		public const APP_DEACTIVATED:String = getQualifiedClassName(this) + "APP_DEACTIVATED";
		
		/**
		 * Notification sent when the NativeApplication is activated.
		 * 
		 * The notification body is a string with the stage orientation.
		 * 
		 * The notification has no type.
		 */
		public const ORIENTATION_CHANGED:String = getQualifiedClassName(this) + "ORIENTATION_CHANGED";
		
		/**
		 * Notification sent to enable/disable rotation
		 * 
		 * The notification body is a boolean.
		 * 
		 * The notification has no type.
		 * 
		 * StageMediator interest
		 */
		public const ALLOW_ROTATION:String = getQualifiedClassName(this) + "ALLOW_ROTATION";
		
		/**
		 * Notification sent to force rotation.
		 * 
		 * The notification body is a string with the rotation type to force.
		 * 
		 * The notification has no type.
		 * 
		 * StageMediator interest
		 */
		public const FORCE_ORIENTATION:String = getQualifiedClassName(this) + "FORCE_ORIENATION";
		
		/**
		 * 
		 */
		public const REGISTER_VIEW_FOR_STARTUP:String = getQualifiedClassName(this) + ".REGISTER_VIEW_FOR_STARTUP";
		/**
		 * 
		 */
		public const INIT_VIEW:String = getQualifiedClassName(this) + ".INIT_VIEW";
		
		/**
		 * Notification used to enable the application to keep up with the progress of the layers transition
		 * animation.
		 * 
		 * The notification type can be one of the following:
		 * 	- 'start' - sent at the start of the transition animation;
         *  - 'addLayer' - sent when a layer has been added to the stage (the notification body is,
         * in this case, a string that holds the name of the layer that was just added);
         *  - 'removeLayer' - sent when a layer has beed removed from the stage (the notification body is,
         * in this case, a string that holds the name of the layer that was just removed);
         *  - 'complete' - sent at the end of the transition animation;
		 */
		public const LAYERS_TRANSITION_ACTION:String = getQualifiedClassName(this) + ".LAYERS_TRANSITION_ACTION";
		
		/**
		 * 
		 */
		public const INIT_LAYER_DISPLAY:String = getQualifiedClassName(this) + ".INIT_LAYER_DISPLAY";
		
		/**
		 * Sent when all the inits have been initialized
		 */
		public const VIEWS_INITIALIZED:String = getQualifiedClassName(this) + ".VIEWS_INITIALIZED";
		
		/**
		 * 
		 */
		public const INIT_DISPLAY:String = getQualifiedClassName(this) + ".INIT_DISPLAY";
		
		/**
		 * Sent when a view is added and updaded.
		 * 
		 * Notification is subclass of SuperMediator
		 * 
		 */
		public const VIEW_ADDED:String = getQualifiedClassName(this) + ".VIEW_ADDED";
		
		/**
		 * Notification sent by any mediator that wants to add its view to the stage and caught
		 * by the the AddViewCommand. This command does the actual adding to the skin child list.
		 * 
		 * The body of the notification has to be an object with the following properties:
		 * 		- child:DisplayObject The display object that will be added.
		 * 		- depth:uint The depth at which the child will be added.
		 */
		public const ADD_VIEW:String = getQualifiedClassName(this) + ".ADD_VIEW";
		
		/**
		 * Notification sent by any mediator that wants to add its view to the stage and caught
		 * by the the AddViewCommand. This command does the actual adding to the skin child list.
		 * 
		 * The body of the notification has to be an object with the following properties:
		 * 		- child:DisplayObject The display object that will be added.
		 * 		- depth:uint The depth at which the child will be added.
		 * 		
		 * The body type will determine the layer where the child will be added after all the other children have been remove
		 */
		public const ADD_UNIQUE_VIEW:String = getQualifiedClassName(this) + ".ADD_UNIQUE_VIEW";
		
		/**
		 * Notification sent by any mediator that wants to remove its view from stage and caught
		 * by the RemoveViewCommand. This command removes the view from the child list.
		 * 
		 * The body of the notification is an object that has the folowing properties:
		 * 		- child:DisplayObject The display object that will be removed.
		 */
		public const REMOVE_VIEW:String = getQualifiedClassName(this) + ".REMOVE_VIEW";
		
		/**
		 * Notification sent by any mediator that wants to add its view to the stage and caught
		 * by the the AddViewCommand. This command does the actual adding to the skin child list.
		 * 
		 * The body of the notification has to be an object with the following properties:
		 * 		- child:DisplayObject The display object that will be added.
		 * 		- depth:uint The depth at which the child will be added.
		 */
		public const SHOW_VIEW:String = getQualifiedClassName(this) + ".ADD_VIEW";
		
		/**
		 * Notification sent by any mediator that wants to remove its view from stage and caught
		 * by the RemoveViewCommand. This command removes the view from the child list.
		 * 
		 * The body of the notification is an object that has the folowing properties:
		 * 		- child:DisplayObject The display object that will be removed.
		 */
		public const HIDE_VIEW:String = getQualifiedClassName(this) + ".REMOVE_VIEW";
		
		// @ ACTIONS NOTIFICATIONS
		public const USER_ACTION:String = getQualifiedClassName(this) + ".USER_ACTION";
		
		
		
		// @ TRACKING NOTIFICATIONS
		/**
		 * Notification sent in order to start tracking.
		 * 
		 * The notification has no body.
		 */
		public const INIT_TRACKING:String = getQualifiedClassName(this) + ".INIT_TRACKING";
		
		// @@ SERVICES NOTIFICATIONS
		/**
		 * Notification sent to get a map from the google static map service.
		 * 
		 * The body of the notification is GoogleStaticMapVO object 
		 * 	required properties differ in the different map type request
		 * 	
		 * The type of the notification determines the type of map requested
		 *  it possible values are defined as constants in the GoogleStaticMapProxy
		 */
		public const GOOGLE_STATIC_MAP_ACTION:String = getQualifiedClassName(this) + ".LOAD_GOOGLE_STATIC_MAP";
		
		public const GOOGLE_STATIC_MAP_LOADED:String = getQualifiedClassName(this) + ".GOOGLE_STATIC_MAP_LOADED";
		
		public const GOOGLE_STATIC_MAP_FAILED:String = getQualifiedClassName(this) + ".GOOGLE_STATIC_MAP_FAILED";
		
		
		
		// @@ FSM NOTIFICATIONS
		/**
		 * Notification sent in order to initialize the FSM.
		 * 
		 * The notification has no body.
		 */
		public const REGISTER_FSM:String = getQualifiedClassName(this) + ".REGISTER_FSM";
		
		/**
		 * Notification sent in order to register previous state.
		 * 
		 * The notification has no body.
		 */
		public const REGISTER_EXITING_STATE:String = getQualifiedClassName(this) + ".REGISTER_EXITING_STATE";
		
		/**
		 * Notification sent when a client-side action must interract with the server.
		 * 
		 * The notification body could be null or have an object with the default field "value".
		 * 
		 * For this notification a ServerActionCommand should be registered.
		 */
		public const SERVER_ACTION:String = getQualifiedClassName(this) + ".SERVER_ACTION";
        
        /**
         * Notification sent when the server responds to a client action. This notification must be 
         * a response to the SERVER_ACTION notification.
         * 
         * The notification body is an object that holds the data received from the server.
         */
        public const SERVER_RESPONSE:String = getQualifiedClassName(this) + ".SERVER_RESPONSE";
		
		/**
		 * Notification sent within the client, when it needs to transition to another state.
		 * 
		 * The notification body could be null or have an object with the default field "value".
		 * 
		 * For this notification a ClientActionCommand should be registered.
		 */
		public const CLIENT_ACTION:String = getQualifiedClassName(this) + ".CLIENT_ACTION";	
		
		
		public const INITIAL:String = getQualifiedClassName(this) + ".INITIAL";
		
		public const WAIT_FOR_NEXT_ACTION:String = getQualifiedClassName(this) + ".WAIT_FOR_NEXT_ACTION";
		
		public const TRACE:String = getQualifiedClassName(this) + ".TRACE";
		
		
		
		
		
		
	}
}
