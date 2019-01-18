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



{include file="inc_head.tpl" openHead="yes"}
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
	
		<div class="navbar-buttons navbar-header navbar-collapse collapse">
			<ul class="nav ace-nav">
				{$session.testprojectTopMenu}
				<li id="dropdown_projet" class="grey">
					<a  class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">{$labels.testproject}<i class="ace-icon fa fa-angle-down bigger-110"></i></a>
						
						<ul class="dropdown-menu dropdown-menu-right dropdown-caret dropdown-close scrollable-menu" style="z-index:100000; position:absolute">
							<li>
							<a href="lib/general/navBar.php?viewer={$gui->viewer}&testproject=">test</a>
							</li>
							<li>
							<a class="active" href="lib/general/navBar.php?viewer={$gui->viewer}&testproject=">coucou</a>
							</li>
						</ul>
					  					 
				    
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


<iframe src="{$gui->menuframe}" name="mainMenu" class="mainMenu" ></iframe>  

{if $gui->updateMainPage == 1}
  <script type="text/javascript">
  window.mainMenu.location.reload();
  window.mainframe.location.reload();
  </script>
{/if}

</body>

</html>