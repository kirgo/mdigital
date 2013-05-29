<div id="step2">
	<p>Stay in touch and hear all about Morrisons competitions, offers and the latest news by signing up to our monthly newsletter.</p>
	<div class="box_bg">
		<div class="form">
			<form method="POST" action="step3">
				<div class="text_input"><input type="text" name="email" placeholder="Email address"/></div>
				<input type="hidden" id="optin" name="optin" value="1"/>
				<div id="hear_from_morrisons"><img width="20%" onclick="swap_fear_from_value(this)" src="<?php echo$image_url?>checked_checkbox.png" alt=""/><p>Yes, I'd like to hear from the <a href="http://www.morrisons.co.uk/Privacy-Policy/">Morrisons family</a></p></div>
				<input type="hidden" id="terms" name="terms" value="0"/>
				<div id="terms_checkbox"><img width="20%" onclick="swap_terms_value(this)" src="<?php echo$image_url?>empty_checkbox.png" alt=""/><p>I agree to the <a href="http://www.morrisons.co.uk/Terms-and-conditions/">terms & conditions</a></p></div>
			</form>
		</div>
		<div class="full_width_btn">
			<a href="#" id="formSubmit">
				<img width="100%" src="<?php echo$image_url?>keep_updated_btn.png" alt=""/>
			</a>
		</div>
	</div>
</div>
