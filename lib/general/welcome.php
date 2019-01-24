<?php 
require('../../config.inc.php');
require_once("common.php");
// start session, need to get right basehref
testlinkInitPage($db);

$secCfg = config_get('config_check_warning_frequence'); 

$gui = new stdClass();
$gui->securityNotes = '';
if((strcmp($secCfg, 'ALWAYS') == 0) || ((strcmp($secCfg, 'ONCE_FOR_SESSION') == 0) && !isset($_SESSION['getSecurityNotesOnMainPageDone']))){
    $_SESSION['getSecurityNotesOnMainPageDone'] = 1;
    $gui->securityNotes = getSecurityNotes($db);
}

$smarty = new TLSmarty();
$smarty->assign('gui',$gui);
$smarty->assign('printFooter', printFooter($tlCfg->testlinkdotorg));
$smarty->display("welcome.tpl");
?>