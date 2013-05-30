package uk.co.bdoran.util {
	import flash.display.DisplayObject;
	import flash.display.Stage;

	/**
	 * @author greppinfunk
	 */
	public class DisplayObjectUtils {
		
		public static function getStageContentsHeight( stage : Stage ) : Number {
			var height : Number = 0;
			for (var i : int = 0; i < stage.numChildren; i++) {
				var child : DisplayObject = stage.getChildAt(i);
				if( child.y + child.height > height ){
					height = child.y + child.height;
				}
			}			
			return height;
		}
		
		public static function getStageContentsWidth( stage : Stage ) : Number {
			var width : Number = 0;
			for (var i : int = 0; i < stage.numChildren; i++) {
				var child : DisplayObject = stage.getChildAt(i);
				if( child.x + child.height > width ){
					width = child.x + child.width;
				}
			}			
			return width;
		}
	}
}
