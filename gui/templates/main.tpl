{* Testlink Open Source Project - http://testlink.sourceforge.net/ *}
{* @filesource main.tpl *}
{* Purpose: smarty template - main frame *}
{*******************************************************************}
<!DOCTYPE html>
<html>
    <head>
    	<meta http-equiv="Content-Type" content="text/html; charset={$pageCharset}" />
    	<meta http-equiv="Content-language" content="en" />
    	<meta name="generator" content="testlink" />
    	<meta name="author" content="TestLink Development Team" />
    	<meta name="copyright" content="TestLink Development Team" />
    	<meta name="robots" content="NOFOLLOW" />
    	<title>TestLink {$tlVersion|escape}</title>
    	<meta name="description" content="TestLink - {$gui->title|default:'Main page'}" />
    	<link rel="icon" href="{$basehref}{$smarty.const.TL_THEME_IMG_DIR}favicon.ico" type="image/x-icon" />
    	<link rel="stylesheet" type="text/css" href="{$basehref}gui/themes/default/css/homepage.css">
    </head>
    <body>
        <iframe src="{$gui->titleframe}" name="titlebar" class="navBar" ></iframe>
        <iframe src="{$gui->menuframe}" name="mainMenu" class="mainMenu" ></iframe>
        <iframe src="" name="mainframe" class="mainPage" ></iframe>
    </body>
</html>
