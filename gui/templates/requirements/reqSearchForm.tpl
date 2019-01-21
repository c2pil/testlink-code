{* 
TestLink Open Source Project - http://testlink.sourceforge.net/
@filesource	reqSearchForm.tpl
Form for requirement search.

@internal revisions

*}

{assign var="cfg_section" value=$smarty.template|basename|replace:".tpl":"" }
{config_load file="input_dimensions.conf" section=$cfg_section}

{lang_get var="labels" 
          s='title_search_req, custom_field, search_type_like,
             custom_field_value,btn_apply_filter,requirement_document_id, req_expected_coverage,
             title_search_req, reqid, reqversion, caption_search_form_req, title, scope,
             coverage, status, type, version, th_tcid, has_relation_type,
             modification_date_from,modification_date_to,creation_date_from,creation_date_to,
             show_calender,clear_date,log_message,'}

{* not include prototypeJs because bootstrap doesn't work with this *}
{include file="inc_head.tpl" openHead="yes" jsValidate="yes" prototypeJs="false"}

{include file='bootstrap.inc.tpl'}
{include file='bootstrap-datepicker.inc.tpl'}

<link rel="stylesheet" href="{$basehref}gui/themes/default/css/tl_control_panel.css">
</head>
<body>

<h1 class="title">{$gui->mainCaption|escape}</h1>

<div class="widget-body">
<form method="post" action="{$basehref}lib/requirements/reqSearch.php" target="workframe">
	<div class="widget-header">
	    <h4 class="widget-title">
	    	<span class="glyphicon glyphicon-search"></span>
	    	{$labels.title_search_req}
	    </h4>
	</div>
	
	<div id="filters" class="widget-main collapse in" >
		<div class="btn-toolbar">
		  	<div class="btn-group-left">
				<input type="submit" class="btn btn-primary btn-round btn-white" name="doSearch" value="{$labels.btn_apply_filter}" />
			</div>
		</div>
		<table class="table table-bordered">
			
			<tr>
				<td class="category">{$labels.requirement_document_id}</td>
				<td>
					<input class="form-control" placeholder="{$labels.requirement_document_id}" type="text" name="requirement_document_id" size="{#REQDOCID_SIZE#}" maxlength="{#REQDOCID_MAXLEN#}" />
				</td>
			</tr>
			
			<tr>
				<td class="category">{$labels.version}</td>
				<td><input type="text" name="version"  class="form-control" placeholder="{$labels.version}"
				           size="{#VERSION_SIZE#}" maxlength="{#VERSION_MAXLEN#}" /></td>
			</tr>
			
			<tr>
				<td class="category">{$labels.title}</td>
				<td><input type="text" class="form-control" placeholder="{$labels.title}" name="name" size="{#REQNAME_SIZE#}" maxlength="{#REQNAME_MAXLEN#}" /></td>
			</tr>
			
			<tr>
				<td class="category">{$labels.scope}</td>
				<td><input type="text" name="scope" 
				           size="{#SCOPE_SIZE#}" class="form-control" placeholder="{$labels.scope}" maxlength="{#SCOPE_MAXLEN#}" /></td>
			</tr>
			
			<tr>
				<td class="category">{$labels.status}</td>
	     		<td><select name="reqStatus" class="form-control">
	     		<option value="">&nbsp;</option>
	  			{html_options options=$gui->reqStatus}
	  			</select></td>
	  		</tr>
			
			<tr>
				<td class="category">{$labels.type}</td>
				<td>
					<select name="reqType" id="reqType" class="form-control">
						<option value="">&nbsp;</option>
	  					{html_options options=$gui->types}
	  				</select>
	  			</td>
			</tr>
		
			{if $gui->filter_by.expected_coverage}
				<tr>
					<td class="category">{$labels.req_expected_coverage}</td>
					<td><input class="form-control" placeholder="{$labels.req_expected_coverage}" type="text" name="coverage" size="{#COVERAGE_SIZE#}" maxlength="{#COVERAGE_MAXLEN#}" /></td>
				</tr>
			{/if}		
			
			{if $gui->filter_by.relation_type}
				<tr>
					<td class="category">{$labels.has_relation_type}</td>
					<td>
						<select id="relation_type" name="relation_type" class="form-control">
							<option value="">&nbsp;</option>
							{html_options options=$gui->req_relation_select.items}
						</select>
					</td>				
				</tr>
			{/if}
			
			<tr>
				<td class="category">{$labels.creation_date_from}</td>
				<td>
					<div class="input-group date myDatepicker" data-date-format="dd/mm/yyyy">
						 <input type="text" class="form-control"
		                       name="creation_date_from" id="creation_date_from" 
						       value="{$gui->creation_date_from}"  />
					      <div class="input-group-addon">
					       	<span class="glyphicon glyphicon-calendar"></span>
					      </div>
					</div>
			  </td>
			</tr>
			<tr>
				<td class="category">{$labels.creation_date_to}</td>
				<td>
					<div class="input-group date myDatepicker" data-date-format="dd/mm/yyyy">
						 <input type="text" class="form-control"
		                       name="creation_date_to" id="creation_date_to" 
						       value="{$gui->creation_date_to}"  />
					      <div class="input-group-addon">
					       	<span class="glyphicon glyphicon-calendar"></span>
					      </div>
					</div>
			  </td>
			</tr>
			
			<tr>
				<td class="category">{$labels.modification_date_from}</td>
				<td>
					<div class="input-group date myDatepicker" data-date-format="dd/mm/yyyy">
						 <input type="text" class="form-control"
		                       name="modification_date_from" id="modification_date_from" 
						       value="{$gui->modification_date_from}"  />
					      <div class="input-group-addon">
					       	<span class="glyphicon glyphicon-calendar"></span>
					      </div>
					</div>
			  </td>
			</tr>
			<tr>
				<td class="category">{$labels.modification_date_to}</td>
				<td>
					<div class="input-group date myDatepicker" data-date-format="dd/mm/yyyy">
						 <input type="text" class="form-control"
		                       name="modification_date_to" id="modification_date_to" 
						       value="{$gui->modification_date_to}"  />
					      <div class="input-group-addon">
					       	<span class="glyphicon glyphicon-calendar"></span>
					      </div>
					</div>
			  </td>
			</tr>
			<tr>
				<td class="category">{$labels.th_tcid}</td>
				<td><input type="text" name="tcid" value="{$gui->tcasePrefix}"  class="form-control" placeholder="{$labels.th_tcid}"
				           size="{#TC_ID_SIZE#}" maxlength="{#TC_ID_MAXLEN#}" /></td>
			</tr>
			<tr>
				<td class="category">{$labels.log_message}</td>
				<td><input type="text" name="log_message" id="log_message"  class="form-control" placeholder="{$labels.log_message}"
						   size="{#LOGMSG_SIZE#}" maxlength="{#LOGMSG_MAXLEN#}" /></td>
			</tr>
		
			{if $gui->filter_by.design_scope_custom_fields}
			    <tr>
	   	    		<td class="category">{$labels.custom_field}</td>
			    	<td><select name="custom_field_id" class="form-control">
			    			<option value="0">&nbsp;</option>
			    			{foreach from=$gui->design_cf key=cf_id item=cf}
			    				<option value="{$cf_id}">{$cf.label|escape}</option>
			    			{/foreach}
			    		</select>
			    	</td>
		      	</tr>
			    <tr>
		       		<td class="category">{$labels.custom_field_value}</td>
	         		<td>
			    		<input type="text" name="custom_field_value" class="form-control" placeholder="{$labels.custom_field_value}"
			    	         size="{#CFVALUE_SIZE#}" maxlength="{#CFVALUE_MAXLEN#}"/>
			    	</td>
		      </tr>
		  {/if}
		</table>
	
	</div>
	
</form>

</div>
</body>
<script>
jQuery(document).ready(function() {
	
	jQuery('.myDatepicker').datepicker({
		autoclose : true,
		orientation: "auto top",
		todayBtn : "linked"
	});
});

</script>
</html>
