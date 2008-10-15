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
function getMessages(){

require_once('include/mysql.php');
include('include/settings.php');
include('include/interfaces/interfaces.php');
$db=new mysql_db();
$results=$db->query("SELECT a.id,a.user,a.type,a.received,a.message,b.name as name FROM text_messages AS a , text_users as b WHERE a.user=b.id  ORDER BY received DESC LIMIT 30;");

$xml="<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\r\n"
	."\n<messages>";
$iFaces=loadInterfaces();
while( ($row=$db->fetch_row($results) )){
	
	if(!isset($row['name']) || strlen($name=$row['name'])==0 )
			$name="Unknown";
	$interface=$iFaces[$row['type']];
	$xml.="\n\t<message>"
		.$interface->getXml($row['user'])
		."\n\t\t<date>".$row['received']."</date>"
		."\n\t\t<name>$name</name>"
		."\n\t\t<content>".$row['message']."</content>"
		."\n\t</message>";
}
	
$xml.="\n</messages>";

return $xml;
}
?>
