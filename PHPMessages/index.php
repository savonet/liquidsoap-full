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
include('include/XMLFunctions.php');
require('include/mysql.php');
include('include/settings.php');
require('include/head.php');
checkSaneInstall();
$headObj=new head(true,'Message system',"startMsgTimer()");
//
#############
# Static content
if(isset($content_slogan))
	$content_slogan="<h2 id='msgs'><img src='gfx/speech30.png' alt='Speech bubble'/>$content_slogan</h2>";
else
	$content_slogan="";

if(strlen($content_techBull)>0)
	$content_techBull=getRoundedCornersBox("\n\t\t\t<h2><img src='gfx/info.png' alt='Info'/>Technical Bulletin</h2>$content_techBull");
else
	$content_techBull="";


echo 	$headObj->getXHTML()
	."<h1 id='msgs'>Messages</h1>"
	."\n".$content_slogan	
	."\n\t<ul id='msgs'>"
	."\n\t\t<li>"
	 .$content_techBull
	."\n\t\t</li></ul>";

	$xml=new SimpleXMLElement(getMessages());
	echo getMessagesXHTML($xml);

function getMessagesXHTML($xml){
	if(sizeof($xml)==0){
		return;
	}
	$code=	"\n<table id='msgList'>"
		."\n\t<tr>"
		."\n\t\t<th></th>"
		."\n\t\t<th>Date</th>"
		."\n\t\t<th>Name</th>"
		."\n\t\t<th>Unique Id</th>"
		."\n\t\t<th>Message</th>"
	;
	$i=0;
	foreach($xml as $message){
		$code.="\n\t<tr class='row".($i%2)."'>"
	
		."\n\t\t\t<td><img src='gfx/".$message->icon."30.png'/></td>"
		."\n\t\t\t<td>".$message->date."</td>"
		."\n\t\t\t<td>".$message->name."</td>"
		."\n\t\t\t<td>".$message->uniqId."</td>"
		."\n\t\t\t<td>".$message->content."</td>"

		."\n</tr>";
		$i++;
	}
	$code.="\n\r</table>";
	return $code;
}
?>
