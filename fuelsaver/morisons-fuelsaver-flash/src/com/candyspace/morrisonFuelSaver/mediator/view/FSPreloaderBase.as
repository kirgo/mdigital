// // // //////////////////////////////////////////////////////////////////////////
//
// CANDYSPACE
// Copyright 2012 CANDYSPACE
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // // // ////////////////////////////////////////////////////////////////////////
package com.candyspace.morrisonFuelSaver.mediator.view
{

	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------

	import com.candyspace.puremvc.view.preloader.IPreloader;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Strong;

	import flash.display.MovieClip;
	import flash.display.Sprite;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class FSPreloaderBase extends MovieClip implements IPreloader
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		protected var _fuelIcon:Sprite;
		protected var _signIcon:Sprite;
		protected var _searchIcon:Sprite;
		protected var _shareIcon:Sprite;

		private var timeline : TimelineLite;

		// --------------------------------------
		// Constructor
		// --------------------------------------
		public function FSPreloaderBase()
		{
			initVars();
		}

		// --------------------------------------
		// Methods - Init
		// --------------------------------------
		
		private function initVars():void
		{
			_fuelIcon = getIcon("fuel");
			_fuelIcon.alpha = 0;
			
			_signIcon = getIcon("sign");
			_signIcon.alpha = 0;
			
			_searchIcon = getIcon("search");
			_searchIcon.alpha = 0;
			
			_shareIcon = getIcon("share");
			_shareIcon.alpha = 0;
			
			startAnimation();
		}
		
		public function init(config:Object):void
		{
		}

		public function progress(percent:Number):void
		{
		}
		
		// --------------------------------------
		// Methods - Protected
		// --------------------------------------
		
		private function startAnimation():void
		{
			timeline = new TimelineLite();
			timeline.append(new TweenLite(_fuelIcon, 1, {alpha:1, ease:Strong.easeOut}));
			timeline.append(new TweenLite(_signIcon, 1, {alpha:1, ease:Strong.easeOut}));
			timeline.append(new TweenLite(_searchIcon, 1, {alpha:1, ease:Strong.easeOut}));
			timeline.append(new TweenLite(_shareIcon, 1, {alpha:1, ease:Strong.easeOut}));
			timeline.insertMultiple(TweenMax.allTo([_fuelIcon, _signIcon, _searchIcon, _shareIcon], 0.3, {alpha:0, ease:Strong.easeOut, onComplete:timeline.restart}), timeline.duration);
			
		}
				
		protected function getIcon(name:String):Sprite
		{
			return (getChildByName("preloader") as Sprite).getChildByName(name) as Sprite;
		}

	}
}
