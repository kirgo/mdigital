		<footer>
		</footer>
		<script>window.UUID = '<?php echo $_SESSION['uuid']; ?>';</script>	
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
		<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/jquery-ui.min.js"></script>
		<script type="text/javascript" src="<?php echo $base_url?>mobile/js/jquery.ui.touch.js"></script>
		<script type="text/javascript" src="<?php echo $base_url?>mobile/js/slider.js?<?php echo time()?>"></script>
		<script type="text/javascript" src="<?php echo $base_url?>mobile/js/site.js?<?php echo time()?>"></script>
		<?php if( $APPLICATION_ENV == "staging" || $APPLICATION_ENV == "production" ): ?>
			<script type="text/javascript">
	
			  var _gaq = _gaq || [];
			  _gaq.push(['_setAccount', 'UA-21772255-72']);
			  _gaq.push(['_trackPageview']);
			
			  (function() {
			    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
			    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
			    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
			  })();
			
			</script>
		<?php else: ?>
			<!-- NO TRACKING REQUIRED -->
		<?php endif; ?>
	</body>
</html>