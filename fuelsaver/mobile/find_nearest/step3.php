<?php 
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
	$stores = $api->findStores();
?>

<div id="step3">
	<?php if ($stores) {?>
		<h1><?php echo count($stores) ?> Results near <?php echo $_POST['postcode']?></h1>
		<?php foreach ($stores as $store) {?>
		<div class="result box_bg">
			<div class="top">
				<h2>Store Details</h2>
				<p><?php echo $store->street; ?></p>
				<p><?php echo $store->city; ?></p>
				<p><?php echo $store->postcode; ?></p>
				<p><a href="tel:<?php echo $store->tel; ?>"><?php echo $store->tel; ?></a></p>
			</div>
			<div class="bottom">
				<h2>Opening Hours</h2>
				<?php foreach ($store->opening_times as $time) {?>
				<?php foreach ($time as $day => $hours) {?>
				<p><?php echo ucfirst ($day);?> - <?php echo $hours;?></p>
				<?php }?>
				<?php }?>
			</div>
			<div class="map">
				<a href="http://maps.google.com/maps?z=12&t=m&q=loc:<?php echo $store->long; ?>,<?php echo $store->lat?>"><img width="90%" src="http://maps.googleapis.com/maps/api/staticmap?size=400x240&scale=1&zoom=16&sensor=false&markers=icon:http://9e8c5f3f6d207d69fa78-5e22e9b12f943cd58ffcd76fee4cede4.r56.cf3.rackcdn.com/MMiconNew.png|shadow:false|<?php echo $store->long; ?>,<?php echo $store->lat?>"/></a>
			</div>
		</div>
	    <?php }?>
	<?php } else { ?>
    <h1>Please enter a valid post code</h1><br/>
	<?php } ?>
<?php } else { ?>
  <h1>Please enter a valid post code</h1><br/>
<?php } ?>
	<a href="<?php echo$base_url?>find_nearest/step2"><img width="50%" src="<?php echo$image_url?>search_again_btn.png"/></a>
</div>

