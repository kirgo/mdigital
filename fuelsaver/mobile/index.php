<?php
	$base_url = "/fuelsaver/";
	$image_url = $base_url."mobile/images/";


	$args = array();
	if( isset( $_GET["args"] ) ){
		$argString = $_GET["args"];
		if( substr($argString, -1) == "/" ){
			$argString = substr_replace($argString ,"",-1);
		}
		$args = explode( "/" , $argString );
	}
	
	if( count( $args ) == 0 ){
		$page = "fuel_calc";
	}else{
		switch( $args[0] ){
			case "fuel_calc" : 
				$page = "fuel_calc";
				break;
			case "sign_up" : 
				$page = "sign_up";
				break;
			case "find_nearest" : 
				$page = "find_nearest";
				break;
			case "share" : 
				$page = "share";
				break;
			default: 
				$page = "fuel_calc";
				break;
		}
	}
	
	//echo "Received the following URL args: ";
	//var_dump( $args );

	include_once( "header.php" );
	?>
	<div id="<?php echo $page?>" class="content">
		<?php 
		
			if( !isset( $args[1] ) ){
				$section = "step1";
			}else{
				switch( $args[1] ){
					case "step1" : 
						$section = "step1";
						break;
					case "step2":
						$section = "step2";
						break;
					case "step3":
						$section = "step3";
						break;
					case "terms":
						$section = "terms";
						break;
					default: 
						$section = "step1";
						break;
				}
			}
			
			include_once( $page."/".$section . ".php" );
		
		?>
	</div>
	
	<?php 
	include_once( "footer.php" );
	