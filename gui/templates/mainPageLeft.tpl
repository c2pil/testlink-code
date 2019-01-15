{* 
 Testlink Open Source Project - http://testlink.sourceforge.net/ 
 @filesource  mainPageLeft.tpl
 Purpose: smarty template - main page / site map                 
                                                                 
 @internal revisions
*}
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
   href_codetracker_management,href_reqmgrsystem_management,href_req_monitor_overview'}

{* Show / Hide section logic *}
{$display_left_block_top = false}
{$display_left_block_bottom = false}

{if isset($gui->plugins.EVENT_LEFTMENU_TOP) &&  $gui->plugins.EVENT_LEFTMENU_TOP}
  {$display_left_block_top=true}
{/if}
{if isset($gui->plugins.EVENT_LEFTMENU_BOTTOM) &&  $gui->plugins.EVENT_LEFTMENU_BOTTOM}
  {$display_left_block_bottom=true}
{/if}

{$divStyle="width:300px;padding: 0px 0px 0px 10px;"}
{$aStyle="padding: 3px 15px;font-size:16px"}

<div class="sidebar compact">
	<ul class="nav nav-list">	
		{if $gui->testprojectID}
		
            <!-- BUTTON N°1 -->
			{$href=""}
    		{if $gui->grants.cfield_management eq "yes"}
          		{$href=$gui->href['cfieldsView']}
            {elseif $gui->grants.issuetracker_management eq "yes" || $gui->grants.issuetracker_view eq "yes"}
          		{$href=$gui->href['issueTrackerView']}
            {elseif $gui->grants.codetracker_management eq "yes" || $gui->grants.codetracker_view eq "yes"}
          		{$href=$gui->href['codeTrackerView']}
            {/if}
            {if $href neq ""}
        <!-- 	rajouter le system active  -->
        		<li class=""> 
                	<a href="{$href}" target="mainframe">
                    	<i class="menu-icon fa fa-dashboard"></i>
                    	<span class="menu-text">{$labels.system_config}</span>
                	</a>
                	<b class="arrow"></b>
            	</li>
        	{/if}    	
    	
    		<!-- BUTTON N°2 -->
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
        <!-- 	rajouter le system active  -->
        		<li> 
                	<a href="{$href}" target="mainframe">
                    	<i class="menu-icon fa fa-dashboard"></i>
                    	<span class="menu-text">{$labels.title_product_mgmt}</span>
                	</a>
                	<b class="arrow"></b>
            	</li>
        	{/if}
        	
        	<!-- BUTTON N°3 -->
        	{$href=""}
    		{if $gui->grants.reqs_view eq "yes" || $gui->grants.reqs_edit eq "yes"}
          		{$href=$gui->launcher|cat:"?feature=reqSpecMgmt"}
            {elseif $gui->grants.req_tcase_link_management eq "yes"}
          		{$href=$gui->href['assignReq']}
            {elseif $gui->grants.monitor_req eq "yes"}
          		{$href=$gui->href['reqMonOverView']|cat:$gui->testprojectID}
            {/if}
            {if $href neq ""}
        <!-- 	rajouter le system active  -->
        		<li> 
                	<a href="{$href}" target="mainframe">
                    	<i class="menu-icon fa fa-dashboard"></i>
                    	<span class="menu-text">{$labels.title_requirements}</span>
                	</a>
                	<b class="arrow"></b>
            	</li>
        	{/if}
        	
        	<!-- BUTTON N°4 -->
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
        <!-- 	rajouter le system active  -->
        		<li> 
                	<a href="{$href}" target="mainframe">
                    	<i class="menu-icon fa fa-dashboard"></i>
                    	<span class="menu-text">{$labels.title_test_spec}</span>
                	</a>
                	<b class="arrow"></b>
            	</li>
        	{/if}
        	
    	{/if}	
	</ul>
</div>

{* PLUGIN MANAGEMENT *}
<div class="vertical_menu" style="float: left; margin:0px 10px 10px 0px; width: 320px;">
  {if $display_left_block_top}
    {if isset($gui->plugins.EVENT_LEFTMENU_TOP)}
      <div class="list-group" style="{$divStyle}" id="plugin_left_top">
        {foreach from=$gui->plugins.EVENT_LEFTMENU_TOP item=menu_item}
		  <a href="{$menu_item['href']}" class="list-group-item" target="mainframe" style="{$aStyle}">{$menu_item['label']}</a>
          <br/>
        {/foreach}
      </div>
    {/if}
  {/if}

  {if $display_left_block_bottom}
    {if isset($gui->plugins.EVENT_LEFTMENU_BOTTOM)}
	  <br/>
	  <div class="list-group" style="{$divStyle}" id="plugin_left_bottom">
        {foreach from=$gui->plugins.EVENT_LEFTMENU_BOTTOM item=menu_item}
		  <a href="{$menu_item['href']}" class="list-group-item" target="mainframe" style="{$aStyle}">{$menu_item['label']}</a>
        {/foreach}
      </div>
    {/if}  
  {/if}
</div>