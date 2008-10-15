<?php
function getRoundedCornersBox($content){
	// XHTML Function, put content into a nice rounded corners box
	return	"\n<div class='xsnazzy'>"
		."\n\t<b class='xb1'></b><b class='xb2'></b><b class='xb3'></b>"
		."\n\t<b class='xb4'></b><b class='xb5'></b><b class='xb6'></b><b class='xb7'></b>"
		."\n\t<div class='xboxcontent'>"
		."\n\t\t$content"
		."\n\t</div>"
		."\n\t<b class='xb7'></b><b class='xb6'></b><b class='xb5'></b>"
		."\n\t<b class='xb4'></b><b class='xb3'></b><b class='xb2'></b><b class='xb1'></b>"
		."\n</div>";
}
function rmInvalidChars($string){
	$string=preg_replace("[^A-Za-z0-9\ \n]", "", $string);
        $string=str_replace("\'","",$string);
        $string=str_replace('\"',"",$string);
        $string=str_replace("\\","",$string);
	$replace = array('<' => '' , '>' => '' , '&' => '' , ',' => '' , '*' => '' , '/' => '' );
        $string = strtr($string , $replace);
        return $string;
}

?>
