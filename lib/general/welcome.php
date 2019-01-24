<?php 
require('../../config.inc.php');
require_once("common.php");
// start session, need to get right basehref
testlinkInitPage($db);

$smarty = new TLSmarty();

$templateCfg = templateConfiguration();

$smarty->assign('printFooter', printFooter($tlCfg->testlinkdotorg));
$smarty->display("welcome.tpl");
?>