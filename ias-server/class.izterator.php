<?php

/**
* Izterator - implements the PHP5 interface "Iterator".
* 
* @author Loïc Mathaud
* @package izterator
*/
class izterator implements Iterator
{
	var $array_data;
	var $array_index;
	var $nbResults;

	/**
	 * Constructeur
	 * 
	 * Affecte le tableau passé en paramètre à une variable de classe puis
	 * appelle la méthode de classe {@link rewind()}
	 * 
	 * @param array $array tableau de résultat MySQL depuis classe dbMysql
	 * @access public 
	 */
	function izterator($array)
	{
		if (is_array($array))
		{
			$this->array_data = $array;
		} 
		$this->nbResults = count($array);
		$this->rewind();
	} 

	/**
	 * Retourne la valeur du champ spécifié par $field pour l'index courant
	 * ou retourne un tableau de tout l'enregistrement pour ce même index
	 * 
	 * @param string $field champ à afficher pour l'enregistrement courant
	 * @access public 
	 */
	function current($field = '')
	{
		if (empty($field))
		{
			return $this->array_data[$this->array_index];
		} 
		else
		{
			//$field = strtolower($field);
			return $this->array_data[$this->array_index][$field];
		} 
	} 

	/**
	 * Avance le curseur sur l'enregistrement suivant
	 * 
	 * @access public 
	 */
	function next()
	{
		$this->array_index++;
		return true;
	} 

	/**
	 * Retourne TRUE si on est à la fin de la pile, FALSE sinon
	 * 
	 * @access public 
	 */
	function endof()
	{
		if (($this->array_index + 1) <= $this->nbResults)
		{
			return false;
		} 
		else
		{
			return true;
		} 
	} 

	/**
	 * Retourne l'index pointé actuellement
	 * 
	 * @access public 
	 */
	function key()
	{
		return $this->array_index;
	} 

	/**
	 * Fait pointer le curseur sur le premier enregistrement
	 * 
	 * @access public 
	 */
	function rewind()
	{
		$this->array_index = 0;
		return true;
	} 

	/**
	 * Fait pointer le curseur sur le dernier enregistrement
	 * 
	 * @access public 
	 */
	function end()
	{
		$this->array_index = $this->nbResults - 1;
		return true;
	} 

	/**
	 * Retourne le nombre d'enregistrements dans la pile
	 * 
	 * @access public 
	 */
	function count()
	{
		return $this->nbResults;
	} 

	/**
	 * Pour la validité de l'interface.
	 * 
	 * @access public 
	 */
	function valid()
	{
		return !$this->endof();
	} 
} 

?>
