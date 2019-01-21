{* 
TestLink Open Source Project - http://testlink.sourceforge.net/ 
@filesource cfieldsTprojectAssign.tpl
Purpose: management Custom fields assignment to a test project

*}
{include file="inc_head.tpl" openHead="yes"}
{include file="inc_jsCheckboxes.tpl"}
{include file="bootstrap.inc.tpl"}
</head>

{$print_tabs}

{lang_get var="labels" 
          s='name,label,display_order,location,cfields_active,testproject,btn_assign,
             cfields_tproject_assign,title_assigned_cfields,check_uncheck_all_checkboxes,
             available_on,type,required,
             manage_cfield,btn_unassign,btn_cfields_boolean_mgmt,btn_cfields_display_order,
             btn_cfields_display_attr,title_available_cfields,monitorable'}

<body>
{$cfg_section=$smarty.template|basename|replace:".tpl":""}
{config_load file="input_dimensions.conf" section=$cfg_section}

<h1 class="title">
{$labels.cfields_tproject_assign}{$smarty.const.TITLE_SEP_TYPE2}{$labels.testproject}{$smarty.const.TITLE_SEP}{$gui->tproject_name|escape}
</h1>

{include file="inc_update.tpl" result=$sqlResult action=$action item="custom_field"}


{if $gui->linkedCF ne ""}
<div>
	<h2>{$labels.title_assigned_cfields}</h2>
	<form method="post">
		<div id="assigned_cf"> 
			{* used as memory for the check/uncheck all checkbox javascript logic *}
			<input type="hidden" name="memory_assigned_cf" id="memory_assigned_cf"  value="0" />
			<table class="table table-striped table-bordered sortable">
				<thead class="thead-dark">
					<tr>
						<th class="{$noSortableColumnClass} clickable_icon" width="3%"> 
							<img src="{$tlImages.toggle_all}"
              		             onclick='cs_all_checkbox_in_div("assigned_cf","assigned_cfield","memory_assigned_cf");'
              		             title="{$labels.check_uncheck_all_checkboxes}" />
						</th>
                  		<th width="20%">{$labels.name}</th>
                  		<th width="20%">{$labels.label}</th>
                  		<th>{$labels.type}</th>
                  		<th width="20%">{$labels.available_on}</th>
                  		<th width="5%">{$labels.display_order}</th>
                  		<th width="15%">{$labels.location}</th>
                  		<th width="5%">{$labels.cfields_active}</th>
                        <th width="5%">{$labels.required}</th>
                        <th width="5%">{$labels.monitorable}</th>
					</tr>
				</thead>
				<tbody>
					{foreach key=cf_id item=cf from=$gui->linkedCF}
					<tr>
                  		<td class="clickable_icon"><input type="checkbox" id="assigned_cfield{$cf.id}" name="checkedCF[{$cf.id}]" /></td>
               		   	<td class="bold"><a href="lib/cfields/cfieldsEdit.php?do_action=edit&amp;cfield_id={$cf.id}"
               		   	                    title="{$labels.manage_cfield}">{$cf.name|escape}</a></td>
                  		<td class="bold">{$cf.label|escape}</td>
                  		<td class="bold">{$gui->cf_available_types[$cf.type]|escape}</td>
                  		<td class="bold">{$gui->cf_allowed_nodes[$cf.node_type_id]|escape}</td>
                  		<td><input type="text" name="display_order[{$cf.id}]" 
                  		           value="{$cf.display_order}" 
                  		           size="{#DISPLAY_ORDER_SIZE#}" maxlength="{#DISPLAY_ORDER_MAXLEN#}" /></td>        
                  		<td>
                  		{* location will NOT apply to EXEC only CF *}
                  		{if $cf.node_description == 'testcase' && $cf.enable_on_execution ==0}
            			  	<select name="location[{$cf.id}]">
            			  	  {html_options options=$gui->locations selected=$cf.location}
            			  	</select>
                  		{else}
                  			&nbsp;
                  		{/if}
                  		</td>
  						<td>
  							<input type="checkbox" name="active_cfield[{$cf.id}]" {if $cf.active eq 1} checked="checked" {/if} /> 
  		    				<input type="hidden" name="hidden_active_cfield[{$cf.id}]"  value="{$cf.active}" /> 
  						</td>
      					<td>
      						<input type="checkbox" name="required_cfield[{$cf.id}]" {if $cf.required eq 1} checked="checked" {/if} /> 
          					<input type="hidden" name="hidden_required_cfield[{$cf.id}]"  value="{$cf.required}" /> 
      					</td>
      					<td>
      						<input type="checkbox" name="monitorable_cfield[{$cf.id}]" {if $cf.monitorable eq 1} checked="checked" {/if} /> 
          					<input type="hidden" name="hidden_monitorable_cfield[{$cf.id}]"  value="{$cf.monitorable}" /> 
      					</td>
  					</tr>
  					{/foreach}
				</tbody>
  			</table>
		</div>
		<div class="groupBtn">
    		<input type="hidden" name="doAction" value="" />
    		<input class="btn btn-primary btn-white btn-round" type="submit" name="doUnassign" value="{$labels.btn_unassign}" onclick="doAction.value=this.name"/>                     
    		<input class="btn btn-primary btn-white btn-round" type="submit" name="doBooleanMgmt" value="{$labels.btn_cfields_boolean_mgmt}" onclick="doAction.value=this.name"/>
    		<input class="btn btn-primary btn-white btn-round" type="submit" name="doReorder" value="{$labels.btn_cfields_display_attr}" onclick="doAction.value=this.name"/>
		</div>
    </form>
</div>
{/if}

{if $gui->other_cf ne ""}
<div>
	<h2>{$labels.title_available_cfields}</h2>
	<form method="post">
		<div id="free_cf"> 
			{* used as memory for the check/uncheck all checkbox javascript logic *}
			<input type="hidden" name="memory_free_cf" id="memory_free_cf"  value="0" />
			<table class="table table-striped table-bordered sortable">
				<thead class="thead-dark">
    				<tr>
          				<th width="3%" class="clickable_icon"> 
    	    				<img src="{$tlImages.toggle_all}"
              		             onclick='cs_all_checkbox_in_div("free_cf","free_cfield","memory_free_cf");'
              		             title="{$labels.check_uncheck_all_checkboxes}" />
    					</th>
                  		<th>{$labels.name}</th>
                  		<th>{$labels.label}</th>
                  		<th>{$labels.type}</th>
                  		<th>{$labels.available_on}</th>
          			</tr>
      			</thead>
      			<tbody>
          			{foreach key=cf_id item=cf from=$gui->other_cf}
          			<tr>
                  		<td class="clickable_icon"> <input type="checkbox" id="free_cfield{$cf.id}" name="checkedCF[{$cf.id}]" /></td>
                  		<td class="bold"><a href="lib/cfields/cfieldsEdit.php?do_action=edit&amp;cfield_id={$cf.id}"
               		   	                    title="{$labels.manage_cfield}">{$cf.name|escape}</a></td>
                  		<td class="bold">{$cf.label|escape}</td>
                  		<td class="bold">{$gui->cf_available_types[$cf.type]|escape}</td>
                  		<td class="bold">{$gui->cf_allowed_nodes[$cf.node_type_id]|escape}</td>
                  	</tr>
          			{/foreach}
      			</tbody>
  			</table>
		</div>
		<div class="groupBtn">
    		<input type="hidden" name="doAction" value="" />
			<input class="btn btn-primary btn-white btn-round" type="submit" name="doAssign" id=this.name value="{$labels.btn_assign}" onclick="doAction.value=this.name"/>
		</div>
	</form>
</div>
{/if}

</body>
</html>