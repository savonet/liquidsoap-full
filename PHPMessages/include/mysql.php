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
include_once('include/HTTPFunctions.php');
class mysql_db{

	function mysql_db(){
		include('settings.php');

		if(!isset($mysql_username) || !isset($mysql_db)) dieWithCode(500,'Database connection error');
		if(!isset($mysql_password))
			$mysql_password="";
		if(!isset($mysql_host))
			$mysql_host='localhost';

		if(!isset($mysql_port))
			$mysql_port=3307;
		if(!isset($mysql_tablePrefix))
			$mysql_tablePrefix="";	
		$this->tablePrefix=$mysql_tablePrefix;
		$this->sql_connect("$mysql_host:$mysql_port",$mysql_username,$mysql_password,$mysql_db);
	}

        //+======================================================+
        function sql_connect($sqlserver, $sqluser, $sqlpassword,$database){
            $this->connect_id = mysql_connect($sqlserver, $sqluser, $sqlpassword);
            if($this->connect_id){
                if (mysql_select_db($database)){
                    return $this->connect_id;
                }else{
                    return $this->error();
                }
            }else{
                return $this->error();
            }
        }
        //+======================================================+
        function error($query=""){
	
            if(mysql_error() != ''){
		$string='<b>MySQL Error</b>: '.mysql_error().'<br/>';
		if(strlen($query)!=0)
			$string.="Running $query<br/>";
               die( $string );
		dieWithCode(500,'Database error');
	
            }
        }
        //+======================================================+
        function query($query){
		
            if ($query != NULL){
		if(get_resource_type(($this->connect_id))!='mysql link'){
			$this->error($query);
			return;		
		}	
                $this->query_result = mysql_query($query, $this->connect_id);
                if(!$this->query_result){
                    return $this->error($query);
                }else{
                    return $this->query_result;
                }
            }else{
                return '<b>MySQL Error</b>: Empty Query!';
            }
        }
        //+======================================================+
        function get_num_rows($query_id = ""){
		
            if($query_id == NULL){
                $return = mysql_num_rows($this->query_result);
            }else{
                $return = mysql_num_rows($query_id);
            }
            if(!$return){
                $this->error();
            }else{
                return $return;
            }
        }
        //+======================================================+
        function fetch_row($query_id = ""){
            if($query_id == NULL){
                $return = mysql_fetch_array($this->query_result);
            }else{
                $return = mysql_fetch_array($query_id);
            }
            if(!$return){
                $this->error();
            }else{
                return $return;
            }
        }   
        //+======================================================+
        function get_affected_rows($query_id = ""){
            if($query_id == NULL){
                $return = mysql_affected_rows($this->query_result);
            }else{
                $return = mysql_affected_rows($query_id);
            }
            if(!$return){
                $this->error();
            }else{
                return $return;
            }
        }
        //+======================================================+
        function close(){
            if($this->connect_id){
                return mysql_close($this->connect_id);
            }
        }
        //+======================================================+   
	function table_exists($table){
	    $return=$this->query("SHOW TABLES like'".$this->getPrefix()."$table'");
	    $return=$this->get_num_rows();
            if(!$return){
                $this->error();
            }else{
                return $return;
            }
	}
 	//+======================================================+   
	function get_last_insert_id(){
		$return=mysql_insert_id();
	    if(!$return)
                $this->error();
            else
                return $return;
            

	}
	function getPrefix(){
		if(!isset($this->tablePrefix) || strlen($this->tablePrefix)==0)
			return "";
		else
			return $this->tablePrefix."_";
	}

	function createQuery($table,$fields){
		$sql="CREATE TABLE ".$this->getPrefix()."$table(";
		$sqlFields="";

		foreach($fields as $name=>$field){
			if(strlen($sqlFields)!=0)
				$sqlFields.=",";
			$sqlFields.=$name." ".$field['type'];
			if(isset($field['primary'])&&$field['primary'])
				$sqlFields.=" PRIMARY KEY AUTO_INCREMENT";
			if(isset($field['notNull'])&&$field['notNull'])
				$sqlFields.=" NOT NULL";
			if(isset($field['default'])&&strlen($field['default'])!=0)
				$sqlFields.=" DEFAULT ".$field['default'];
		}
		$sql.=$sqlFields.");";
		return $this->query($sql);
	}

	function createQueryArchive($table,$fields){
		$sql="CREATE TABLE ".$this->getPrefix().$table."_archive(";
		$sqlFields="archId INT PRIMARY KEY AUTO_INCREMENT";
	
	
		foreach($fields as $name=>$field){
			if(strlen($sqlFields)!=0)
				$sqlFields.=",";
			$sqlFields.=$name." ".$field['type'];
		}
		$sql.=$sqlFields.");";
		return $this->query($sql);

	}

	function addForeignKeys($table,$keys){
		$sql=array();
		if(!is_array($keys))
			return false;
		
		
		if(isset($keys['key']) && isset($keys['refTable']) && isset($keys['refField']))
			array_push($sql,"ALTER TABLE ".$this->getPrefix()."$table ADD CONSTRAINT FOREIGN KEY (".$keys['key'].") REFERENCES ".$keys['refTable']."(".$keys['refField'].") ON DELETE CASCADE");
		else{
			foreach($keys as $key)
			array_push($sql,"ALTER TABLE ".$this->getPrefix()."$table ADD CONSTRAINT FOREIGN KEY (".$key['key'].") REFERENCES ".$key['refTable']."(".$key['refField'].") ON DELETE CASCADE");
		}

		foreach($sql as $item){	
			$this->query($item);			
		}
		
	}
	
	function dropQuery($table){
		return $this->query("DROP TABLE ".$this->getPrefix()."$table");
	}

	function selectQuery($table,$sql,$fields="*"){
		$tables="";
		if(is_array($table)){
			foreach($table as $tab){
				if(strlen($tables)!=0)
					$tables.=",";
				if(is_string($tab))
					$tables.= $this->getPrefix().$tab;
				if(is_array($tab))
					$tables.=$this->getPrefix().$tab['table']." as ".$tab['as'];
			}
		}
		if(is_string($table))
			$tables.=$this->getPrefix().$table;
		
		return $this->query("SELECT $fields FROM $tables $sql;");
	}
	function insertQuery($table,$fields,$extra=""){
		
		if(isset($recordId))
			$fields['record']=$recordId;
		$sql="INSERT INTO ".$this->getPrefix().$table;

		$cols="";$vals="";		
		foreach($fields as $key=>$value){
			if(strlen($cols)!=0){ $cols.=",";$vals.=","; }
		
			if(sizeof(explode("'",$value))==1)
				$value="'$value'";
			$cols.=$key;
			$vals.=$value;
		}
		$sql.=" ($cols) VALUES ($vals);";
		$this->query($sql);
	}
	
	function updateQuery($table,$sql){
		return $this->query("UPDATE ".$this->getPrefix()."$table $sql;");
	}
	
    }

	function createTables($syntax,$foreignKeys=array()){
		$link = new mysql_db();
		$syntaxRev = array_reverse($syntax);
		foreach($syntaxRev as $key=>$item){
			if( $link->table_exists($key))
				$link->dropQuery($key);
		}
		
		foreach($syntax as $key=>$item){			
			$link->createQuery($key,$item);
		}
		foreach($foreignKeys as $key=>$item){
			$link->addForeignKeys($key,$item);

		}
		$link->close();

	}
	function checkInstalled(){
		$db=new mysql_db();
		$showQ=$db->query("SHOW TABLES");
		if(!$db->get_num_rows($showQ)>0)
			dieWithCode('500','Please run the installer.');
		return true;
	}
	
	function checkSaneInstall(){
		if(checkInstalled() && file_exists('install.php'))
			dieWithCode('500','Please remove install.php');
		else
			return true;
	}


?>
