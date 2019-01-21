{* 
TestLink Open Source Project - http://testlink.sourceforge.net/
@filesource	reqSpecSearchForm.tpl
Form for searching through requirement specifications.

@internal revisions
*}

{assign var="cfg_section" value=$smarty.template|basename|replace:".tpl":"" }
{config_load file="input_dimensions.conf" section=$cfg_section}

{lang_get var="labels" 
          s='title_search_req,caption_search_form, custom_field, search_type_like,
             custom_field_value,btn_find,req_spec_document_id,log_message, 
             title_search_req_spec, reqid, reqversion, caption_search_form_req_spec,
             title, scope, coverage, status, type'}
{include file='bootstrap.inc.tpl'}

{include file="inc_head.tpl"}
<link rel="stylesheet" href="{$basehref}gui/themes/default/css/tl_control_panel.css">
<body>

<h1 class="title">{$gui->mainCaption|escape}</h1>

<div class="widget-body">
<form method="post" action="{$basehref}lib/requirements/reqSpecSearch.php" target="workframe">
	<div class="widget-header">
	    <h4 class="widget-title">
	    	<span class="glyphicon glyphicon-search"></span>
	    	{$labels.title_search_req}
	    </h4>
	</div>
	
	
	<div id="filters" class="widget-main collapse in" >
		<div class="btn-toolbar">
		  	<div class="btn-group-left">
				<input type="submit" class="btn btn-primary btn-round btn-white" name="doSearch" value="{$labels.btn_find}" />
			</div>
		</div>
		<table class="table table-bordered" >
			<tr>
				<td class="category">{$labels.req_spec_document_id}</td>
				<td><input type="text" class="form-control" placeholder="{$labels.req_spec_document_id}" name="requirement_document_id" size="{#REQSPECDOCID_SIZE#}" maxlength="{#REQSPECDOCID_MAXLEN#}" /></td>
			</tr>
			<tr>
				<td class="category">{$labels.title}</td>
				<td><input type="text" name="name" class="form-control" placeholder="{$labels.title}" size="{#REQSPECNAME_SIZE#}" maxlength="{#REQSPECNAME_MAXLEN#}" /></td>
			</tr>
			<tr>
				<td class="category">{$labels.scope}</td>
				<td><input type="text" name="scope" class="form-control" placeholder="{$labels.scope}"
				           size="{#SCOPE_SIZE#}" maxlength="{#SCOPE_MAXLEN#}" /></td>
			</tr>
			<tr>
				<td class="category">{$labels.type}</td>
				<td>
					<select name="reqSpecType" id="reqSpecType" class="form-control" >
						<option value="notype">&nbsp;</option>
	  					{html_options options=$gui->types}
	  				</select>
	  			</td>
			</tr>
			
			{if $gui->filter_by.design_scope_custom_fields}
			    <tr>
	   	    	<td class="category">{$labels.custom_field}</td>
			    	<td><select name="custom_field_id" class="form-control" >
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
			    		<input type="text" name="custom_field_value"  class="form-control"  placeholder="{$labels.custom_field_value}"
			    	         size="{#CFVALUE_SIZE#}" maxlength="{#CFVALUE_MAXLEN#}"/>
			    	</td>
		      </tr>
		  {/if}
			<tr>
				<td class="category">{$labels.log_message}</td>
				<td><input type="text" name="log_message" id="log_message" class="form-control" placeholder="{$labels.log_message}"
						   size="{#LOGMSG_SIZE#}" maxlength="{#LOGMSG_MAXLEN#}" /></td>
			</tr>      
		</table>
	
	</div>
</form>

</div>



</body>
</html>
