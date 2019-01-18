{*
Testlink Open Source Project - http://testlink.sourceforge.net/

title bar + menu

@filesource navBar.tpl
*}
{lang_get var="labels"
          s="title_events,event_viewer,home,testproject,title_specification,title_execute,
             title_edit_personal_data,th_tcid,link_logout,title_admin,
             search_testcase,title_results,title_user_mgmt,full_text_search"}
{$cfg_section=$smarty.template|replace:".tpl":""}
{config_load file="input_dimensions.conf" section=$cfg_section}

<head>
<base href="{$basehref}"/>

{include file="inc_head.tpl"}
{include file="bootstrap.inc.tpl"}

<link rel="stylesheet" href="{$basehref}gui/themes/default/css/navbar.css" >
</head>
<body class="skin-3">

<div id="navbar" class="navbar navbar-default navbar-collapse navbar-fixed-top noprint">
	<div class="navbar-container">
		<div class="navbar-header">
			 <a class="navbar-brand" href="index.php" target="_parent">
  				<span><img alt="Company logo" title="logo" src="{$smarty.const.TL_THEME_IMG_DIR}{$tlCfg->logo_navbar}" />TestLink</span> 
  			</a>
		</div>
	
		<div class="navbar-buttons navbar-header navbar-collapse collapse">
			<ul class="nav ace-nav">
				{$session.testprojectTopMenu}
				<li>
					<span class="info">{$labels.testproject}</span>
				    <form style="display:inline;"name="productForm" action="lib/general/navBar.php?viewer={$gui->viewer}" method="get">
				      <span class="navButton">
					      <select name="testproject" onchange="this.form.submit();" class="input-sm">
					          {foreach key=tproject_id item=tproject_name from=$gui->TestProjects}
					          <option value="{$tproject_id}" title="{$tproject_name|escape}"
					            {if $tproject_id == $gui->tprojectID} selected="selected" {/if}>
					            {$tproject_name|truncate:#TESTPROJECT_TRUNCATE_SIZE#|escape}
					          </option>
					        {/foreach}
					      </select>
				      </span>
				    </form>
				</li>
				<li>
					<span class="info">{$gui->whoami|escape}</span>
					<span class="navButton">
						<a href='lib/usermanagement/userInfo.php' target="mainframe">
							<img src="{$tlImages.account}" title="{$labels.title_edit_personal_data}"/>
						</a>
				        <a href="{$gui->logout}" target="_parent">
			        		<img src="{$tlImages.logout}" title="{$labels.link_logout}"/>
			        	</a>
			          </span>
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
  
{if $gui->updateMainPage == 1}
  <script type="text/javascript">
  parent.mainMenu.location.reload();
  parent.mainframe.location.reload();
  </script>
{/if}

</body>
</html>