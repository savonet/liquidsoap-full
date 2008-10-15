<?php

// Database connection
include_once('class.izterator.php');
include_once('class.izteratorbuilder.php');
include_once('class.db.php');
include_once('inc.db.php');

// Params
include_once('inc.params.php');

// PEAR
include_once('PEAR.php');
include_once('Log.php');
include_once('Cache.php');
include_once('File/XSPF.php');

// XML Document
include_once('class.xmldocument.php');
include_once('class.soapdocument.php');
include_once('class.lmtdocument.php');
include_once('class.xspf.php');
include_once('class.rcsschemas.php');

// Simple log handlers
$console = &Log::singleton('console', '', '[WebInterface]', array(), PEAR_LOG_INFO);
$file = &Log::singleton('file', '/tmp/scheduler-soap.log', '[WebInterface]');

// Composite log handler
$composite = &Log::singleton('composite');
$composite->addChild($console);
$composite->addChild($file);

// Content-Type
header('Content-Type: application/xml');

function get_element_types()
{
	// Get a connection to the database
	$db = SchedulerDBC::getInstance();
	
	// Create the Liq Message Type header
	$header = new LiqMessageTypeDocument();
	$header->setContentType("application/xspf+xml");
	$header->setRole("http://savonet.sf.net/message/role/types-list");
	$header->setHostname(SERVER_NAME);
	$header->build();
	
	// Create the XSPF playlist
	$pl = new XSPFPlaylist();
	
	// Now query the database
	try
	{
		$sql = "SELECT * FROM event_types ORDER BY id";
		$result = $db->selectQuery($sql);
		
		$pl = new XSPFPlaylist();
		while (!$result->endof())
		{
			$track = new XSPFTrack();
			$track->setTitle($result->current("name"));
			$url = sprintf("http://%s%s/type?id=%d",
			               SERVER_NAME,
			               BASE_DIR,
			               $result->current("id"));
			$track->addLocation($url);
			$pl->addTrack($track);

			$result->next();
		}
	}
	catch (SQLNoResultException $e) {}
	
	$soap = new SOAPDocument();
	$soap->setHeader($header);
	$soap->setBody($pl);
	$soap->build();
	echo $soap->getDOM()->saveXML();
}

function get_categories($id)
{
	// Get a connection to the database
	$db = SchedulerDBC::getInstance();
	
	// Create the Liq Message Type header
	$header = new LiqMessageTypeDocument();
	$header->setContentType("application/xspf+xml");
	$header->setRole("http://savonet.sf.net/message/role/categories-list");
	$header->setHostname(SERVER_NAME);
	$header->build();
	
	// Create the XSPF playlist
	$pl = new XSPFPlaylist();
	
	// Now query the database
	try
	{
		$sql = "SELECT * FROM stacks WHERE type_id = %d ORDER BY name";
		$sql = sprintf($sql, $id);
		$result = $db->selectQuery($sql);
		
		$pl = new XSPFPlaylist();
		while (!$result->endof())
		{
			$track = new XSPFTrack();
			$track->setTitle($result->current("name"));
			$url = sprintf("http://%s%s/category?id=%d",
			               SERVER_NAME,
			               BASE_DIR,
			               $result->current("id"));
			$track->addLocation($url);
			$pl->addTrack($track);

			$result->next();
		}
	}
	catch (SQLNoResultException $e) {}
	
	$soap = new SOAPDocument();
	$soap->setHeader($header);
	$soap->setBody($pl);
	$soap->build();
	echo $soap->getDOM()->saveXML();
}

function get_playlist($id)
{
	// Get a connection to the database
	$db = SchedulerDBC::getInstance();
	
	// Create the Liq Message Type header
	$header = new LiqMessageTypeDocument();
	$header->setContentType("application/xspf+xml");
	$header->setRole("http://savonet.sf.net/message/role/category-contents");
	$header->setHostname(SERVER_NAME);
	$header->build();
	
	// Create the XSPF playlist
	$pl = new XSPFPlaylist();
	
	// Now query the database
	try
	{
		$sql = "SELECT se.*, a.GUID AS artist_GUID, a.name AS artist_name FROM stack_elements AS se, artists AS a WHERE se.stack_id = %d AND se.artist = a.id ORDER BY title, a.name";
		$sql = sprintf($sql, $id);
		$result = $db->selectQuery($sql);
		
		$pl = new XSPFPlaylist();
		while (!$result->endof())
		{
			$track = new XSPFTrack();
			$track->setTitle($result->current("title"));
			$track->setCreator($result->current("artist_name"));
			$track->setDuration($result->current("duration") * 1000);
			$url = sprintf("http://%s%s/metadata?guid=%s",
			               SERVER_NAME,
			               BASE_DIR,
			               $result->current("GUID"));
			$track->setInfo($url);
			$track->addLocation($result->current("URL"));
			$pl->addTrack($track);

			$result->next();
		}
	}
	catch (SQLNoResultException $e) {}
	
	$soap = new SOAPDocument();
	$soap->setHeader($header);
	$soap->setBody($pl);
	$soap->build();
	echo $soap->getDOM()->saveXML();
}

function get_metadata($guid)
{
	// Get a connection to the database
	$db = SchedulerDBC::getInstance();
	
	// Create the Liq Message Type header
	$header = new LiqMessageTypeDocument();
	$header->setContentType("application/x-rcs+xml");
	$header->setRole("http://savonet.sf.net/message/role/song-metadata");
	$header->setHostname(SERVER_NAME);
	$header->build();
	
	// Now query the database
	try
	{
		$sql = "SELECT *, s.name AS category, se.id AS song_id, a.id AS artist_id, se.GUID AS song_GUID, a.GUID AS artist_GUID, a.name AS artist_name FROM stack_elements AS se, artists AS a, stacks AS s WHERE se.guid = '%s' AND a.id = se.artist AND s.id = se.stack_id;";
		$sql = sprintf($sql, $guid);
		$result = $db->selectQuery($sql);
		
		// Create the RCS Song
		$s = new RCSSong($result->current("song_GUID"), $result->current("title"));
		$s->setInternalID($result->current("song_id"));
		$s->setOpening($result->current("opening"));
		$s->setEnding($result->current("ending"));
		$s->setCategory($result->current("category"));
		
		// Create the RCS Artist
		$a = new RCSArtist($result->current("artist_GUID"), $result->current("artist_name"));
		$a->setInternalID($result->current("artist_id"));
		$a->setSequenceNumber(1);
		$a->build();
		$s->addArtist($a);
		
		// Create the RCS Media
		$m = new RCSMedia();
		
		// Create the RCS MediaFormat
		$f = new RCSMediaFormat();
		$f->setEncoding($result->current("audio_format"));
		$f->setPackaging($result->current("audio_container"));
		$f->setNumChannels($result->current("audio_channels"));
		$f->setSamplerate($result->current("audio_samplerate"));
		$f->build();
		$m->setMediaFormat($f);
		
		// Add the various timemarkers
		if ($result->current("marker_fade_in") != null)
		{
			$t = new RCSTimePoint();
			$t->setTime($result->current("marker_fade_in"));
			$t->setDescription("fade-in");
			$t->build();
			$m->addTimePoint($t);
		}
		if ($result->current("marker_fade_out") != null)
		{
			$t = new RCSTimePoint();
			$t->setTime($result->current("marker_fade_out"));
			$t->setDescription("fade-out");
			$t->build();
			$m->addTimePoint($t);
		}
		if ($result->current("marker_start_next") != null)
		{
			$t = new RCSTimePoint();
			$t->setTime($result->current("marker_start_next"));
			$t->setDescription("start-next");
			$t->build();
			$m->addTimePoint($t);
		}
		
		// Build everything that's not yet built
		$m->build();
		$s->setMedia($m);
		$s->build();
		
		// Now, the SOAP Document
		$soap = new SOAPDocument();
		$soap->setHeader($header);
		$soap->setBody($s);
		$soap->build();
		
		echo $soap->getDOM()->saveXML();
	}
	catch(SQLNoResultException $e)
	{
		header('404 Not Found HTTP/1.1', true);
		
		// SOAP Fault
		$fault = new SOAPError(E_SENDER, "No title found matching given GUID.");
		$fault->build();
		
		// SOAP Document
		$soap = new SOAPDocument();
		$soap->setBody($fault);
		$soap->build();
		echo $soap->getDOM()->saveXML();
	}
}

switch (basename($_SERVER["SCRIPT_NAME"]))
{
	case "database.php":
		get_element_types();
		break;
	case "type.php":
		if (!array_key_exists('id', $_GET)) die("No id.");
		get_categories($_GET['id']);
		break;
	case "category.php":
		if (!array_key_exists('id', $_GET)) die("No id.");
		get_playlist($_GET['id']);
		break;
	case "metadata.php":
		if (!array_key_exists('guid', $_GET)) die("No GUID.");
		get_metadata($_GET['guid']);
		break;
	default:
		header("400 Bad Request HTTP/1.1", true);
		
		// SOAP Fault
		$fault = new SOAPError(E_SENDER, "The server didn't understand your request.");
		$fault->build();
		
		// SOAP Document
		$soap = new SOAPDocument();
		$soap->setBody($fault);
		$soap->build();
		echo $soap->getDOM()->saveXML();
		break;
}
//get_element_types();
//get_categories(1);
//get_playlist(1);
//get_metadata("5312F06F-4F57-47A2-A1E4-2EF072DDF430")
//phpinfo();

?>
