<?php
require('include/mysql.php');
checkSaneInstall();
header('Content-type: text/xml');
require('include/XMLFunctions.php');
echo getMessages();
?>
