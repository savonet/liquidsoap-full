<?php

/**
 * Paramètres de connexion pour Pastebin
 *
 * @version $Id$
 * @copyright 2005 
 * @author Vincent Tabard
 **/

define('CP_DB_HOST', '127.0.0.1');
define('CP_DB_USER', 'root');
define('CP_DB_PASS', '');
define('CP_DB_NAME', 'ias');

/**
* Database connection class specific to the Scheduler, with semi-hard-coded (?!)
* login and stuff.
*/
class SchedulerDBC extends DataBaseConnection
{
	private $cache;
	private $cacheExpires = 3600;
	
	/**
	 * Constructor. Connects to the Scheduler database.
	 */
	public function __construct()
	{
		parent::__construct(CP_DB_HOST, CP_DB_USER, CP_DB_PASS, CP_DB_NAME);
	}
	
	public function cacheInit()
 	{
		$this->cache = new Cache('file', array('cache_dir'=> 'cache/', 'filename_prefix' => 'query__'));
		$this->cache->expires = $this->cacheExpires;
	}
	
	/**
	 * If the single query is a SELECT, pass it to selectQuery(), else pass it
	 * directly to the parent handler.
	 */
	function singleCachedQuery($sql)
	{
		if (substr(trim($query), 0, 6) == 'SELECT')
		{
			return $this->selectQuery($sql);
		}
		else
		{
			return parent::singleQuery($sql);
		}
	}
	
	/**
	 * Logs the request and then passes it to the parent handler.
	 */
	function query($sql)
	{	
		$composite = &Log::singleton('composite');
		$composite->log('MySQL Query: '.$sql, PEAR_LOG_DEBUG);
		
		return parent::query($sql);
	}
	
	/**
	 * Performs a SELECT query on the database. It does not actually mind what
	 * kind of query you're trying to do, but it tries to return an izterator
	 * over the result set. Attention! This one caches the results.
	 * 
	 * @param string $sql The query to execute.
	 * @return izterator
	 * @access public
	 */
	function selectCachedQuery($sql)
	{
		$composite = &Log::singleton('composite');
		
		// Compute unique cache identifier for this query
		$cache_id = md5($sql);
		
		// Query the cache
		$result = $this->cache->get($cache_id);
		
		if ($result == NULL)
		{
			$qry = $this->query($sql);
			
			if (@mysql_num_rows($qry) == 0)
			{
			    throw new SQLNoResultException();
			}
			else
			{
				// On construit un itérateur sur les résultats
				$izb = new izteratorBuilder();
				while($row = @mysql_fetch_array($qry))
				{
					$result[] = $row;
					$izb->push($row);
				}
				
				// Free MySQL Result Resource
				mysql_free_result($qry);
				
				// Store result set in cache
				$this->cache->save($cache_id, $result, $this->cacheExpires);
				
				return $izb->getIzterator();
			}
		}
		else
		{
			$composite->log("Cached MySQL SELECT Query! ".$sql, PEAR_LOG_DEBUG);
			$izt = new izterator($result);
			
			return $izt;
		}
	}
	
	/**
	 * Returns an instance of the DatabaseConnection.
	 */
	public static function getInstance($force_new = false)
	{ 
		if (!isset(self::$_instance) || $force_new)
		{
			self::$_instance = new SchedulerDBC();
		}
		
		return self::$_instance;
	}
}

?>
