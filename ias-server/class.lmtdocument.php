<?php

class LiqMessageTypeDocument extends XMLDocument
{
	const XMLNS = "http://savonet.sf.net/ns/message-type";
	
	protected $content_type;
	protected $role;
	protected $hostname;
	
	public function setContentType($c)
	{
		$this->content_type = $c;
	}
	
	public function getContentType()
	{
		return $this->content_type;
	}
	
	public function setRole($r)
	{
		$this->role = $r;
	}
	
	public function getRole()
	{
		return $this->role;
	}
	
	public function setHostname($h)
	{
		$this->hostname = $h;
	}
	
	public function getHostname()
	{
		return $this->hostname;
	}
	
	public function build()
	{
		$lmt_header = $this->dom->createElementNS(LiqMessageTypeDocument::XMLNS, "liq:Header");
		$this->dom->appendChild($lmt_header);
		$message_type = $this->dom->createElementNS(LiqMessageTypeDocument::XMLNS,
			"liq:message-type");
		$lmt_header->appendChild($message_type);
		$ct = $this->dom->createElementNS(LiqMessageTypeDocument::XMLNS, "liq:content-type",
		 	$this->content_type);
		$message_type->appendChild($ct);
		$role = $this->dom->createElementNS(LiqMessageTypeDocument::XMLNS, "liq:role",
			$this->role);
		$message_type->appendChild($role);
		$dt = $this->dom->createElementNS(LiqMessageTypeDocument::XMLNS, "liq:dateTime",
			date('c'));
		$lmt_header->appendChild($dt);
		$sender = $this->dom->createElementNS(LiqMessageTypeDocument::XMLNS, "liq:sender");
		$lmt_header->appendChild($sender);
		$server = $this->dom->createElementNS(LiqMessageTypeDocument::XMLNS, "liq:server",
			$this->hostname);
		$sender->appendChild($server);
	}
}

?>