{* 
 Testlink Open Source Project - http://testlink.sourceforge.net/ 
 @filesource  mainPage.tpl 
 Purpose: smarty template - main page / site map                 
*}
{$cfg_section=$smarty.template|replace:".tpl":""}
{config_load file="input_dimensions.conf" section=$cfg_section}
{include file="inc_head.tpl" popup="yes" openHead="yes"}

{include file="inc_ext_js.tpl"}
{include file="bootstrap.inc.tpl"}

<script src="{$basehref}gui/niftycube/niftycube.js" type="text/javascript"></script>
</head>

<body class="testlink">
{if $gui->securityNotes}
  {include file="inc_msg_from_array.tpl" array_of_msg=$gui->securityNotes arg_css_class="warning"}
{/if}

{* ----- Right Column ------------- *}
{*  {include file="mainPageRight.tpl"} *}

{* ----- Left Column -------------- *}
{include file="mainPageLeft.tpl"}

</body>
</html>