<?php
$errors = false;
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
	$errors = true;
} else if ($_POST ['terms'] === '0') {
	$errors = true;
} else {
	$response = $api->collect ();
	if (!$response) {
		$errors = true;
	}
}
?>
<?php if ($errors) {?>

 <?php if($errors == 'terms') {?>
 <div id="step3" class="">
    <h1>Please agree to the terms and conditions if you wish to sign up.</h1><br/>
    <a href="<?php echo$base_url?>sign_up/step2"><img width="35%" src="<?php echo$image_url?>retry_btn.png"/></a>
 </div>
 <?php } else {?> 
 <div id="step3" class="">
    <h1>Please enter a valid email address</h1><br/>
    <a href="<?php echo$base_url?>sign_up/step2"><img width="35%" src="<?php echo$image_url?>retry_btn.png"/></a>
 </div>
 <?php }?>
<?php } else {?>
 <div id="step3" class="box_bg">
	    <h1>Thanks for registering.Your details have been submitted.</h1>
	    <p>Why not try our new fuel savings calculator and see how much you could save next time you fill up at Morrisons.</p>
	    <div class="full_width_btn">
		   <a href="<?php echo $base_url?>fuel_calc/step2"><img width="100%" src="<?php echo$image_url?>open_fuel_calc_btn.png"/></a>
	    </div>
    </div>
<?php } ?>