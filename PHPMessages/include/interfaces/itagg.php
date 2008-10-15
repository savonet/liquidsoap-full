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

class interface_itagg extends receive_interface{
	var $postIndicator="source";

	function interface_itagg(){}

	function getTestXHTML(){
		return "\n<form action='#' method='post' id='msg'>"
		."\n<h1>Test SMS message</h1>"
		."\n\t<ul>"
		."\n\t\t<li><span>Source:</span><input type='text' name='source'/></li>"
		."\n\t\t<li><span>Message:</span><textarea name='message' cols='40' rows='10'></textarea></li>"
		."\n\t\t<li><span>Network:</span>"
		."\n\t\t\t<select name='network'>"
		."\n\t\t\t\t<option value='".SMSNET_O2."'>O2</option>"
		."\n\t\t\t\t<option value='".SMSNET_VODA."'>VODAFONE</option>"
		."\n\t\t\t\t<option value='".SMSNET_3."'>3</option>"
		."\n\t\t\t\t<option value='".SMSNET_TMOB."'>TMOBILE</option>"
		."\n\t\t\t\t<option value='".SMSNET_OTHER."'>OTHER</option>"
		."\n\t\t\t</select>"
		."\n\t\t</li>"
		."\n\t\t<li><span>&nbsp;</span><input type='submit' value='Send message' class='submit' name='sendSMS'/></li>"
		."\n\t</ul>"
		."\n</form>";
	}

	function handlePOST($post){
		#############
		# Validation
		if( !isset($post['message']) || !isset($post['network']))
			dieWithCode('400');
		$network=$post['network'];
		$source=preg_replace("[^0-9]", "", $_POST['source']); 
		$message=rmInvalidChars($post['message']);
		if( strlen($source)==0 || strlen($message)==0 || strlen($network)==0 )
			  dieWithCode('400');
		if(!isset($post['message_id']))
			$messageId=0;
		else
			$messageId=$post['message_id'];
		if(!isset($post['shortCode']))
			$shortCode="";
		else
			$shortCode=$post['shortCode'];
		#############
		# User check
		$db=new mysql_db();
		$userReq=$db->selectQuery('text_users as a, text_itaggUsers as b',"WHERE b.source=$source AND b.user=a.id",'a.id as user');
		if($db->get_num_rows($userReq)==0){
			$db->insertQuery('text_users',array('name'=>''));
			$user=$db->get_last_insert_id();
			$db->insertQuery('text_itaggUsers',array('source'=>$source,'user'=>$user));
		}else{
			$row=$db->fetch_row($userReq);
			$user=(int)$row['user'];
		}
		#############
		# Insert message

		if(strnatcasecmp(substr($message,0,4),"kube")==0)
		        $message=trim(substr($message,4,strlen($message)));
	
		if(strnatcasecmp(substr($message,0,8),"register")==0){
	
		        $message=trim(substr($message,8,strlen($message)));
		
			$db->updateQuery('text_users',"SET name='".$message."' WHERE id=$user");
			$db->insertQuery('text_messages',array('user'=>$user,'type'=>'userAdd','message'=>"Has registered their name!"));
		}else
			$db->insertQuery('text_messages',array('user'=>$user,'type'=>'itagg','message'=>$message));	
			$message=$db->get_last_insert_id();

			$db->insertQuery('text_itaggMessages',array('message'=>$message,'network'=>$network,'smsId'=>$messageId,'shortCode'=>$shortCode));
		echo "OK";	
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
		return "<icon>phone</icon>"
			."\n<uniqId>$phone</uniqId>";
	}		
}
