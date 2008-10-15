<?php

interface XMLDocumentInterface
{
	public function getDOM();
}

abstract class XMLDocument implements XMLDocumentInterface
{
	protected $dom;
	
	public function __construct()
	{
		$this->dom = new DOMDocument("1.0", "UTF-8");
		$this->dom->preserveWhiteSpace = true;
		$this->dom->formatOutput = true;
	}
	
	abstract public function build();
	
	public function getDOM()
	{
		return $this->dom;
	}
}

?>