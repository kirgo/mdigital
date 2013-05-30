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
package com.candyspace.puremvc.view.preloader
{
	/**
	 * @author Carlos D. Rodriguez
	 */
	public interface IPreloader
	{
        function init(config:Object):void;
        
		function progress(percent:Number):void;
	}
}
