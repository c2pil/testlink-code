{*
Testlink Open Source Project - http://testlink.sourceforge.net/

title bar + menu

@filesource navBar.tpl
*}
{lang_get var="labels"
          s="current_test_plan,title_events,event_viewer,home,testproject,title_specification,title_execute,
             title_edit_personal_data,th_tcid,link_logout,title_admin,
             search_testcase,title_results,title_user_mgmt,full_text_search"}
{$cfg_section=$smarty.template|replace:".tpl":""}
{config_load file="input_dimensions.conf" section=$cfg_section}



{include file="inc_head.tpl" openHead="yes" prototypeJs="false"}
<base href="{$basehref}"/>
{include file="bootstrap.inc.tpl"}

<link rel="stylesheet" href="{$basehref}gui/themes/default/css/navbar.css" >
</head>


<body class="skin-3">

<div id="navbar" class="navbar navbar-default navbar-collapse  noprint">
	<div class="navbar-container">
		<div class="navbar-header">
			 <a class="navbar-brand" href="index.php" target="_parent">
  				<span><img alt="Company logo" title="logo" src="{$smarty.const.TL_THEME_IMG_DIR}{$tlCfg->logo_navbar}" />TestLink</span> 
  			</a>
		</div>
	
		<div class="navbar-buttons navbar-header">
			<ul class="nav ace-nav">
				<li id="dropdown_projet" class="grey">
					<a  class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
						{$labels.testproject} {$gui->TestProjects[$gui->tproject_id]}
						<i class="ace-icon fa fa-angle-down bigger-110"></i>
					</a>
						
					<ul class="dropdown-menu dropdown-menu-right dropdown-caret dropdown-close scrollable-menu">
						{foreach key=tproject_id item=tproject_name from=$gui->TestProjects}
					        	<li {if $tproject_id == $gui->tprojectID} class="active" {/if}>
									<a href="lib/general/navBar.php?viewer={$gui->viewer}&testproject={$tproject_id}">
										{$tproject_name|truncate:#TESTPROJECT_TRUNCATE_SIZE#|escape}
									</a>
								</li>
						{/foreach}
					</ul>
				</li>

				{if $gui->num_active_tplans > 0}
    				<li id="dropdown_plans" class="grey">
    					{if $gui->TestPlanCount > 0}
    					<a  class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
							{$labels.current_test_plan} {$gui->planSelectName}
							<i class="ace-icon fa fa-angle-down bigger-110"></i>
						</a>
    				
    					<ul class="dropdown-menu dropdown-menu-right dropdown-caret dropdown-close scrollable-menu">
    						{foreach key=index item=tPlans from=$gui->arrPlans}
					        	<li {if $tPlans.selected} class="active" {/if}>
									<a href="lib/general/navBar.php?testplan={$tPlans.id}">{$tPlans.name|escape}</a>
								</li>
							{/foreach}
							{if $gui->testplanRole neq null}
		                    	{$labels.testplan_role} {$gui->testplanRole|escape}
		                    {/if}
    					</ul>
    					{else}
		                	{if $gui->num_active_tplans > 0}{$labels.msg_no_rights_for_tp}{/if}
    					{/if}		            	
	            	</li>
			    {/if}

				<li class="grey">
					<a  class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
						<i class="ace-icon fa fa-user fa-2x white"></i>
						<span>{$gui->whoami|escape}</span>
						<i class="ace-icon fa fa-angle-down bigger-110"></i>
					</a>
					
					<ul class="dropdown-menu dropdown-menu-right dropdown-caret dropdown-close scrollable-menu">
						<li>
							<a href='lib/usermanagement/userInfo.php' target="mainframe">
								<i class="ace-icon fa fa-user"></i>
								{$labels.title_edit_personal_data}
							</a>
						</li>
						<li>
							<a href="{$gui->logout}" target="_parent">
								<i class="ace-icon fa fa-sign-out"></i>	
								{$labels.link_logout}
							</a>
						</li>
					</ul>					
				</li>
				
				<li class="grey">
				
					<a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
						<i class="ace-icon fa fa-align-justify fa-2x white"></i>
					</a>
					
					<ul class="dropdown-menu dropdown-menu-right dropdown-caret dropdown-close scrollable-menu">
						{$session.testprojectTopMenu}
					</ul>
				</li>
			</ul>			
		</div>
	</div>

</div>

{if $gui->plugins.EVENT_TITLE_BAR}
	<div align="center" >
	{foreach from=$gui->plugins.EVENT_TITLE_BAR item=menu_item}
	  {$menu_item}
	{/foreach}
	</div>
{/if}


<iframe src="{$gui->menuframe}" name="mainMenu" class="mainMenu" ></iframe>  

{if $gui->updateMainPage == 1}
  <script type="text/javascript">
  	  
	  //window.mainMenu.location.reload();
	  //window.mainframe.location.reload();
  </script>
{/if}

</body>

</html>