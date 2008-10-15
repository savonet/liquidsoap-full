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
if(!isset($_SESSION))
	session_start();
class head{

	var $header;
	var $auth;

	function head($auth,$title,$bodyLoad=""){
		$this->auth=$auth;
		$this->title=$title;
		$this->bodyLoad=$bodyLoad;
		$this->header=$this->getXHTML($title);
		if($auth)
			$this->header.=$this->getJavascript();
		$this->header.=$this->getEnd();
	}

	function getHead(){
		return $this->header;
	}

	function getXHTML(){
		$xhtml= "<?xml version='1.0' encoding='iso-8859-1'?>\n<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Strict//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd'>\n<html xmlns='http://www.w3.org/1999/xhtml'>";
		$xhtml.="\n<head>\n\t<link rel='stylesheet' type='text/css' href='main.css'/>";
		$xhtml.=$this->getJavascript();
		$xhtml.="\n\t<title>".$this->title."</title>";	
		$xhtml.=$this->getEnd();
		return $xhtml;
	}

	function getJavascript(){
		return "\n<script type='text/javascript'>"
			."\n//<![CDATA["			
			
			."\nfunction ajaxSend(element,url,callback){"
			."\n"		
			."\n\tvar httpRequest;"
			."\n\tif (window.XMLHttpRequest) {"
			."\n\t\thttpRequest = new XMLHttpRequest();"					
			."\n\t}else if (window.ActiveXObject) {"
			."\n\t\ttry{"
			."\n\t\t\thttpRequest = new ActiveXObject(\"Msxml2.XMLHTTP\");"
			."\n\t\t}catch (e) {"
			."\n\t\t\ttry {"
			."\n\t\t\t\thttpRequest = new ActiveXObject(\"Microsoft.XMLHTTP\");"
			."\n\t\t\t} catch (e) {}"
			."\n\t\t}"
			."\n\t}"
			."\n\tif (!httpRequest) {"
			."\n\t\talert('Giving up :( Cannot create an XMLHTTP instance');"
			."\n\t\treturn false;"
			."\n\t}"
			."\n\thttpRequest.onreadystatechange = function(){"
			."\n\t\tvar myElement = element;"
			."\n\t\tvar myCallback=callback;"					
			."\n\t\tif(httpRequest.readyState == 4){"
			."\n\t\t\tmyCallback(myElement,httpRequest.responseXML);"	
			."\n\t\t}"
			."\n\t}"			
			."\n\t\thttpRequest.open(\"GET\", url + \"?dummy=\"+Math.random(), true);"
			."\n\t\thttpRequest.send(null);"			
			."\n}"

			."\nfunction updateMessages(element,response){"	
			."\n\tvar root_node = response.getElementsByTagName('messages').item(0);"
			."\n\tmessages=root_node.getElementsByTagName('message');"
			."\n\ttableContent='<tr>'"
				."\n\t\t+'<th></th>'"
				."\n\t\t+'<th>Date</th>'"
				."\n\t\t+'<th>Name</th>'"
				."\n\t\t+'<th>Unique Id</th>'"
				."\n\t\t+'<th>Message</th>'"
				."\n\t\t+'</tr>'"
				."\n\t\t;"
			."\n\tfor( i=0;i<messages.length;i++){"	
			."\n\t\t\trowNum=i%2;"			
			."\n\t\ttableContent+='<tr class=\"row'+rowNum+'\">'"
		
			."\n\t\t+'<td><img src=\"gfx/'+messages[i].getElementsByTagName('icon').item(0).firstChild.data+'30.png\" alt=\"type\"/></td>'"
			."\n\t\t+'<td>'+messages[i].getElementsByTagName('date').item(0).firstChild.data+'</td>'"
			."\n\t\t+'<td>'+messages[i].getElementsByTagName('name').item(0).firstChild.data+'</td>'"
			."\n\t\t+'<td>'+messages[i].getElementsByTagName('uniqId').item(0).firstChild.data+'</td>'"
			."\n\t\t+'<td>'+messages[i].getElementsByTagName('content').item(0).firstChild.data+'</td>'"
			."\n\t\t\t+'</tr>'"
			."\n\t}"
			."\n\tdocument.getElementById('msgList').innerHTML=tableContent;"
			."\n\tsetTimeout(\"startMsgTimer()\", 4000);"
			."\n}"

			."\nfunction startMsgTimer(){"	
			."\n\tajaxSend('msgList','messages.xml',updateMessages)"
			."\n\t"
			."\n\t"
			."\n}"

			."\n//]]>"
			."\n</script>";
	}
	
	function getEnd(){
	
		return "\n</head>\n<body onLoad='".$this->bodyLoad."'>";
	}
}








?>
