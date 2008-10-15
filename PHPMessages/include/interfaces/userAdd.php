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
include_once('interfaces.php');
require_once('include/mysql.php');

class interface_userAdd extends receive_interface{
	var $postIndicator="sendWeb";

	function getTestXHTML(){
		return false;
	}

	function handlePOST($post){
	}

	function getXml($user){
		$db=new mysql_db();
		$row=$db->fetch_row($db->selectQuery('text_itaggUsers',"WHERE user=$user",'source'));
		$fullPhone=$row['source'];
		$phone="";
		for($i=0;$i<strlen($fullPhone);$i++){
			if($i>strlen($fullPhone)-4)
				$phone.=$fullPhone[$i];
			else
				$phone.="x";
			
		}
		$db->close();
		return 	"<uniqId>$phone</uniqId>"
			."<icon>userAdd</icon>";
	}
}
