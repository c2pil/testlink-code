<html>
    <head>
        <base href="{$basehref}"/>
        <style media="all" type="text/css">@import "{$css}";</style>
    </head>
    <body>
        {if $gui->securityNotes}
        	{include file="inc_msg_from_array.tpl" array_of_msg=$gui->securityNotes arg_css_class="warning"}
        {/if}
    </body>
    <footer>
    	{$printFooter}
    </footer>
</html>