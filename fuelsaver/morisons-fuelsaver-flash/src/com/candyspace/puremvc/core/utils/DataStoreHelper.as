package com.candyspace.puremvc.core.utils
{
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.sampler.NewObjectSample;

	/**
	 * @author bendoran
	 */
	public class DataStoreHelper {
		
		public static function writeObjectToFile( object : Object, fileName : String ) : void {
			var file : File = File.applicationStorageDirectory.resolvePath( fileName );
			
			if (file.exists){
				file.deleteFile();
			}
			var fileStream : FileStream = new FileStream();
			fileStream.open( file, FileMode.WRITE );
			fileStream.writeObject( object );
			fileStream.close();
			
		}


        public static function clearFileByName(fileName:String) :void{

            var file : File  = File.applicationStorageDirectory.resolvePath(fileName);

            if(file.exists)
            {
                file.deleteFile();

            }

        }


		public static function readObjectFromFile( fileName : String ) : Object {
			
			var file : File = File.applicationStorageDirectory.resolvePath( fileName );
			
			if( file.exists ){

                //trace("file exists:", file.nativePath);
				var obj:Object;
				var fileStream:FileStream = new FileStream();
				fileStream.open(file, FileMode.READ);
				obj = fileStream.readObject();
				fileStream.close();
				return obj;		
				
			}else{
				
				//////trace("file doesn't exists:", file.nativePath);
				return null;
				
			}
		}
		
		
		public static function sortFileArrayByDate( array : Array ) : Array {
			if (array.length == 0){
				return array;
			}
			
			var pivot : File = array[0];
			var left : Array = [];
			var right : Array = [];
			
			for( var i : int = 1; i < array.length; i++ ){
				if( File( array[ i ] ).creationDate < pivot.creationDate ){
					left.push( array[i] );
				}else{
					right.push( array[i] );
				}
			}
			return sortFileArrayByDate(left).concat( pivot, sortFileArrayByDate(right) );
		}
		
	}
}
