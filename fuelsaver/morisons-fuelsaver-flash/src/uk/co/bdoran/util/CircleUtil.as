package uk.co.bdoran.util {
	import flash.geom.Point;

	/**
	 * @author Ben
	 */
	public class CircleUtil 
	{
		public static function getNPointsOnCircle( center:Point, radius:Number, n:Number = 10 ) : Array/*of Number*/{
		    var alpha:Number = Math.PI * 2 / n;
		    var points:Array = new Array( n );
		    var i:int = -1;
		    while( ++i < n ){
		        var theta:Number = alpha * i;
		        var pointOnCircle:Point = new Point( Math.cos( theta ) * radius, Math.sin( theta ) * radius );
		        points[ i ] = center.add( pointOnCircle );
		    }
		    return points;
		} 
	}
}
