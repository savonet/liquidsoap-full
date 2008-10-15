<?php
class receive_interface{
	function getPostIndicator(){
		if(isset($this->postIndicator))
			return $this->postIndicator;
		return false;
	}

	function getTestXHTML(){
		dieWithCode('500','Incomplete interface');
	}

	function handlePOST(){
		dieWithCode('500','Incomplete interface');
	}
}

function loadInterfaces(){
	###############
	# Load the receiving interfaces
	$iFaces=array();
	foreach($interfaces as $interface){
		if(!file_exists("$interface.php"))
			dieWithCode('500',"Missing interface $interface");
		include("include/interfaces/$interface.php");
		$objName="interface_$interface";
		$iFaces[$interface]=new $objName();
	}
	return $iFaces;

}
