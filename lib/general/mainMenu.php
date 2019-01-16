<?php
/**
 * TestLink Open Source Project - http://testlink.sourceforge.net/ 
 * This script is distributed under the GNU General Public License 2 or later. 
 *
 * @filesource	mainMenu.php
 * 
 * Page has two functions: navigation and select Test Plan
 *
 * This file is the first page that the user sees when they log in.
 * Most of the code in it is html but there is some logic that displays
 * based upon the login. 
 * There is also some javascript that handles the form information.
 *
 **/

require_once('../../config.inc.php');
require_once('common.php');

testlinkInitPage($db,TRUE);

$smarty = new TLSmarty();
$tproject_mgr = new testproject($db);
$user = $_SESSION['currentUser'];


$testprojectID = isset($_SESSION['testprojectID']) ? intval($_SESSION['testprojectID']) : 0;

if( isset($_REQUEST['testplan']) ) {
  $testplanID = $_REQUEST['testplan'];

} else {
  $testplanID = isset($_SESSION['testplanID']) ? $_SESSION['testplanID'] : 0;
}
$testplanID = intval($testplanID);


$accessibleItems = $tproject_mgr->get_accessible_for_user($user->dbID,array('output' => 'map_name_with_inactive_mark'));
$tprojectQty = $tproject_mgr->getItemCount();
$userIsBlindFolded = (is_null($accessibleItems) || count($accessibleItems) == 0) && $tprojectQty > 0;

if($userIsBlindFolded) {
  $testprojectID = $testplanID = 0;
  $_SESSION['testprojectTopMenu'] = '';
}

$tplan2check = null;
$currentUser = $_SESSION['currentUser'];
$userID = $currentUser->dbID;

$gui_menu = new stdClass();
$gui_menu->grants = getGrants($db,$user,$userIsBlindFolded);
$gui_menu->hasTestCases = false;

if($gui_menu->grants['view_tc']) { 
	$gui_menu->hasTestCases = $tproject_mgr->count_testcases($testprojectID) > 0 ? 1 : 0;
}

$gui_menu->hasKeywords = false;
if($gui_menu->hasTestCases) {
  $gui_menu->hasKeywords = $tproject_mgr->hasKeywords($testprojectID);
}  


// ----- Test Plan Section --------------------------------
/** 
 * @TODO - franciscom - we must understand if these two calls are really needed,
 * or is enough just call to getAccessibleTestPlans()
 */
$filters = array('plan_status' => ACTIVE);
$gui_menu->num_active_tplans = $tproject_mgr->getActiveTestPlansCount($testprojectID);

// get Test Plans available for the user 
$arrPlans = (array)$currentUser->getAccessibleTestPlans($db,$testprojectID);

if($testplanID > 0) {
	// if this test plan is present on $arrPlans
	//	  OK we will set it on $arrPlans as selected one.
	// else 
	//    need to set test plan on session
	//
	$index=0;
	$found=0;
	$loop2do=count($arrPlans);
	for($idx=0; $idx < $loop2do; $idx++) {
  	if( $arrPlans[$idx]['id'] == $testplanID ) {
     	$found = 1;
     	$index = $idx;
     	break;
    }
  }
  if( $found == 0 ) {
    // update test plan id
    $index = 0;
    $testplanID = $arrPlans[$index]['id'];
  } 

  setSessionTestPlan($arrPlans[$index]);         
  $arrPlans[$index]['selected']=1;
}

$gui_menu->testplanRole = null;
if ($testplanID)  {

  $rd = null; 
  // Role can be configured or inherited
  if( isset($currentUser->tplanRoles[$testplanID]) ) {
    // Configured
    $role = $currentUser->tplanRoles[$testplanID];
    $rd = $role->getDisplayName();
  } else {
    if( config_get('testplan_role_inheritance_mode') == 'global' ) {
      $rd = $currentUser->globalRole->name;
    }
  } 

  if( null != $rd ) {
    $gui_menu->testplanRole = $tlCfg->gui->role_separator_open .$rd . $tlCfg->gui->role_separator_close;
  }
}
$rights2check = array('testplan_execute','testplan_create_build',
                      'testplan_metrics','testplan_planning',
                      'testplan_user_role_assignment',
                      'mgt_testplan_create',
                      'cfield_view', 'cfield_management',
                      'testplan_milestone_overview',
                      'exec_testcases_assigned_to_me',
                      'exec_assign_testcases','exec_ro_access',
                      'testplan_add_remove_platforms',
                      'testplan_update_linked_testcase_versions',
                      'testplan_set_urgent_testcases',
                      'testplan_show_testcases_newest_versions');

foreach($rights2check as $key => $the_right) {
  $gui_menu->grants[$the_right] = $userIsBlindFolded ? 'no' : $currentUser->hasRight($db,$the_right,$testprojectID,$testplanID);
}
                         
$gui_menu->grants['tproject_user_role_assignment'] = "no";
if( $currentUser->hasRight($db,"testproject_user_role_assignment",$testprojectID,-1) == "yes" ||
    $currentUser->hasRight($db,"user_role_assignment",null,-1) == "yes" )
{ 
    $gui_menu->grants['tproject_user_role_assignment'] = "yes";
}


$gui_menu->url = array('metrics_dashboard' => 'lib/results/metricsDashboard.php',
                  'testcase_assignments' => 'lib/testcases/tcAssignedToUser.php');
$gui_menu->launcher = 'lib/general/frmWorkArea.php';
$gui_menu->arrPlans = $arrPlans;                   
$gui_menu->countPlans = count($gui_menu->arrPlans);


$gui_menu->testprojectID = $testprojectID;
$gui_menu->testplanID = $testplanID;

$gui_menu->docs = config_get('userDocOnDesktop') ? getUserDocumentation() : null;

$secCfg = config_get('config_check_warning_frequence');
$gui_menu->securityNotes = '';
if( (strcmp($secCfg, 'ALWAYS') == 0) || 
      (strcmp($secCfg, 'ONCE_FOR_SESSION') == 0 && !isset($_SESSION['getSecurityNotesOnMainPageDone'])) )
{
  $_SESSION['getSecurityNotesOnMainPageDone'] = 1;
  $gui_menu->securityNotes = getSecurityNotes($db);
}  

$gui_menu->opt_requirements = isset($_SESSION['testprojectOptions']->requirementsEnabled) ? 
                         $_SESSION['testprojectOptions']->requirementsEnabled : null; 


$gui_menu->plugins = array();
foreach(array('EVENT_LEFTMENU_TOP',
              'EVENT_LEFTMENU_BOTTOM',
              'EVENT_RIGHTMENU_TOP',
              'EVENT_RIGHTMENU_BOTTOM') as $menu_item) 
{
  # to be compatible with PHP 5.4
  $menu_content = event_signal($menu_item);
  if( !empty($menu_content) )
  {
    $gui_menu->plugins[$menu_item] = $menu_content;
  }
}

$basehref = $_SESSION['basehref'];

const TAB1 = 0, TAB2 = 1, TAB3 = 2, TAB4 = 3;

$gui_menu->href = array(
    "projectView" => "lib/project/projectView.php",
    "usersAssign" => "lib/usermanagement/usersAssign.php?featureType=testproject&featureID=",
    "cfAssignment" => "lib/cfields/cfieldsTprojectAssign.php",
    "keywordsAssignment" => "lib/keywords/keywordsView.php?tproject_id=",
    "platformsView" => "lib/platforms/platformsView.php",
    "cfieldsView" => "lib/cfields/cfieldsView.php",
    "issueTrackerView" => "lib/issuetrackers/issueTrackerView.php",
    "codeTrackerView" => "lib/codetrackers/codeTrackerView.php",
    "reqOverView" => "lib/requirements/reqOverview.php",
    "reqMonOverView" => "lib/requirements/reqMonitorOverview.php?tproject_id=",
    "tcSearch" => "lib/testcases/tcSearch.php?doAction=userInput&tproject_id=",
    "tcCreatedUser" => "lib/results/tcCreatedPerUserOnTestProject.php?do_action=uinput&tproject_id=",
    "assignReq" => "lib/general/frmWorkArea.php?feature=assignReqs",
    "inventoryView" => "lib/inventory/inventoryView.php",
    
    "projectReq" => "lib/project/project_req_spec_mgmt.php?id=1",
    "printReqSpec" => "lib/general/staticPage.php?key=printReqSpec",
    "searchReq" => "lib/general/staticPage.php?key=searchReq",
    "searchReqSpec" => "lib/general/staticPage.php?key=searchReqSpec",
    "assignReqs" => "lib/general/staticPage.php?key=assignReqs",
    "archiveData" => "lib/testcases/archiveData.php?edit=testproject&id=1",
    "keywordsAssign" => "lib/general/staticPage.php?key=keywordsAssign",
    
    "planView" => "lib/plan/planView.php",
    "buildView" => "lib/plan/buildView.php?tplan_id=",
    "mileView" => "lib/plan/planMilestonesView.php",
    "platformAssign" => "lib/platforms/platformsAssign.php?tplan_id="
);

$gui_menu->tabsList = array(
    array(
        array(hasGrant($gui_menu->grants['cfield_management']), $basehref.$gui_menu->href["cfieldsView"], lang_get('href_cfields_management')),
        array(hasGrant($gui_menu->grants['issuetracker_management']) || hasGrant($gui_menu->grants['issuetracker_view']), $basehref.$gui_menu->href["issueTrackerView"], lang_get('href_issuetracker_management')),
        array(hasGrant($gui_menu->grants['codetracker_management']) || hasGrant($gui_menu->grants['codetracker_view']), $basehref.$gui_menu->href["codeTrackerView"], lang_get('href_codetracker_management'))
    ),
    array(
        array(hasGrant($gui_menu->grants['project_edit']), $basehref.$gui_menu->href["projectView"], lang_get('href_tproject_management')),
        array(hasGrant($gui_menu->grants['tproject_user_role_assignment']), $basehref.$gui_menu->href["usersAssign"].$gui_menu->testprojectID, lang_get('href_assign_user_roles')),
        array(hasGrant($gui_menu->grants['cfield_management']), $basehref.$gui_menu->href["cfAssignment"], lang_get('href_cfields_tproject_assign')),
        array(hasGrant($gui_menu->grants['keywords_view']), $basehref.$gui_menu->href["keywordsAssignment"].$gui_menu->testprojectID, lang_get('href_keywords_manage')),
        array(hasGrant($gui_menu->grants['platform_management']) || hasGrant($gui_menu->grants['platform_view']), $basehref.$gui_menu->href["platformsView"], lang_get('href_platform_management')),
        array(hasGrant($gui_menu->grants['project_inventory_view']) || hasGrant($gui_menu->grants['project_inventory_management']), $basehref.$gui_menu->href["inventoryView"], lang_get('href_inventory_management'))
    ),
    array(
        array(hasGrant($gui_menu->grants['reqs_view']) || hasGrant($gui_menu->grants['reqs_edit']), $basehref.$gui_menu->launcher."?feature=reqSpecMgmt", lang_get('href_req_spec'), $gui_menu->href["projectReq"]),
        array(hasGrant($gui_menu->grants['reqs_view']) || hasGrant($gui_menu->grants['reqs_edit']), $basehref.$gui_menu->href["reqOverView"], lang_get('href_req_overview')),
        array(hasGrant($gui_menu->grants['reqs_view']) || hasGrant($gui_menu->grants['reqs_edit']), $basehref.$gui_menu->launcher."?feature=printReqSpec", lang_get('href_print_req'), $gui_menu->href["printReqSpec"]),
        array(hasGrant($gui_menu->grants['reqs_view']) || hasGrant($gui_menu->grants['reqs_edit']), $basehref.$gui_menu->launcher."?feature=searchReq", lang_get('href_search_req'), $gui_menu->href["searchReq"]),
        array(hasGrant($gui_menu->grants['reqs_view']) || hasGrant($gui_menu->grants['reqs_edit']), $basehref.$gui_menu->launcher."?feature=searchReqSpec", lang_get('href_search_req_spec'), $gui_menu->href["searchReqSpec"]),
        array(hasGrant($gui_menu->grants['req_tcase_link_management']), $basehref.$gui_menu->href["assignReq"], lang_get('href_req_assign'), $gui_menu->href["assignReqs"]),
        array(hasGrant($gui_menu->grants['monitor_req']), $basehref.$gui_menu->href["reqMonOverView"].$gui_menu->testprojectID, lang_get('href_req_monitor_overview'))
    ),
    array(
        array(hasGrant($gui_menu->grants['view_tc']), $basehref.$gui_menu->launcher."?feature=editTc", hasGrant($gui_menu->grants['modify_tc'])?lang_get('href_edit_tc'):lang_get('href_browse_tc'), $gui_menu->href["archiveData"]),
        array(hasGrant($gui_menu->hasTestCases), $basehref.$gui_menu->href["tcSearch"].$gui_menu->testprojectID, lang_get('href_search_tc')),
        array(hasGrant($gui_menu->hasKeywords) && hasGrant($gui_menu->grants['keyword_assignment']), $basehref.$gui_menu->launcher."?feature=keywordsAssign", lang_get('href_keywords_assign'), $gui_menu->href["keywordsAssign"]),
        array(hasGrant($gui_menu->grants['modify_tc']), $basehref.$gui_menu->href["tcCreatedUser"].$gui_menu->testprojectID, lang_get('link_report_test_cases_created_per_user'))
    )
);

if($gui_menu->countPlans > 0){
    
    if(hasGrant($gui_menu->grants.testplan_planning)){
        $gui_menu->tabsList[] = array(
            array(hasGrant($gui_menu->grants['cfield_management']), $basehref.$gui_menu->href["cfieldsView"], lang_get('href_cfields_management')),
            array(hasGrant($gui_menu->grants['issuetracker_management']) || hasGrant($gui_menu->grants['issuetracker_view']), $basehref.$gui_menu->href["issueTrackerView"], lang_get('href_issuetracker_management')),
            array(hasGrant($gui_menu->grants['codetracker_management']) || hasGrant($gui_menu->grants['codetracker_view']), $basehref.$gui_menu->href["codeTrackerView"], lang_get('href_codetracker_management'))
        );
    }
}

// $gui->grants.mgt_testplan_create == "yes"} {$planView} href_plan_management}
// $gui->grants.testplan_create_build == "yes" and $gui->countPlans > 0}{$buildView}{$gui->testplanID}" href_build_new}
// ($gui->grants.mgt_testplan_create == "yes" || $gui->grants.testplan_create_build == "yes") && $gui->grants.testplan_milestone_overview == "yes" && $gui->countPlans > 0} {$mileView} href_plan_mstones}

// $gui->grants.testplan_execute == "yes" {$gui->launcher}?feature=executeTest href_execute_test
// $gui->grants.exec_ro_access == "yes" {$gui->launcher}?feature=executeTest href_exec_ro_access
// $gui->grants.testplan_execute == "yes" || $gui->grants.exec_ro_access == "yes" {$gui->url.testcase_assignments} href_my_testcase_assignments
// $gui->grants.testplan_metrics == "yes" {$gui->launcher}?feature=showMetrics href_rep_and_metrics
// $gui->grants.testplan_metrics == "yes" {$gui->url.metrics_dashboard} href_metrics_dashboard

// $gui->grants.testplan_add_remove_platforms == "yes" {$platformAssign}{$gui->testplanID} href_platform_assign
// {$gui->launcher}?feature=planAddTC href_add_remove_test_cases
// {$gui->launcher}?feature=tc_exec_assignment href_tc_exec_assignment
// $session['testprojectOptions']->testPriorityEnabled && $gui->grants.testplan_set_urgent_testcases == "yes" {$gui->launcher}?feature=test_urgency href_plan_assign_urgency
// $gui->grants.testplan_update_linked_testcase_versions == "yes" {$gui->launcher}?feature=planUpdateTC href_update_tplan
// $gui->grants.testplan_show_testcases_newest_versions == "yes" {$gui->launcher}?feature=newest_tcversions href_newest_tcversions

$tplKey = 'mainMenu';
$tpl = $tplKey . '.tpl';
$tplCfg = config_get('tpl');
if( null !== $tplCfg && isset($tplCfg[$tplKey]) ) {
  $tpl = $tplCfg->$tplKey;
} 
$smarty->assign('gui',$gui_menu);
$smarty->display($tpl);

/**
 * Print the navigation tabs
 */
function print_tabs($active_page, $gui_menu, $tab_number, $is_frame=false){
    if($tab_number === -1){
        return "";
    }
    $s = "";
    $s .= '<ul class="nav nav-tabs padding-18">';
        foreach( $gui_menu->tabsList[$tab_number] as $tab ) {
            if(tab[0]){
                if($is_frame){
                    //                 echo $tab[3];
                    $t_active = ($tab[3] === $active_page) ? 'active' : '';
                }else{
                    $t_active =  strpos($tab[1], $active_page) ? 'active' : '';
                }
                $s .= '<li class="' . $t_active .  '">';
                $s .= '<a href="'. $tab[1] .'">' . $tab[2] . '</a>';
                $s .= '</li>';
            }
        }
    $s .=  '</ul>';
    return $s;
}

/**
 * Return true if user has right
 * @param string $grant
 * @return boolean
 */
function hasGrant($grant){
    return ($grant === "yes");
}

/**
 * Get User Documentation 
 * based on contribution by Eugenia Drosdezki
 */
function getUserDocumentation()
{
  $target_dir = '..' . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'docs';
  $documents = null;
    
  if ($handle = opendir($target_dir)) 
  {
    while (false !== ($file = readdir($handle))) 
    {
      clearstatcache();
      if (($file != ".") && ($file != "..")) 
      {
        if (is_file($target_dir . DIRECTORY_SEPARATOR . $file))
        {
          $documents[] = $file;
        }    
      }
    }
    closedir($handle);
  }
  return $documents;
}

/**
 *
 */
function getGrants($dbHandler,$user,$forceToNo=false)
{
  // User has test project rights
  // This talks about Default/Global
  //
  // key: more or less verbose
  // value: string present on rights table
  $right2check = array('project_edit' => 'mgt_modify_product',
                       'reqs_view' => "mgt_view_req", 
                       'monitor_req' => "monitor_requirement", 
                       'req_tcase_link_management' => "req_tcase_link_management",
                       'reqs_edit' => "mgt_modify_req",
                       'keywords_view' => "mgt_view_key",
                       'keyword_assignment' => "keyword_assignment",
                       'keywords_edit' => "mgt_modify_key",
                       'platform_management' => "platform_management",
                       'issuetracker_management' => "issuetracker_management",
                       'issuetracker_view' => "issuetracker_view",
                       'codetracker_management' => "codetracker_management",
                       'codetracker_view' => "codetracker_view",
                       'configuration' => "system_configuraton",
                       'cfield_management' => 'cfield_management',
                       'cfield_view' => 'cfield_view',
                       'cfield_assignment' => 'cfield_assignment',
                       'usergroups' => "mgt_view_usergroups",
                       'view_tc' => "mgt_view_tc",
                       'view_testcase_spec' => "mgt_view_tc",
                       'project_inventory_view' => 'project_inventory_view',
                       'project_inventory_management' => 'project_inventory_management',
                       'modify_tc' => 'mgt_modify_tc',
                       'exec_edit_notes' => 'exec_edit_notes', 'exec_delete' => 'exec_delete',
                       'testplan_unlink_executed_testcases' => 'testplan_unlink_executed_testcases',
                       'testproject_delete_executed_testcases' => 'testproject_delete_executed_testcases',
                       'exec_ro_access' => 'exec_ro_access');
 if($forceToNo)
 {
    $grants = array_fill_keys(array_keys($right2check), 'no');
    return $grants;      
 }  
  
  
 $grants['project_edit'] = $user->hasRight($dbHandler,$right2check['project_edit']); 

  /** redirect admin to create testproject if not found */
  if ($grants['project_edit'] && !isset($_SESSION['testprojectID']))
  {
	  redirect($_SESSION['basehref'] . 'lib/project/projectEdit.php?doAction=create');
	  exit();
  }
  
  foreach($right2check as $humankey => $right)
  {
    $grants[$humankey] = $user->hasRight($dbHandler,$right); 
  }


  // check right ONLY if option is enables
  if($_SESSION['testprojectOptions']->inventoryEnabled) {
    $invr = array('project_inventory_view','project_inventory_management');
    foreach($invr as $r){
      $grants[$r] = ($user->hasRight($dbHandler,$r) == 'yes') ? 1 : 0;
    }
  }

  return $grants;  
}
