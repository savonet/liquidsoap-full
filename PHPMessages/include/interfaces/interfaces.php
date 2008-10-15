<?php
#*****************************************************************************
#
#  Liquidsoap, a programmable audio stream generator.
#  Copyright 2003-2007 Savonet team
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details, fully stated in the COPYING
#  file at the root of the liquidsoap distribution.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
#*****************************************************************************
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

	function isType($user){
		dieWithCode('500','Incomplete interface');
	}
}

function loadInterfaces(){
	include('include/settings.php');
	###############
	# Load the receiving interfaces
	$iFaces=array();
	foreach($interfaces as $interface){
		if($interface=="itagg")
			$iFaces['userAdd']=loadInterface('userAdd');
		$iFaces[$interface]=loadInterface($interface);
	}
	return $iFaces;

}

function loadInterface($interface){
	if(!file_exists("include/interfaces/$interface.php"))
			dieWithCode('500',"Missing interface $interface");
	include("include/interfaces/$interface.php");
	$objName="interface_$interface";
	$iFace=new $objName();
	return $iFace; 
}
