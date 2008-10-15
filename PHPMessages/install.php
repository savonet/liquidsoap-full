<?php
require('include/mysql.php');
$syntax=array(
	"text_users"=>array(
		'id'=>		array('type'=>'INT','primary'=>true,'notNull'=>true),
		'created'=>	array('type'=>'TIMESTAMP','notNull'=>true,'default'=>'NOW()'),
		'name'=> 	array('type'=>'VARCHAR(255)','default'=>'')
	),
	"text_itaggUsers"=>array(
		'user'=>	array('type'=>'INT','notNull'=>true),
		'source'=>	array('type'=>'VARCHAR(14)','notNull'=>true)		
	),
	"text_webUsers"=>array(
		'user'=>	array('type'=>'INT','notNull'=>true),
		'ip'=>		array('type'=>'INT UNSIGNED','notNull'=>true,'unique'=>true)
	),
	"text_messages"=>array(
		'id'=>		array('type'=>'INT','primary'=>true,'notNull'=>true),
		'user'=>	array('type'=>'INT','notNull'=>true),
		'type'=>	array('type'=>'VARCHAR(255)','default'=>"'web'"),
		'received'=>	array('type'=>'TIMESTAMP','notNull'=>true,'default'=>'NOW()'),
		'message'=>	array('type'=>'VARCHAR(255)','notNull'=>true)
	),
	"text_itaggMessages"=>array(
		'message'=>	array('type'=>'INT'),
		'network'=>	array('type'=>'INT(2)'),
		'smsId'=>	array('type'=>'INT'),
		'shortCode'=>	array('type'=>'VARCHAR(6)')	
	)
	
	);
	$foreignKeys=array(
		'text_itaggUsers'=>array(
			array('key'=>'user','refTable'=>'text_users','refField'=>'id')
		),		
		'text_webUsers'=>array(
			array('key'=>'user','refTable'=>'text_users','refField'=>'id')
		),
		'text_messages'=>array(
			array('key'=>'user','refTable'=>'text_users','refField'=>'id')
		),
		'text_itaggMessages'=>array(
			array('key'=>'message','refTable'=>'text_messages','refField'=>'id')
		)
		
	);

	createTables($syntax,$foreignKeys);


?>
