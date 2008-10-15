<?php
function dieWithCode($code,$error=""){
	$codes=array(400=>"Bad Request",406=>"Not Acceptable",500=>"Internal Server Error");
	if(!array_key_exists($code,$codes))
		$code=500;
	if(strlen($error)>0)
		$error=" - ".$error;
	header("HTTP/1.0 $code ".$codes[$code].$error); 
	die("HTTP/1.0 $code ".$codes[$code].$error);
}

?>
