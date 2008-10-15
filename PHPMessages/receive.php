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
require('include/XHTMLFunctions.php');
require('include/mysql.php');
include('include/smsNets.php');
include('include/settings.php');
include_once('include/HTTPFunctions.php');
include('include/interfaces/interfaces.php');
checkSaneInstall();

###############
# Load the receiving interfaces
$iFaces=loadInterfaces();

################
# If we have no post
if(sizeof($_POST)==0){
	require('include/head.php');
	$headObj=new head(true,'Message system');
	echo $headObj->getXHTML();
	foreach($iFaces as $interface){
		$xhtml=$interface->getTestXHTML();
		if($xhtml)
			echo getRoundedCornersBox($xhtml);

	}
	exit();
}

################
# Handle POST
$received=false;
foreach($iFaces as $interface){
	if( ($ind=$interface->getPostIndicator()) && array_key_exists($ind,$_POST) ){
		$interface->handlePost($_POST);
		$received=true;
	}
}
if(!$received)
	dieWithCode(400);
?>
