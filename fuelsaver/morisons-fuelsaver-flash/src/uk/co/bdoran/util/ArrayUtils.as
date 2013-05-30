package uk.co.bdoran.util {

	/**
	 * @author greppinfunk
	 */
	public class ArrayUtils {
		
		public static function getDifferences( a : Array, b : Array ) : Array {
			var returnArray : Array = [];
			
			for each( var element : Object in a ){
				if( b.indexOf( element ) == -1 ) {
					returnArray.push( element );
				}
			}
			
			return returnArray;
		}
	}
}
