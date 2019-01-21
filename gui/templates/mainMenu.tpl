{* 
 Testlink Open Source Project - http://testlink.sourceforge.net/ 
 @filesource  mainPageLeft.tpl
 Purpose: smarty template - main page / site map                 
                                                                 
 @internal revisions
*}
{$cfg_section=$smarty.template|replace:".tpl":""}
{config_load file="input_dimensions.conf" section=$cfg_section}
{include file="inc_head.tpl" popup="yes" openHead="yes"}

{include file="inc_ext_js.tpl"}
{include file="bootstrap.inc.tpl"}

{lang_get var='labels' s='title_product_mgmt,href_tproject_management,href_admin_modules,
    href_assign_user_roles,href_cfields_management,system_config,
    href_cfields_tproject_assign,href_keywords_manage,
    title_user_mgmt,href_user_management,
    href_roles_management,title_requirements,
    href_req_spec,href_req_assign,link_report_test_cases_created_per_user,
    title_test_spec,href_edit_tc,href_browse_tc,href_search_tc,
    href_search_req, href_search_req_spec,href_inventory,
    href_platform_management, href_inventory_management,
    href_print_tc,href_keywords_assign, href_req_overview,
    href_print_req,title_plugins,title_documentation,href_issuetracker_management,
    href_codetracker_management,href_reqmgrsystem_management,href_req_monitor_overview,
    current_test_plan,ok,testplan_role,msg_no_rights_for_tp,
    title_test_execution,href_execute_test,href_rep_and_metrics,
    href_update_tplan,href_newest_tcversions,
    href_my_testcase_assignments,href_platform_assign,
    href_tc_exec_assignment,href_plan_assign_urgency,
    href_upd_mod_tc,title_test_plan_mgmt,title_test_case_suite,
    href_plan_management,
    href_build_new,href_plan_mstones,href_plan_define_priority,
    href_metrics_dashboard,href_add_remove_test_cases,
    href_exec_ro_access,admin_button'}
             

{* Show / Hide section logic *}
{$display_left_block_top = false}
{$display_left_block_bottom = false}

{if isset($gui->plugins.EVENT_LEFTMENU_TOP) &&  $gui->plugins.EVENT_LEFTMENU_TOP}
  {$display_left_block_top=true}
{/if}
{if isset($gui->plugins.EVENT_LEFTMENU_BOTTOM) &&  $gui->plugins.EVENT_LEFTMENU_BOTTOM}
  {$display_left_block_bottom=true}
{/if}

<script src="{$basehref}gui/niftycube/niftycube.js" type="text/javascript"></script>
</head>

<body class="testlink skin-3">
    <div id="sidebar" class="sidebar compact sidebar-large">
        {if $gui->securityNotes}
    		{include file="inc_msg_from_array.tpl" array_of_msg=$gui->securityNotes arg_css_class="warning"}
        {/if}
    	<ul class="nav nav-list">
			{* PLUGIN MANAGEMENT *}
            {if $display_left_block_top}
                {if isset($gui->plugins.EVENT_LEFTMENU_TOP)}
                    {foreach from=$gui->plugins.EVENT_LEFTMENU_TOP item=menu_item}
                    	<li id="button_plugin_top" onClick="activeButton(id)"> 
                        	<a href="{$menu_item['href']}" target="mainframe">
                        		<i class="menu-icon fa fa-dashboard"></i>
                        		<span class="menu-text-shown">{$menu_item['label']}</span>
                        	</a>
                    		<b class="arrow"></b>
                		</li>
                    {/foreach}
                {/if}
                <br/>
            {/if}	
    		{if $gui->testprojectID}
    		
    			<!-- BUTTON ADMIN -->
    			{$href=""}
        		{if $gui->grants.events_mgt eq "yes" && $gui->grants.mgt_view_events eq "yes"}
              		{$href=$gui->href['eventviewer']}
                {elseif $gui->grants.mgt_plugins eq "yes"}
              		{$href=$gui->href['pluginView']}
                {/if}
                {if $href neq ""}
            		<li id="button_admin" onClick="activeButton(id)"> 
                    	<a href="{$href}" target="mainframe">
                        	<i class="menu-icon fa fa-dashboard"></i>
                        	<span class="menu-text-shown">{$labels.admin_button}</span>
                    	</a>
                    	<b class="arrow"></b>
                	</li>
            	{/if}
    		
                <!-- BUTTON SYSTEM -->
    			{$href=""}
        		{if $gui->grants.cfield_management eq "yes"}
              		{$href=$gui->href['cfieldsView']}
                {elseif $gui->grants.issuetracker_management eq "yes" || $gui->grants.issuetracker_view eq "yes"}
              		{$href=$gui->href['issueTrackerView']}
                {elseif $gui->grants.codetracker_management eq "yes" || $gui->grants.codetracker_view eq "yes"}
              		{$href=$gui->href['codeTrackerView']}
                {/if}
                {if $href neq ""}
            		<li id="button_system" onClick="activeButton(id)"> 
                    	<a href="{$href}" target="mainframe">
                        	<i class="menu-icon fa fa-dashboard"></i>
                        	<span class="menu-text-shown">{$labels.system_config}</span>
                    	</a>
                    	<b class="arrow"></b>
                	</li>
            	{/if}    	
        	
        		<!-- BUTTON PROJECTS -->
    			{$href=""}
        		{if $gui->grants.project_edit eq "yes"}
              		{$href=$gui->href['projectView']}
                {elseif $gui->grants.tproject_user_role_assignment eq "yes"}
              		{$href=$gui->href['usersAssign']|cat:$gui->testprojectID}
                {elseif $gui->grants.cfield_management eq "yes"}
              		{$href=$gui->href['cfAssignment']}
                {elseif $gui->grants.keywords_view eq "yes"}
              		{$href=$gui->href['keywordsAssignment']|cat:$gui->testprojectID}
                {elseif $gui->grants.platform_management eq "yes" || $gui->grants.platform_view eq "yes"}
              		{$href=$gui->href['platformsView']}
                {elseif $gui->grants.project_inventory_view eq "yes" || $gui->grants.project_inventory_management eq "yes"}
              		{$href=$gui->href['inventoryView']}
                {/if}
                {if $href neq ""}
            		<li id="button_projects" onClick="activeButton(id)"> 
                    	<a href="{$href}" target="mainframe">
                        	<i class="menu-icon fa fa-dashboard"></i>
                        	<span class="menu-text-shown">{$labels.title_product_mgmt}</span>
                    	</a>
                    	<b class="arrow"></b>
                	</li>
            	{/if}
            	
            	<!-- BUTTON REQ -->
            	{$href=""}
        		{if $gui->grants.reqs_view eq "yes" || $gui->grants.reqs_edit eq "yes"}
              		{$href=$gui->launcher|cat:"?feature=reqSpecMgmt"}
                {elseif $gui->grants.req_tcase_link_management eq "yes"}
              		{$href=$gui->href['assignReq']}
                {elseif $gui->grants.monitor_req eq "yes"}
              		{$href=$gui->href['reqMonOverView']|cat:$gui->testprojectID}
                {/if}
                {if $href neq ""}
            		<li id="button_req" onClick="activeButton(id)"> 
                    	<a href="{$href}" target="mainframe">
                        	<i class="menu-icon fa fa-dashboard"></i>
                        	<span class="menu-text-shown">{$labels.title_requirements}</span>
                    	</a>
                    	<b class="arrow"></b>
                	</li>
            	{/if}
            	
            	<!-- BUTTON TC -->
            	{$href=""}
        		{if $gui->grants.view_tc eq "yes"}
              		{$href=$gui->launcher|cat:"?feature=editTc"}
                {elseif $gui->hasTestCases eq "yes"}
              		{$href=$gui->href['tcSearch']|cat:$gui->testprojectID}
                {elseif $gui->hasKeywords eq "yes" && $gui->grants.keyword_assignment eq "yes"}
              		{$href=$gui->launcher|cat:"?feature=keywordsAssign"}
                {elseif $gui->grants.modify_tc eq "yes"}
              		{$href=$gui->href['tcCreatedUser']|cat:$gui->testprojectID}
                {/if}
                {if $href neq ""}
            		<li id="button_tc" onClick="activeButton(id)"> 
                    	<a href="{$href}" target="mainframe">
                        	<i class="menu-icon fa fa-dashboard"></i>
                        	<span class="menu-text-shown">{$labels.title_test_spec}</span>
                    	</a>
                    	<b class="arrow"></b>
                	</li>
            	{/if}
            	
        	{/if}
        	
        	<br>
        	
        	<!-- BUTTON PLAN -->
        	{$href=""}
        	{if $gui->grants.mgt_testplan_create eq "yes"}
          		{$href=$gui->href['planView']}
            {elseif $gui->grants.testplan_create_build eq "yes" && $gui->countPlans > 0}
          		{$href=$gui->href['buildView']|cat:$gui->testplanID}
            {elseif $href neq "" && $gui->grants.testplan_milestone_overview eq "yes" && $gui->countPlans > 0}
          		{$href=$gui->href['mileView']}
            {/if}
            {if $href neq ""}
        		<li id="button_plan" onClick="activeButton(id)"> 
                	<a href="{$href}" target="mainframe">
                    	<i class="menu-icon fa fa-dashboard"></i>
                    	<span class="menu-text-shown">{$labels.title_test_plan_mgmt}</span>
                	</a>
                	<b class="arrow"></b>
            	</li>
        	{/if}
        	
        	{if $gui->countPlans}
        	
            	<!-- BUTTON EXEC -->
            	{$href=""}
            	{if $gui->grants.testplan_execute eq "yes" || $gui->grants.exec_ro_access eq "yes"}
              		{$href=$gui->launcher|cat:"?feature=executeTest"}
                {elseif $gui->grants.exec_testcases_assigned_to_me eq "yes"}
              		{$href=$gui->url.testcase_assignments}
                {elseif $gui->grants.testplan_metrics eq "yes"}
              		{$href=$gui->launcher|cat:"?feature=showMetrics"}
                {/if}
                {if $href neq ""}
            		<li id="button_exec" onClick="activeButton(id)"> 
                    	<a href="{$href}" target="mainframe">
                        	<i class="menu-icon fa fa-dashboard"></i>
                        	<span class="menu-text-shown">{$labels.title_test_execution}</span>
                    	</a>
                    	<b class="arrow"></b>
                	</li>
            	{/if} 
            	
            	{if $gui->grants.testplan_planning eq "yes"}
            	
                	<!-- BUTTON PLAN CONTENT -->
                	{$href=""}
                	{if $gui->grants.testplan_add_remove_platforms eq "yes"}
                  		{$href=$gui->href['platformAssign']|cat:$gui->testplanID}
                    {else}
                  		{$href=$gui->launcher|cat:"?feature=planAddTC"}
                    {/if}
                    {if $href neq ""}
                		<li id="button_plan_content" onClick="activeButton(id)"> 
                        	<a href="{$href}" target="mainframe">
                            	<i class="menu-icon fa fa-dashboard"></i>
                            	<span class="menu-text-shown">{$labels.title_test_case_suite}</span>
                        	</a>
                        	<b class="arrow"></b>
                    	</li>
                	{/if} 	
        		{/if}
        	{/if}
        	
        	{* PLUGIN MANAGEMENT *} 
            {if $display_left_block_bottom}
                {if isset($gui->plugins.EVENT_LEFTMENU_BOTTOM)}
					<br/>
                    {foreach from=$gui->plugins.EVENT_LEFTMENU_BOTTOM item=menu_item}
						<li id="button_plugin_bottom" onClick="activeButton(id)"> 
                        	<a href="{$menu_item['href']}" target="mainframe">
                        		<i class="menu-icon fa fa-dashboard"></i>
                        		<span class="menu-text-shown">{$menu_item['label']}</span>
                        	</a>
                    		<b class="arrow"></b>
                		</li>
                    {/foreach}
                {/if}  
            {/if}
    	</ul>
    	<div id="sidebar-btn" class="sidebar-toggle sidebar-collapse">
    		<i id="collapse_btn" class="ace-icon fa fa-angle-double-left"></i>
    	</div>
    </div>
<!--     {lang_get var="lbl_f" s="poweredBy,system_descr"} -->
<!--     <strong>{$lbl_f.poweredBy|escape} <a href="{$tlCfg->testlinkdotorg}" title="{$lbl_f.system_descr|escape}">TestLink {$tlVersion|escape}</a></strong> -->
   	<iframe src="" name="mainframe" class="mainPage" ></iframe>
    </body>
    <script type="text/javascript" src="{$basehref}gui/javascript/main_menu.js"></script>
</html>