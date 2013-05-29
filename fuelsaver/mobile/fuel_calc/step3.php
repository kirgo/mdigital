<?php 

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
	//foreach ($_POST['categories'] as $name => &$value) {
	//	$value = substr($value, 2);//get rid of pound signs
	//}
}

?>
<div id="step3" class="box_bg">
	<h2>If you use gift cards to pay for all those things you normally buy, you could save</h2>
	<div class="line">
		<img width="100%" src="<?php echo $image_url?>line.png"/>
	</div>
	<div class="saver_value">
		<h1>&pound;<?php echo $api->calculate() ?></h1>
		<h2>off a litre of fuel</h2>
	</div>
	<div class="full_width_btn">
		<a href="http://www.morrisonsfuelsaver.co.uk/" target="_blank"><img width="100%" src="<?php echo$image_url?>find_out_more_btn.png"/></a>
	</div>
</div>