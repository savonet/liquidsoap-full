<?php

// Requires PEAR's File_XSPF!

class XSPFPlaylist extends File_XSPF implements XMLDocumentInterface
{
	const XMLNS = "http://xspf.org/ns/0/";
	
	public function getDOM()
	{
		return DOMDocument::loadXML($this->toString());
	}
}

class XSPFTrack extends File_XSPF_Track
{
	public function addLocation($l)
	{
		parent::addLocation(new File_XSPF_Location($l));
	}
}

?>