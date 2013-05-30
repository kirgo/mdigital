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
package com.candyspace.puremvc.facade
{

	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.IProxy;

	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;

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
	// INTERFACE
	// --------------------------------------
	/**
	 * Interface Comment
	 */
	public interface IAppFacade extends IFacade
	{
		function init():void;

		function get application():DisplayObjectContainer;

		function get stage():Stage;

		function get currentState():String;

		function set currentState(value:String):void;

		function get applicationLayers():Array;

		function set applicationLayers(value:Array):void;

		function registerApplication(applicationView:DisplayObjectContainer):void;

		function initApplicationLayers():void;

		function initCustomProxies():void;

		function initCustomCommands():void;

		function initCustomViews():void;

		function initCustomMediators():void;

		function replaceCommand(notificationName:String, commandClassRef:Class):void;

		function replaceProxy(proxy:IProxy):void;

		function replaceMediator(mediator:IMediator):void;
	}
}
