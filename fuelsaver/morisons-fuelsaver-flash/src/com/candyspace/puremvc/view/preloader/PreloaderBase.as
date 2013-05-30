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
package com.candyspace.puremvc.view.preloader
{

	import flash.display.MovieClip;

	import com.candyspace.puremvc.view.preloader.IPreloader;

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
	public class PreloaderBase extends MovieClip implements IPreloader
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		// --------------------------------------
		// Constructor
		// --------------------------------------
		public function PreloaderBase()
		{
		}

		// --------------------------------------
		// Methods - Init
		// --------------------------------------
		public function init(config:Object):void
		{
		}

		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		public function progress(percent:Number):void
		{
			trace("PreloaderBase :: progress :: percent:", percent);
		}
		// --------------------------------------
		// Event handlers
		// --------------------------------------
	}
}
