<?php

class RCSSong extends XMLDocument
{
	const XMLNS = "urn:SongSchema";
	
	protected $title;
	protected $guid;
	protected $internalID;
	protected $category;
	protected $opening;
	protected $ending;
	protected $artists = array();
	protected $media;
	
	public function __construct($guid, $title)
	{
		$this->guid = $guid;
		$this->title = $title;
		
		parent::__construct();
	}
	
	public function getTitle()
	{
		return $this->title;
	}
	
	public function setTitle($t)
	{
		$this->title = $t;
	}
	
	public function getGUID()
	{
		return $this->guid;
	}
	
	public function setGUID($g)
	{
		$this->guid = $g;
	}
	
	public function getInternalID()
	{
		return $this->internal_id;
	}
	
	public function setInternalID($id)
	{
		$this->internal_id = $id;
	}
	
	public function getCategory()
	{
		return $this->category;
	}
	
	public function setCategory($c)
	{
		$this->category = $c;
	}
	
	public function getOpening()
	{
		return $this->opening;
	}
	
	public function setOpening($o)
	{
		$this->opening = $o;
	}
	
	public function getEnding()
	{
		return $this->ending;
	}
	
	public function setEnding($e)
	{
		$this->ending = $e;
	}
	
	public function addArtist(RCSArtist $a)
	{
		$this->artists[] = $this->dom->importNode($a->getDOM()->documentElement, true);
	}
	
	public function getArtists()
	{
		return $this->artists;
	}
	
	public function setMedia(RCSMedia $m)
	{
		$this->media = $this->dom->importNode($m->getDOM()->documentElement, true);
	}
	
	public function getMedia()
	{
		return $this->media;
	}
	
	public function build()
	{
		$root = $this->dom->createElementNS(RCSSong::XMLNS, "s:Song");
		$this->dom->appendChild($root);
		if ($this->title)
		{
			$root->appendChild(
				$this->dom->createElementNS(RCSSong::XMLNS,
				                            "s:title", $this->title));
		}
		if ($this->guid)
		{
			$root->appendChild(
				$this->dom->createElementNS(RCSSong::XMLNS,
				                            "s:GUID", $this->guid));
		}
		if ($this->internal_id)
		{
			$root->appendChild(
				$this->dom->createElementNS(RCSSong::XMLNS,
				                            "s:internalID", $this->internal_id));
		}
		if ($this->category)
		{
			$root->appendChild(
				$this->dom->createElementNS(RCSSong::XMLNS,
				                            "s:category", $this->category));
		}
		if ($this->opening)
		{
			$root->appendChild(
				$this->dom->createElementNS(RCSSong::XMLNS,
				                            "s:opening", $this->opening));
		}
		if ($this->ending)
		{
			$root->appendChild(
				$this->dom->createElementNS(RCSSong::XMLNS,
				                            "s:ending", $this->ending));
		}
		foreach ($this->artists as $a)
		{
			$root->appendChild($a);
		}
		if ($this->media)
		{
			$root->appendChild($this->media);
		}
	}
}

class RCSArtist extends XMLDocument
{
	const XMLNS = "urn:SongSchema";
	
	protected $name;
	protected $guid;
	protected $internal_id;
	protected $sequence_number;
	
	public function __construct($guid, $name)
	{
		$this->guid = $guid;
		$this->name = $name;
		
		parent::__construct();
	}
	
	public function getName()
	{
		return $this->name;
	}
	
	public function setName($n)
	{
		$this->name = $n;
	}
	
	public function getGUID()
	{
		return $this->guid;
	}
	
	public function setGUID($g)
	{
		$this->guid = $g;
	}
	
	public function getInternalID()
	{
		return $this->internal_id;
	}
	
	public function setInternalID($id)
	{
		$this->internal_id = $id;
	}
	
	public function getSequenceNumber()
	{
		return $this->sequence_number;
	}
	
	public function setSequenceNumber($sn)
	{
		$this->sequence_number = $sn;
	}
	
	public function build()
	{
		$root = $this->dom->createElementNS(RCSArtist::XMLNS, "s:Artist");
		$this->dom->appendChild($root);
		if ($this->name)
		{
			$root->appendChild(
				$this->dom->createElementNS(RCSArtist::XMLNS,
				                            "s:name", $this->name));
		}
		if ($this->guid)
		{
			$root->appendChild(
				$this->dom->createElementNS(RCSArtist::XMLNS,
				                            "s:GUID", $this->guid));
		}
		if ($this->internal_id)
		{
			$root->appendChild(
				$this->dom->createElementNS(RCSArtist::XMLNS,
				                            "s:internalID", $this->internal_id));
		}
		if ($this->sequence_number)
		{
			$root->appendChild(
				$this->dom->createElementNS(RCSArtist::XMLNS,
				                            "s:sequenceNumber", $this->sequence_number));
		}
	}
}

class RCSMedia extends XMLDocument
{
	const XMLNS = "urn:PEContentSchema";
	
	protected $media_format;
	protected $time_points = array();
	
	public function getMediaFormat()
	{
		return $this->media_format;
	}
	
	public function setMediaFormat(RCSMediaFormat $m)
	{
		$this->media_format = $this->dom->importNode($m->getDOM()->documentElement, true);
	}
	
	public function addTimePoint(RCSTimePoint $tp)
	{
		$this->time_points[] =
		  $this->dom->importNode($tp->getDOM()->documentElement, true);
	}
	
	public function getTimePoints()
	{
		return $this->time_points;
	}
	
	public function build()
	{
		$root = $this->dom->createElementNS(RCSMedia::XMLNS,
		                                    "pe:Media");
		$this->dom->appendChild($root);
		if ($this->media_format)
		{
			$root->appendChild($this->media_format);
		}
		foreach ($this->time_points as $tp)
		{
			$root->appendChild($tp);
		}
	}
}

class RCSMediaFormat extends XMLDocument
{
	const XMLNS = "urn:PEContentSchema";
	
	protected $encoding;
	protected $packaging;
	protected $num_channels;
	protected $samplerate;
	
	public function getEncoding()
	{
		return $this->encoding;
	}
	
	public function setEncoding($f)
	{
		$this->encoding = $f;
	}
	
	public function getPackaging()
	{
		return $this->packaging;
	}
	
	public function setPackaging($p)
	{
		$this->packaging = $p;
	}
	
	public function getNumChannels()
	{
		return $this->num_channels;
	}
	
	public function setNumChannels($n)
	{
		$this->num_channels = $n;
	}
	
	public function getSamplerate()
	{
		return $this->samplerate;
	}
	
	public function setSamplerate($s)
	{
		$this->samplerate = $s;
	}
	
	public function build()
	{
		$root = $this->dom->createElementNS(RCSMediaFormat::XMLNS,
		                                    "pe:MediaFormat");
		$this->dom->appendChild($root);
		if ($this->encoding)
		{
			$root->appendChild(
				$this->dom->createElementNS(RCSMediaFormat::XMLNS,
				                            "pe:encoding",
				                            $this->encoding));
		}
		if ($this->packaging)
		{
			$root->appendChild(
				$this->dom->createElementNS(RCSMediaFormat::XMLNS,
				                            "pe:packaging",
				                            $this->packaging));
		}
		if ($this->num_channels)
		{
			$root->appendChild(
				$this->dom->createElementNS(RCSMediaFormat::XMLNS,
				                            "pe:numChannels",
				                            $this->num_channels));
		}
		if ($this->samplerate)
		{
			$root->appendChild(
				$this->dom->createElementNS(RCSMediaFormat::XMLNS,
				                            "pe:sampleRate",
				                            $this->samplerate));
		}
	}
}

class RCSTimePoint extends XMLDocument
{
	const XMLNS = "urn:PEContentSchema";
	
	protected $time;
	protected $description;
	
	public function getTime()
	{
		return $this->time;
	}
	
	public function setTime($t)
	{
		$this->time = $t;
	}
	
	public function getDescription()
	{
		return $this->description;
	}
	
	public function setDescription($d)
	{
		$this->description = $d;
	}
	
	public function build()
	{
		$root = $this->dom->createElementNS(RCSTimePoint::XMLNS,
		                                    "pe:TimePoint");
		$this->dom->appendChild($root);
		$root->appendChild(
			$this->dom->createElementNS(RCSMediaFormat::XMLNS,
			                            "pe:time",
			                            $this->time));
		if ($this->description)
		{
			$root->appendChild(
				$this->dom->createElementNS(RCSMediaFormat::XMLNS,
				                            "pe:description",
				                            $this->description));
		}
	}
}

?>