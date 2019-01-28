<html>
    	{include file="inc_head.tpl" openHead="yes" prototypeJs="no"}
        <base href="{$basehref}"/>
        <style media="all" type="text/css">@import "{$css}";</style>
        
    </head>
    <body>
        {if $gui->securityNotes}
        	{include file="inc_msg_from_array.tpl" array_of_msg=$gui->securityNotes arg_css_class="warning"}
        {/if}
        
        <div class="col-md-offset-3 col-md-6 col-sm-10 col-sm-offset-1">
        	<div class="widget-body">
        		<div class="widget-main">
            		<h4 class="header lighter bigger">{$testprojectPrefix} : {$testprojectName}</h4>
            		<div class="space-10"></div>
            				
            		{$testprojectNotes}
            
        			<div class="form-border">
            			{$testplanName}
        			</div>
        		</div>
    		</div>
        </div>
        
    </body>
    <footer>
    	{$printFooter}
    </footer>
</html>