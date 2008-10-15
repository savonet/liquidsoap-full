<?php

class SOAPDocument extends XMLDocument
{
	const XMLNS = "http://www.w3.org/2003/05/soap-envelope";
	
	protected $header;
	protected $body;
	
	public function setHeader(XMLDocumentInterface $h)
	{
		$h = $h->getDOM();
		$h->documentElement->setAttributeNS(SOAPDocument::XMLNS, "env:role",
			"http://www.w3.org/2003/05/soap-envelope/role/next");
		$h->documentElement->setAttributeNS(SOAPDocument::XMLNS, "env:mustUnderstand",
			"true");
		
		$this->header = $this->dom->importNode($h->documentElement, true);
	}
	
	public function getHeader()
	{
		return $this->header;
	}
	
	public function setBody(XMLDocumentInterface $b)
	{
		$this->body = $this->dom->importNode($b->getDOM()->documentElement, true);
	}
	
	public function getBody()
	{
		return $this->body;
	}
	
	public function build()
	{
		$root = $this->dom->createElementNS(SOAPDocument::XMLNS, "env:Envelope");
		$this->dom->appendChild($root);
		if ($this->header)
		{
			$header = $this->dom->createElementNS(SOAPDocument::XMLNS, "env:Header");
			$root->appendChild($header);
			$header->appendChild($this->header);
		}
		if ($this->body)
		{
			$body = $this->dom->createElementNS(SOAPDocument::XMLNS, "env:Body");
			$root->appendChild($body);
			$body->appendChild($this->body);
		}
	}
}

class SOAPError extends XMLDocument
{
	const XMLNS = "http://www.w3.org/2003/05/soap-envelope";
	const XML_XMLNS = "http://www.w3.org/XML/1998/namespace";
	const E_VERSION = "VersionMismatch";
	const E_MUSTUNDERSTAND = "MustUnderstand";
	const E_ENCODING = "DataEncodingUnknown";
	const E_SENDER = "Sender";
	const E_RECEIVER = "Receiver";
		
	protected $code;
	protected $reason;
	protected $lang;
	
	public function __construct($code, $reason, $lang="en")
	{
		$this->code = $code;
		$this->reason = $reason;
		$this->lang = $lang;
		
		parent::__construct();
	}
	
	public function build()
	{
		$root = $this->dom->createElementNS(SOAPError::XMLNS,
		                                    "env:Fault");
		$this->dom->appendChild($root);
		$code = $this->dom->createElementNS(SOAPError::XMLNS,
		                                    "env:Code");
		$root->appendChild($code);
		$code->appendChild(
			$this->dom->createElementNS(SOAPError::XMLNS,
			                            "env:Value",
			                            $this->code));
		$reason = $this->dom->createElementNS(SOAPError::XMLNS,
		                                      "env:Reason");
		$root->appendChild($reason);
		$text = $this->dom->createElementNS(SOAPError::XMLNS,
		                                    "env:Text",
		                                    $this->reason);
		$text->setAttributeNS(SOAPError::XML_XMLNS, "xml:lang", $this->lang);
		$reason->appendChild($text);
	}
}

?>