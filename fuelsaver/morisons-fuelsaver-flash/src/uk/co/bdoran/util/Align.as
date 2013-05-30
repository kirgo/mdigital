package uk.co.bdoran.util {
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	/*
	  Copyright (c) 2009, Benjamin Doran
	  All rights reserved.
	 */

	/**
	 * 	Class provides alignment utilities in AS3, these utilies 
	 * 	follow closely Flexs Display placement model, including functionality 
	 * 	for VBOX and HBOX style display objects.
	 * 	
	 * 	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@tiptext
	 */	
	public class Align {
		
		/**
		 * Alighment Constant Pased to Alignment Functions when a Left Alignment is required.
		 */
		public static const LEFT : String = "left";
		
		/**
		 * Alighment Constant Pased to Alignment Functions when a Right Alignment is required.
		 */
		public static const RIGHT : String = "right";
		
		/**
		 * Alighment Constant Pased to Alignment Functions when a Center Alignment is required.
		 */
		public static const CENTER : String = "center";
		
		/**
		 * Alighment Constant Pased to Alignment Functions when a Top Alignment is required.
		 */
		public static const TOP : String = "top";
		
		/**
		 * Alighment Constant Pased to Alignment Functions when a Bottom Alignment is required.
		 */
		public static const BOTTOM : String = "bottom";
		
		/**
		 * Static function that applies a VBOX layout to a DisplayObjectContainer this function 
		 * loops through the display tree and places the objects from top to 
		 * bottom based on there order the display list.
		 * 
		 * @param target DisplayObjectContainer Target display object to apply vertical alignment
		 * @param verticlePadding int The amount of padding to place between each element
		 * @param startPadding int The amount of inital padding to place at the start
		 * @param horizontalAlign String The type of horizontal aligment to apply to the box, can be <code>LEFT</code>, <code>RIGHT</code> or <code>CENTER</code>
		 * @param animate Boolean Turns on Tweener based animation, this will animate the movement or realignment of the box. Can be handy when removing or adding objects to a vbox
		 * @param time int Animation Time, (only relevant if Animation is active)
		 */		
		public static function VBOX ( target : DisplayObjectContainer , verticlePadding : int = 0, startPadding : int = 0,  horizontalAlign : String = Align.LEFT, animate : Boolean = false, time : int = 1) : void {
			if( target.numChildren == 0 || target.numChildren == 1 ){
				return;
			}
			var points : Array = new Array();
			for ( var i : int = 0; i < target.numChildren; i++ ){	
				if( i != 0){
					var previousClip : DisplayObject = target.getChildAt( i - 1 );
					points[i] = ( points[i-1] + previousClip.height ) + verticlePadding;
				}else{
					points[i] = startPadding;
				}				
			}
			
			for ( var j : int = 0; j < target.numChildren; j++ ){
				var targetX : Number = 0;
				var targetY : Number = points[j];
				
				var clip : DisplayObject = target.getChildAt( j );
				
				if( horizontalAlign == RIGHT ){
					targetX = target.width - clip.width;
				}
				
				if(horizontalAlign == CENTER){
					targetX = (target.width/2) - (clip.width/2);
				}
				
				if(animate){
					//Tweener.addTween( clip, {x:targetX, y:targetY, time:time, transition:"easeInOutQuad"});
					TweenLite.to( clip, time, { x : targetX, y : targetY, ease : Quad.easeInOut } );
				}else{
					clip.x = targetX;
					clip.y = targetY;
				}
			}
		}
		
		/**
		 * Static function that applies a HBOX layout to a DisplayObjectContainer this function 
		 * loops through the display tree and places the objects from left to 
		 * right based on there order the display list.
		 * 
		 * @param target DisplayObjectContainer Target display object to apply horizontal alignment
		 * @param horizontalPadding int The amount of padding to place between each element
		 * @param startPadding int The amount of inital padding to place at the start
		 * @param verticleAlign String The type of verticle aligment to apply to the box, can be <code>TOP</code>, <code>MIDDLE</code> or <code>BOTTOM</code>
		 * @param animate Boolean Turns on Tweener based animation, this will animate the movement or realignment of the box. Can be handy when removing or adding objects to a vbox
		 * @param time int Animation Time, (only relevant if Animation is active)
		 * @param tweenType int Type of Animation (see Tweener Packages), (only relevant if Animation is active)
		 * @param motionBlur int Activates Motion blue on the moving items, (only relevant if Animation is active)
		 * @param staggered int Staggers the animtion, the items move in one after the other, (only relevant if Animation is active)
		 */		
		public static function HBOX ( 	
			target : DisplayObjectContainer , 
			horizontalPadding : int = 0, 
			startPadding : int = 0, 
			animate : Boolean = false, 
			time : Number = 1, 
			motionBlur : Boolean = false, 
			staggered : Boolean = false) : void 
		{
			if( target.numChildren == 0 || target.numChildren == 1 ){
				return;
			}
			var points : Array = new Array();
			for ( var i : int = 0; i < target.numChildren; i++ ){	
				if( i != 0){
					var previousClip : DisplayObject = target.getChildAt( i - 1 );
					points[i] = ( points[i-1] + previousClip.width ) + horizontalPadding;
				}else{
					points[i] = startPadding;
				}				
			}
			
			for ( var j : int = 0; j < target.numChildren; j++ ){
				var targetX : Number = points[j];
				
				var clip : DisplayObject = target.getChildAt( j );
				
				if(animate){
					if(motionBlur){
						var blur : MotionBlur = new MotionBlur();
						blur.addMotionBlur( clip );
					}
					
					var delay : Number = 0;
					
					if( staggered ){
						delay = (j/target.numChildren) + (time/target.numChildren);
					}
					
					//Tweener.addTween( clip, {x:targetX, time:time, delay:delay, transition:tweenType, onComplete:function():void
					TweenLite.to( clip, time, { x : targetX, ease : Quad.easeInOut, onComplete:function():void
						{
							if(blur){
								blur.remove();
							}
						}
					});
				}else{
					clip.x = targetX;
				}
			}
		}
		
 		public static function GBOX( target : DisplayObjectContainer, horizontalPadding : int, verticalPadding : int, columns : int ) : void {
			var previousChild : DisplayObject;
			var columnCounter : int = 0;
			for (var i : int = 0; i < target.numChildren; i++) {
				var child : DisplayObject = target.getChildAt(i);						
				if( i != 0 ){
					columnCounter ++;
					if( columnCounter >= columns ){
						columnCounter = 0;
						child.x = 0;
						child.y = previousChild.y + previousChild.height + verticalPadding;
					}else{
						child.x = previousChild.x + previousChild.width + horizontalPadding;
						child.y = previousChild.y;
					}
				}
				previousChild = child;
			}
		}
		
		/**
		 * Aligns a <code>DisplayObjectContainer</code> based in the Horizontal Center based on another <code>DisplayObjectContainer</code>.
		 * Can be passed a <code>Stage</code>; (Works based on top left Origin Placement)
		 */
		public static function HCENTER( target : DisplayObjectContainer, parent : DisplayObjectContainer ) : void{
			target.x = parent is Stage ? Stage(parent).stageWidth/2 - target.width/2 : parent.width/2 - target.width/2;
		}
		
		/**
		 * Aligns a <code>DisplayObjectContainer</code> based in the Verticle Center based on another <code>DisplayObjectContainer</code>.
		 * Can be passed a <code>Stage</code>; (Works based on top left Origin Placement)
		 */
		public static function VCENTER( target : DisplayObjectContainer, parent : DisplayObjectContainer ) : void{
			target.y = parent is Stage ? Stage(parent).stageHeight/2 - target.height/2 : parent.height/2 - target.height/2;
		}
		
		/**
		 * Aligns a <code>DisplayObjectContainer</code> based in the Horizontal & Vertical Center based on another 
		 * <code>DisplayObjectContainer</code>. Can be passed a <code>Stage</code>; (Works based on top left Origin Placement)
		 */
		public static function ACENTER( target : DisplayObjectContainer, parent : DisplayObjectContainer ) : void {
			HCENTER( target, parent);
			VCENTER( target, parent);
		}
	}
}
