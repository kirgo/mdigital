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
package com.candyspace.puremvc.model.startupmanager
{

	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	import org.puremvc.as3.multicore.utilities.startupmanager.model.StartupResourceProxy;
	
	/**
	 * @author Carlos D. Rodriguez
	 */
	public class EntityProxy  extends Proxy implements IProxy
	{
		public function EntityProxy(name:String)
		{
			super(name);
		}

		protected function sendLoadedNotification(noteName:String, noteBody:String, srName:String):void
		{
			var srProxy:StartupResourceProxy = facade.retrieveProxy(srName) as StartupResourceProxy;
			if ( !srProxy.isTimedOut() )
			{
				sendNotification(noteName, noteBody);
			}
		}
	}
}
