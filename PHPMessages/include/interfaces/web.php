<?php
include_once('interfaces.php');
require_once('include/mysql.php');

class interface_web extends receive_interface{
	var $postIndicator="sendWeb";

	function interface_web(){}

	function getTestXHTML(){
		return "\n<form action='#' method='post' id='msg'>"
			."\n<h1>Test WEB message</h1>"
			."\n\t<ul>"
			."<li><span>Name:</span><input type='text' name='from'/></li>"
			."<li><span>Message:</span><textarea name='message' cols='40' rows='10'></textarea></li>"
			."<li><span>&nbsp;</span><input type='submit' value='Send message' class='submit' name='sendWeb'/></li>"
			."\n</ul>"
			."\n</form>";
	}

	function handlePOST($post){
		include('include/settings.php');
		#############
		# Validation
		if( !isset($post['from']) || !isset($post['message']))
			dieWithCode('400');
		$from=rmInvalidChars($post['from']); $message=rmInvalidChars($post['message']);
		if( strlen($from)==0 || strlen($message)==0 )
		  	dieWithCode('400');
		if(!isset($_SERVER['REMOTE_ADDR']))
			dieWithCode('406');
		 if(!isset($curlIPs))
                        $curlIPs=array();
        	#############
        	# User check
        	$db=new mysql_db();
        	if( in_array(($ip=$_SERVER['REMOTE_ADDR']),$curlIPs) && isset($post['ip']))
                	$ip=$post['ip'];
        	$userReq=$db->selectQuery(array('text_users as a','text_webUsers as b'),"WHERE a.name='$from' AND b.ip=INET_ATON('$ip')",'b.user');
       		if($db->get_num_rows($userReq)==0){
			$db->insertQuery('text_users',array('name'=>$from));
			$user=$db->get_last_insert_id();
                	$db->insertQuery('text_webUsers',array('ip'=>"INET_ATON('$ip')",'user'=>$user));
                	
        	}else{
                	$row=$db->fetch_row($userReq);
                	$user=(int)$row['user'];
        	}

		#############
		# Insert message
		$db->insertQuery('text_messages',array('user'=>$user,'message'=>$message));	
		echo "OK";
	}

	function getXml($user){
		$db=new mysql_db();
		$row=$db->fetch_row($db->selectQuery('text_webUsers',"WHERE user=$user",'INET_NTOA(ip) as ip'));
		$ipParts=split("\.",$row['ip']);
		$ip=$ipParts[0].'.x.x.'.$ipParts[3];
		$db->close();
		return 	"<uniqId>$ip</uniqId>"
			."<icon>web</icon>";
	}
}
