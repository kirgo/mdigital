<?php
$config = $api->getConfig ();
?>
	<p>To find out how much you could save on fuel, tell us how much you spend on these each month. (We promise not to tell anyone.)</p>
<div id="step2" class="box_bg">
	
    <form method="POST" action="step3" id="touchDisabledForm">
	
	<div class="touch_enabled">
	    <?php foreach ($config->categories->category as $category) {?>
		<h2><?php echo str_replace("_and_"," & ", $category->name); ?></h2>
		<div id="<?php echo $category->name ?>" data-max="<?php echo $category->max ?>" class="slider">
			<div class="slider_dot">
				<img src="<?php echo $image_url?>slider_dot.png"/>
			</div>
			<div class="slider_empty">
				<img width="100%" src="<?php echo $image_url?>slider_empty.png"/>
			</div>	
			<div class="slider_full">
				<img src="<?php echo $image_url?>slider_full.png"/>
			</div>	
			<div class="saving_number">
				<h2>&pound;<span>0</span></h2>
			</div>
		    <input type="hidden" id="touch_categories_<?php echo $category->name ?>" name="categories[<?php echo $category->name ?>]"/> 
		</div>
		<div class="line">
			<img width="100%" src="<?php echo $image_url?>line.png"/>
		</div>
	    <?php }?>
	</div>
	 
	<div class="touch_disabled">
	    <?php foreach ($config->categories->category as $category) {?>
			<h2><?php echo str_replace("_and_"," & ", $category->name); ?></h2>
			<div id="<?php echo $category->name ?>" data-max="<?php echo $category->max ?>" class="plus_minus_bar">
				<div onmousedown="minusClick(this);" class="minus js_enabled">
					<img src="<?php echo $image_url?>minus.png"/>
				</div>
				<div class="saving_number js_enabled">
					<h2>&pound;<span>0</span></h2>
				</div>
				<div onmousedown="plusClick(this);" class="plus js_enabled">
					<img src="<?php echo $image_url?>plus.png"/>
				</div>
			    <input type="text" val="0" id="categories_<?php echo $category->name ?>" class="no_js_box" name="categories[<?php echo $category->name ?>]"/> 
			</div>
			<div class="line">
				<img width="100%" src="<?php echo $image_url?>line.png"/>
			</div>
	    <?php }?>
	</div>
	<div class="full_width_btn">
		<a href="#" id="formSubmit" class="js_enabled">
			<img width="100%" src="<?php echo$image_url?>calculate_saving_btn.png"/>
		</a>
	</div>	
	<input type="image" class="no_js" src="<?php echo$image_url?>calculate_saving_btn.png" value="Submit" width="100%"/>
	</form>
</div>
