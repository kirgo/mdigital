<?php 
	$baseUrl = 'http';
	if(isset( $_SERVER["HTTP_SSLSESSIONID"] ) ) {
		$baseUrl .= "s";
	}
	$baseUrl .= "://";
	$baseUrl .= $_SERVER['HTTP_HOST'];

    $canvasMode = false;
    if( isset( $_GET['fb'] ) ){ 
      	if( $_GET['fb'] == "true" ){
        	$canvasMode = true;
    	}
	}		

    $noMenu = false;
     if( isset( $_GET['no-menu'] ) ){ 
        if( $_GET['no-menu'] == "true" ){
            $noMenu = true;
        }
    }
    
    $closeLink = false;
     if( isset( $_GET['close-link'] ) ){ 
        if( $_GET['close-link'] == "true" ){
            $closeLink = true;
        }
    }
    
    $swfFile = $baseUrl."/fuelsaver/flash/FuelSaverApp.swf";

    $swfURL = $swfFile."?mod=".filemtime($swfFile)."&baseURL='".$baseUrl."'";

    if( $noMenu ){
        $swfURL .= "&noMenu=true";
    }else{
        $swfURL .= "&noMenu=false";
    }
    
    if( $closeLink ){
        $swfURL .= "&closeLink=true";
    }else{
        $swfURL .= "&closeLink=false";
    }

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en"> 
    <!-- 
    Smart developers always View Source. 
    
    This application was built using Adobe Flex, an open source framework
    for building rich Internet applications that get delivered via the
    Flash Player or to desktops via Adobe AIR. 
    
    Learn more about Flex at http://flex.org 
    // -->
    <head>
        <title>FuelSaverApp</title>
        <meta name="google" value="notranslate">         
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <!-- Include CSS to eliminate any default margins/padding and set the height of the html element and 
             the body element to 100%, because Firefox, or any Gecko based browser, interprets percentage as 
             the percentage of the height of its parent container, which has to be set explicitly.  Fix for
             Firefox 3.6 focus border issues.  Initially, don't display flashContent div so it won't show 
             if JavaScript disabled.
        -->
        <style type="text/css" media="screen"> 
            html, body  { height:100%; }
            body { margin:0; padding:0; overflow:auto; text-align:center; 
                   background-color: #ffffff; }   
            object:focus { outline:none; }
            #flashContent { display:none; }
        </style>
        
        <!-- Enable Browser History by replacing useBrowserHistory tokens with two hyphens -->
        <!-- BEGIN Browser History required section -->
        <link rel="stylesheet" type="text/css" href="<?=$baseUrl?>/fuelsaver/flash/history/history.css" />
        <script type="text/javascript" src="<?=$baseUrl?>/fuelsaver/flash/history/history.js"></script>
        <!-- END Browser History required section -->  

        <script type="text/javascript" src="<?=$baseUrl?>/fuelsaver/flash/swfobject.js"></script>
        <script type="text/javascript">
            // For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. 
            var swfVersionStr = "10.1.0";
            // To use express install, set to playerProductInstall.swf, otherwise the empty string.             
            var xiSwfUrlStr = "<?=$baseUrl?>/fuelsaver/flash/playerProductInstall.swf";
            var flashvars = { baseURL:"http://<?=$_SERVER['HTTP_HOST']?>", noMenu : <?=$noMenu ? 'true' : 'false' ?>};
            var params = {};
            params.quality = "high";
            params.bgcolor = "#ffffff";
            params.allowscriptaccess = "sameDomain";
            params.allowfullscreen = "true";
            var attributes = {};
            attributes.id = "FuelSaverApp";
            attributes.name = "FuelSaverApp";
            attributes.align = "middle";
            swfobject.embedSWF(
                "<?=$swfURL?>", "flashContent", 
                "520", "780", 
                swfVersionStr, xiSwfUrlStr, 
                flashvars, params, attributes);
            // JavaScript enabled so display the flashContent div in case it is not replaced with a swf object.
            swfobject.createCSS("#flashContent", "display:block;text-align:left;");

            function fbs_click() {
			    var u="http://www.morrisonsfuelsaver.co.uk";
			    var t="Try Morrisons new fuel savings calculator and see how much you could save on your next Morrisons fuel bill.";
			    window.open('http://www.facebook.com/sharer.php?&u='+encodeURIComponent(u)+'&t='+encodeURIComponent(t),'sharer','toolbar=0,status=0,width=626,height=436');
		    return false;}
            
        </script>
    </head>
    <body>
        <!-- SWFObject's dynamic embed method replaces this alternative HTML content with Flash content when enough 
             JavaScript and Flash plug-in support is available. The div is initially hidden so that it doesn't show
             when JavaScript is disabled.
        -->
        <div id="flashContent">
            <p>
                To view this page ensure that Adobe Flash Player version 
                10.1.0 or greater is installed. 
            </p>
            <script type="text/javascript"> 
                var pageHost = ((document.location.protocol == "https:") ? "https://" : "http://"); 
                document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
                                + pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" ); 
            </script> 
        </div>
        
        <noscript>
            <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="520" height="780" id="FuelSaverApp">
                <param name="movie" value="<?=$swfURL?>" />
                <param name="quality" value="high" />
                <param name="bgcolor" value="#ffffff" />
                <param name="allowScriptAccess" value="sameDomain" />
                <param name="allowFullScreen" value="true" />
                <!--[if !IE]>-->
                <object type="application/x-shockwave-flash" data="<?=$swfURL?>" width="520" height="780">
                    <param name="quality" value="high" />
                    <param name="bgcolor" value="#ffffff" />
                    <param name="allowScriptAccess" value="sameDomain" />
                    <param name="allowFullScreen" value="true" />
                <!--<![endif]-->
                <!--[if gte IE 6]>-->
                    <p> 
                        Either scripts and active content are not permitted to run or Adobe Flash Player version
                        10.1.0 or greater is not installed.
                    </p>
                <!--<![endif]-->
                    <a href="http://www.adobe.com/go/getflashplayer">
                        <img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash Player" />
                    </a>
                <!--[if !IE]>-->
                </object>
                <!--<![endif]-->
            </object>
        </noscript>     
   </body>
</html>