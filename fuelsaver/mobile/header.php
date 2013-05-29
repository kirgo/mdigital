<?php
	session_start ();
	include (__DIR__.'/lib/FuelSaverApi.php');
	$api = new FuelSaverApi ('http://' . $_SERVER['HTTP_HOST'] . '/fuelsaver/services');
	$api->getUUID ();
	$APPLICATION_ENV = getenv ('APPLICATION_ENV');
	
?>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<title>Morrisons Fuel Saver</title>
		<meta name="description" content="" />
		<meta name="author" content="Candyspace" />
		<meta name="viewport" content="width=device-width; initial-scale=1.0" />
		<meta name="format-detection" content="telephone=no">
		<link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,300,400,700' rel='stylesheet' type='text/css'>
		<link type="text/css" href="<?php echo $base_url?>mobile/css/site.css?<?php echo time()?>" rel="stylesheet"/>
		<link rel="shortcut icon" href="<?php echo $image_url?>/favicon.ico" />
		<link rel="apple-touch-icon" href="<?php echo $image_url?>/apple-touch-icon.png" />
		<link rel="apple-touch-icon" sizes="114x114" href="<?php echo $image_url?>/touch-icon-iphone4.png" />
	</head>
	
	<body>
		<header>
			<a href="<?echo $base_url?>"><img width="100%" src="<?php echo $image_url?>/header.png"/></a>
		</header>
		<nav>
			<div id="" class="navitem">
				<a href="<?php echo $base_url?>fuel_calc"><img width="100%" src="<?php echo $image_url?>/nav/fuel_<?php echo $page=="fuel_calc"? "active" : "inactive" ?>.png"/></a>
			</div>
			<div id="" class="navitem">
				<a href="<?php echo $base_url?>sign_up"><img width="100%" src="<?php echo $image_url?>/nav/sign_up_<?php echo $page=="sign_up"? "active" : "inactive" ?>.png"/></a>
			</div>
			<div id="" class="navitem">
				<a href="<?php echo $base_url?>find_nearest"><img width="100%" src="<?php echo $image_url?>/nav/search_<?php echo $page=="find_nearest"? "active" : "inactive" ?>.png"/></a>
			</div>
			<div id="" class="navitem">
				<a href="<?php echo $base_url?>share"><img width="100%" src="<?php echo $image_url?>/nav/share_<?php echo $page=="share"? "active" : "inactive" ?>.png"/></a>
			</div>
		</nav>
		
