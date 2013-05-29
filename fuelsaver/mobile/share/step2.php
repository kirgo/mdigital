<?php 
$config = $api->getConfig ();
?>
<div id="step2">
	<p>Tell your friends about Fuel Saver</p>
	<div class="buttons">
		<div class="full_width_btn">
			<script>function fbs_click() {
				var u="http://www.morrisonsfuelsaver.co.uk";
				var t="Try Morrisons new fuel savings calculator and see how much you could save on your next Morrisons fuel bill.";
				//window.open('http://www.facebook.com/sharer.php?&u='+encodeURIComponent(u)+'&t='+encodeURIComponent(t),'sharer','toolbar=0,status=0,width=626,height=436');
				window.open(
					'http://www.facebook.com/dialog/feed?app_id=<?php echo $config->variables->fbappid; ?>&'+
					'link=http://www.morrisonsfuelsaver.co.uk&' +
					'picture=http://fbrell.com/f8.jpg&'+
					'name=Morrisons%20Fuelsaver&'+
					'caption=Reference%20Documentation&'+
					'description=Try%20Morrisons%20new%20fuel%20savings%20calculator%20and%20see%20how%20much%20you%20could%20save%20on%20your%20next%20Morrisons%20fuel%20bill.'
				);
				return false;}
			
				</script>

			<a rel="nofollow" href=#" onclick="return fbs_click()" target="_blank">
				<img width="100%" src="<?php echo $image_url?>share_facebook.png"/>
			</a>
		</div>
		<div class="full_width_btn">
			<a class="twitter" target="_blank" href="http://twitter.com/share?url=http://www.morrisonsfuelsaver.co.uk&text=Try Morrisons new fuel savings calculator and see how much you could save on your next Morrisons fuel bill.">
				<img width="100%" src="<?php echo $image_url?>share_twitter.png"/>
			</a>
		</div>
	</div>
		
	<div class="find_social_box"><img src="<?php echo $image_url?>sml_facebook_icon.png"/><p>Like Morrisons on Facebook <a href="https://www.facebook.com/Morrisons" target="_blank">here</a></p></div>
	<div class="find_social_box"><img src="<?php echo $image_url?>sml_twitter_icon.png"/><p>Find Morrisons on Twitter <a href="http://twitter.com/morrisonsoffers" target="_blank">here</a></p></div>
</div>
