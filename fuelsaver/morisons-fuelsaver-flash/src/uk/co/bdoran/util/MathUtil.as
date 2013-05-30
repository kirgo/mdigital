package uk.co.bdoran.util {

	/**
	 * @author BenD
	 */
	public class MathUtil {
		public static function randomRange( min : Number, max : Number) : Number {
			return Math.random() * (max - min) + min;
		}
	}
}
