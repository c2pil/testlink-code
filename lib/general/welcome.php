<?php 
require('../../config.inc.php');
require_once("common.php");
// start session, need to get right basehref
testlinkInitPage($db);

$user = $_SESSION['currentUser'];

$secCfg = config_get('config_check_warning_frequence'); 

$gui = new stdClass();
$gui->securityNotes = '';
if((strcmp($secCfg, 'ALWAYS') == 0) || ((strcmp($secCfg, 'ONCE_FOR_SESSION') == 0) && filter_var($_SESSION['getSecurityNotesOnMainPageDone']) === "")){
    $_SESSION['getSecurityNotesOnMainPageDone'] = 1;
    $gui->securityNotes = getSecurityNotes($db);
}

/** redirect admin to create testproject if not found */
if ($user->hasRight($db,'mgt_modify_product') && filter_var($_SESSION['testprojectID']) === ""){
    redirect(filter_var($_SESSION['basehref']) . 'lib/project/projectEdit.php?doAction=create&showTabs=no');
}

$tproject_mgr = new testproject($db);

$smarty = new TLSmarty();
$smarty->assign('gui',$gui);
$smarty->assign('testprojectName', $_SESSION['testprojectName']);
$smarty->assign('testprojectPrefix', $_SESSION['testprojectPrefix']);
$smarty->assign('testprojectNotes', $tproject_mgr->get_by_id($_SESSION['testprojectID'])['notes']);
$smarty->assign('testplanName', $_SESSION['testplanName']);
$smarty->assign('printFooter', printFooter($tlCfg->testlinkdotorg));
$smarty->display("welcome.tpl");
?>