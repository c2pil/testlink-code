{*
 * TestLink Open Source Project - http://testlink.sourceforge.net/
 * $Id: inc_tree_control.tpl,v 1.1.2.3 2010/11/22 09:46:26 asimon83 Exp $
 *
 * Shows some buttons which perform actions on the displayed tree.
 * Is included from filter panel template.
 *
 * @author Andreas Simon
 * @internal revision
 *}

{lang_get var=labels s='expand_tree, collapse_tree'}



<div class="widget-body">
	<div class="widget-header">
	    <h4 class="widget-title">
	    	<span class="glyphicon glyphicon-folder-open"></span>
	    	{$gui->tree_title}
	    </h4>
	</div>
	  
	  <div id="tree" class="widget-main collapse in" >
	  	<div class="btn-toolbar">
		  	<div class="btn-group-left">
		  		<input type="submit" class="btn btn-primary btn-white btn-round"
			       value="{$labels.expand_tree}" 
			       id="expand_tree" 
			       name="expand_tree"
			       onclick="tree.expandAll();"/>
			
				<input type="submit" class="btn btn-primary btn-white btn-round"
				       value="{$labels.collapse_tree}"
				       id="collapse_tree"
				       name="collapse_tree"
				       onclick="tree.collapseAll();"/>
		  	</div>
	  	</div>
		<div id="tree_div"></div>
	  </div>
</div>

