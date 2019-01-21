{*
 * TestLink Open Source Project - http://testlink.sourceforge.net/
 * $Id: inc_tree_control.tpl,v 1.1.2.3 2010/11/22 09:46:26 asimon83 Exp $
 *
 * Shows some buttons which perform actions on the displayed tree.
 * Is included from filter panel template.
 *
 * @author Andreas Simon
 * @internal revisions
 *}

{lang_get var=labels s='expand_tree, collapse_tree, show_whole_spec_on_right_panel'}


<div class="widget-body">
	<div class="widget-header">
	    <h4 class="widget-title">
	    	<span class="glyphicon glyphicon-folder-open"></span>
	    	{$gui->tree_title}
	    </h4>
	</div>
	  
	  <div id="tree" class="collapse in" >
	  	<div class="btn-toolbar">
		  	<div class="btn-group-left">
		  		<input type="submit" value="{$labels.expand_tree}" id="expand_tree" name="expand_tree" 
       				onclick="tree.expandAll();" class="btn btn-primary btn-white btn-round"/>
			
				<input type="submit" value="{$labels.collapse_tree}" id="collapse_tree" name="collapse_tree" 
       				onclick="tree.collapseAll();" class="btn btn-primary btn-white btn-round"/>

				<input type="submit" value="{$labels.show_whole_spec_on_right_panel}" id="show_whole_test_spec" name="show_whole_test_spec" 
       				onclick="javascript:ETS({$gui->ajaxTree->root_node->id});" class="btn btn-primary btn-white btn-round"/>
		  	</div>
	  	</div>
		<div id="tree_div"></div>
	  </div>
</div>
