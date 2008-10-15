<?php

/**
* Builds an iterator.
* 
* @author Vincent Tabard
* @package izterator
*/
class izteratorBuilder
{
	/**
	* @var array
	* @access private
	*/
	var $array;
	
	/**
	* Constructor. Does not do anything (but needs to be called).
	* 
	* @author Vincent Tabard
	*/
	function izteratorBuilder()
	{
		$this->array = array();
	}
	
	/**
	* Adds an element at the end of the izterator.
	* 
	* @param mixed $element The element to push.
	* @return void
	* @author Vincent Tabard
	*/
	function push($element)
	{
		$this->array[] = $element;
	}
	
	/**
	* Removes the last element from the izterator.
	* 
	* @return void
	* @author Vincent Tabard
	*/
	function pop()
	{
		$value = array_pop($this->array);
		
		return $value;
	}
	
	/**
	* Returns the izterator we've built.
	* 
	* @param boolean $mourirEnEnfantant Vide la pile après l'avoir renvoyée dans un izterator.
	* @return Iterator
	* @author Vincent Tabard
	*/
	function getIzterator($mourirEnEnfantant=false)
	{
		$izterator = new izterator($this->array);
		
		if ($mourirEnEnfantant)
		{
		    $this->array = array();
		}
		
		return $izterator;
	}
}


?>