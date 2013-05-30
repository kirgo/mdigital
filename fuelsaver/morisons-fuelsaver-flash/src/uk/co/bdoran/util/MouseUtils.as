package uk.co.bdoran.util {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * @author BenD
	 */
	public class MouseUtils {
		public static function mouseEnabledAllChildren(displayObject : DisplayObject, enabled:Boolean = true):void{
			if( displayObject is DisplayObjectContainer ){
				DisplayObjectContainer(displayObject).mouseEnabled = enabled;
				for (var i : int = 0; i < DisplayObjectContainer(displayObject).numChildren-1; i++) {
					mouseEnabledAllChildren(DisplayObjectContainer(displayObject).getChildAt(i) as DisplayObjectContainer, enabled);
				}	
			}		
		}
	}
}
