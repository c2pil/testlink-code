<?php
/**
 * TestLink Open Source Project - http://testlink.sourceforge.net/
 *
 * @filesource listTestCases.php
 * @author     Martin Havlat
 *
 * Generates tree menu with test specification.
 *
 * @internal revisions
 * @since 1.9.10
 */
require_once('../../config.inc.php');
require_once("common.php");
require_once("treeMenu.inc.php");

const KEYWORDS_ASSIGN = "keywordsAssign";
testlinkInitPage($db);

$templateCfg = templateConfiguration();

$control = new tlTestCaseFilterControl($db, 'edit_mode');
$gui = initializeGui($db, $control);
$control->build_tree_menu($gui);
$control->formAction = '';

$smarty = new TLSmarty();
$smarty->assign('gui', $gui);
$smarty->assign('control', $control);
$smarty->assign('args', $control->get_argument_string());
$smarty->assign('menuUrl', $gui->menuUrl);

$smarty->display($templateCfg->template_dir . 'tcTree.tpl');


/**
 * Initialize object with information for graphical user interface.
 * 
 * @param tlTestCaseFilterControl $control
 * @return stdClass $gui
 */
function initializeGui(&$dbHandler, &$control) 
{
  $gui = new stdClass();
  $gui->feature = $control->args->feature;
  if (strcmp($gui->feature,KEYWORDS_ASSIGN) == 0) {
      $gui->treeHeader = lang_get('desc_keyword_assignment');
  } else {
      $gui->treeHeader = lang_get('href_req_assign');
  }
  

  $lblkey = (config_get('testcase_reorder_by') == 'NAME') ? '_alpha' : '_externalid';
  $gui->btn_reorder_testcases = lang_get('btn_reorder_testcases' . $lblkey);

  $feature_path = array('edit_tc' => "lib/testcases/archiveData.php",
                        KEYWORDS_ASSIGN => "lib/keywords/keywordsAssign.php",
                        'assignReqs' => "lib/requirements/reqTcAssign.php");

  $gui->tree_drag_and_drop_enabled = array('edit_tc' => (has_rights($dbHandler, "mgt_modify_tc") == 'yes'),
                                            KEYWORDS_ASSIGN => false,
                                           'assignReqs' => false);

  $gui->menuUrl = $feature_path[$gui->feature];

  $gui->tree_title = lang_get('title_navigator'). ' - ' . lang_get('title_test_spec');
  return $gui;
}