package uk.co.bdoran.util {
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author greppinfunk
	 */
	public class TextUtil {
		public static function setTextColor( textField : TextField, color : uint ) : void{
			var textFormat : TextFormat = textField.getTextFormat();
			textFormat.color = color;
			textField.setTextFormat( textFormat );
		}
		
		public static function flowTextAcrossFields( text : String, htmlText : Boolean, ...containers ) : void{
			var endChar : Number = text.length;
			var startChar : Number = 0;
						
			for each( var field : TextField in containers ){
				if( field.maxChars < text.length - startChar ){
					if( htmlText ) {
						field.htmlText = text.substr( startChar, endChar );
					}else{
						field.text = text.substr( startChar, endChar );
					}
					startChar += field.maxChars;
				}else{
					if( htmlText ){
						field.htmlText = text.substr( startChar, endChar );
					}else{
						field.text = text.substr( startChar, endChar );
					}
					return;
				}
			}
		}
	}
}
