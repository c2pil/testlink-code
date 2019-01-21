<?php
/**
 * TestLink Open Source Project - http://testlink.sourceforge.net/
 * This script is distributed under the GNU General Public License 2 or later.
 *
 * Test navigator for Test Plan.
 * Used on Test Case Execution Assignment feature
 *
 * @filesource  planTCNavigator.php
 * @package     TestLink
 * @copyright   2003-2014, TestLink community
 * @link        http://www.testlink.org
 *
 * @internal revisions
 * @since 1.9.11
 *
 **/

require('../../config.inc.php');
require_once("common.php");
require_once("users.inc.php");
require_once("treeMenu.inc.php");
require_once('exec.inc.php');

testlinkInitPage($db);
$templateCfg = templateConfiguration();

$control = new tlTestCaseFilterControl($db, 'plan_mode');
$gui = initializeGui($control);
$control->build_tree_menu($gui);
$control->formAction = $_SESSION['basehref'] . "lib/plan/planTCNavigator.php";

$smarty = new TLSmarty();

$smarty->assign('gui', $gui);
$smarty->assign('control', $control);
$smarty->assign('menuUrl', $gui->menuUrl);
$smarty->assign('args', $control->get_argument_string());
$smarty->assign('treeHeader', $gui->title);

$smarty->display($templateCfg->template_dir . $templateCfg->default_template);

/**
 *
 * @param unknown_type $control
 * @return stdClass
 * 
 * @internal revisions:
 */
function initializeGui(&$control) 
{

  $gui = new stdClass();
  $gui->feature = $control->args->feature;
  $gui->tPlanID = $control->args->testplan_id;
  $gui->title = lang_get('title_test_plan_navigator');
  $gui->src_workframe = '';
  $gui->additional_string = '';
  $gui->tree_title = lang_get('title_navigator');
  
  // configure target URLs and clickable buttons
  switch($control->args->feature) 
  {
    case 'planUpdateTC':
      $gui->menuUrl = "lib/plan/planUpdateTC.php";
      $gui->title_navigator = lang_get('navigator_update_linked_tcversions');
      $control->draw_bulk_update_button = true;
      $gui->tree_title .= ' - ' . lang_get('display_test_cases');
    break;
    
    case 'test_urgency':
      $gui->title_navigator = lang_get('navigator_test_urgency');
      $gui->menuUrl = "lib/plan/planUrgency.php";
      $gui->tree_title .= ' - ' . lang_get('test_suite');
    break;

    case 'tc_exec_assignment':
      $gui->title_navigator = lang_get('navigator_tc_exec_assignment');
      $gui->menuUrl = "lib/plan/tc_exec_assignment.php";
      $build_id = $control->settings['setting_build']['selected'];
      $control->draw_tc_unassign_button = true;
      $control->draw_tc_assignment_bulk_copy_button = true;
      $gui->tree_title .= ' - ' . lang_get('display_test_cases');

    break;
  }
  
  return $gui;
}