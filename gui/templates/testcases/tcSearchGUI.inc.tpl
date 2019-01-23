{* 
TestLink Open Source Project - http://testlink.sourceforge.net/ 
@filesource tcSearchForm.tpl
Purpose: show form for search through test cases in test specification

@internal revisions
@since 1.9.13

*}
{$cfg_section=$smarty.template|basename|replace:".inc.tpl":""}
{config_load file="input_dimensions.conf" section=$cfg_section}
{include file='bootstrap.inc.tpl'}
{include file='bootstrap-datepicker.inc.tpl'}

<link rel="stylesheet" href="{$basehref}gui/themes/default/css/tl_control_panel.css">

{lang_get var="labels" 
          s='caption_search_form,th_tcid,th_tcversion,edited_by,status,
             th_title,summary,steps,expected_results,keyword,custom_field,created_by,jolly_hint,
             search_type_like,preconditions,filter_mode_and,test_importance,search_prefix_ignored,
             creation_date_from,creation_date_to,modification_date_from,modification_date_to,
             custom_field_value,btn_find,requirement_document_id,show_calender,clear_date,jolly'}


<div id="search-gui" class="widget-body">
<form method="post" action="{$basehref}lib/testcases/tcSearch.php">
  <input type="hidden" name="doAction" id="doAction" value="doSearch">
  <input type="hidden" name="tproject_id" id="tproject_id" value="{$gui->tproject_id}">
  
   <div class="widget-header">
     	<h4 class="widget-title">
     		<span class="glyphicon glyphicon-search"></span>
     		{$gui->pageTitle}
     	</h4>
     	
     	<div class="widget-toolbar">
     		<img src="{$tlImages.info}" title =" {$labels.filter_mode_and} {$gui->search_important_notice|escape}.
                                          {$labels.search_prefix_ignored|escape}">
     	</div>
    </div>
  
   <div class="btn-toolbar">
   		<div class="btn-group-left">
			<input type="submit" name="doSearch" class="btn btn-primary btn-round btn-white" value="{$labels.btn_find}" />
		</div>
	</div>
  
  <table class="table table-bordered">
  
    <tr>
      <td class="small-category">{$labels.th_tcid}</td>
      <td class="small-category">{$labels.th_tcversion}</td>
      
       {if $session['testprojectOptions']->testPriorityEnabled}
       	<td class="small-category">{$labels.th_title}</td>
        <td class="small-category">{$labels.test_importance}</td>
        {else}
        	<td class="small-category" colspan="2">{$labels.th_title}</td>
   	   {/if}
   	    <td class="small-category">{$labels.status}</td>
      
     </tr>
     <tr>
     	<td><input type="text" name="targetTestCase" id="TCID"  class="form-control" placeholder="{$labels.th_tcid}"
                 size="{#TC_ID_SIZE#}" maxlength="{#TC_ID_MAXLEN#}" value="{$gui->targetTestCase|escape}"/></td>

      	<td><input type="text" name="version" class="form-control" placeholder="{$labels.th_tcversion}"
                 size="{#VERSION_SIZE#}" maxlength="{#VERSION_MAXLEN#}" value="{$gui->tcversion|escape}" /></td>
      
     

       {if $session['testprojectOptions']->testPriorityEnabled}
        <td><input type="text" name="name" id="name" class="form-control" placeholder="{$labels.th_title}"
           value="{$gui->name|escape}" size="{#TCNAME_SIZE#}" maxlength="{#TCNAME_MAXLEN#}" /></td>
        <td>
          <select name="importance" class="form-control">
           {html_options options=$gui->option_importance selected=$gui->importance}
          </select>
        </td>
        {else}
        <td colspan="2"><input type="text" name="name" id="name" class="form-control" placeholder="{$labels.th_title}"
           value="{$gui->name|escape}" size="{#TCNAME_SIZE#}" maxlength="{#TCNAME_MAXLEN#}" /></td>
    	{/if}
    	 <td>
          <select name="status" class="form-control">
           {html_options options=$gui->domainTCStatus selected=$gui->status}
          </select>
        </td>
    </tr>

    <tr>
      <td class="small-category">{$labels.summary}</td>
      <td class="small-category">{$labels.preconditions}</td>
      <td class="small-category">{$labels.steps}</td>
      <td class="small-category">{$labels.expected_results}</td>
      <td class="small-category">{$labels.created_by}</td>
    </tr>
    <tr>
    
      <td><input type="text" name="summary" id="summary" class="form-control" placeholder="{$labels.summary}" value="{$gui->summary|escape}"
                 size="{#SUMMARY_SIZE#}" maxlength="{#SUMMARY_MAXLEN#}" /></td>

      
      <td><input type="text" name="preconditions" id="preconditions" value="{$gui->preconditions|escape}" 
                 size="{#PRECONDITIONS_SIZE#}" class="form-control" placeholder="{$labels.preconditions}"  maxlength="{#PRECONDITIONS_MAXLEN#}" /></td>

      
      <td><input type="text" name="steps" id="steps" value="{$gui->steps|escape}"
                 size="{#STEPS_SIZE#}" class="form-control" placeholder="{$labels.steps}" maxlength="{#STEPS_MAXLEN#}" /></td>
      <td>
      	<input type="text" name="expected_results" id="expected_results" value="{$gui->expected_results|escape}"
                 size="{#RESULTS_SIZE#}" maxlength="{#RESULTS_MAXLEN#}" class="form-control" placeholder="{$labels.expected_results}" />
      </td>
     
      <td><input type="text" name="created_by" id="created_by" 
                 value="{$gui->created_by|escape}" class="form-control" placeholder="{$labels.created_by}"
                 size="{#AUTHOR_SIZE#}" maxlength="{#TCNAME_MAXLEN#}" />
      </td>
    </tr>

    <tr>
       <td class="small-category">{$labels.edited_by}</td>
       <td class="small-category">{$labels.creation_date_from}</td>
       <td class="small-category">{$labels.creation_date_to}</td>
       <td class="small-category">{$labels.modification_date_from}</td>
       <td class="small-category">{$labels.modification_date_to}</td>
    </tr>
    <tr>
      <td>
      	<input type="text" name="edited_by" id ="edited_by" value="{$gui->edited_by|escape}"
                 size="{#AUTHOR_SIZE#}" maxlength="{#TCNAME_MAXLEN#}" class="form-control" placeholder="{$labels.edited_by}"/>
      </td>
      
      <td>
      	<div class="input-group date myDatepicker" data-date-format="dd/mm/yyyy">		
			<input type="text" name="creation_date_from" class="form-control" id="creation_date_from" 
	               value="{$gui->creation_date_from|escape}" />
			<div class="input-group-addon">
				<span class="glyphicon glyphicon-calendar"></span>
			</div>
		</div>
      </td>
      
      <td>
      	<div class="input-group date myDatepicker" data-date-format="dd/mm/yyyy">		
			<input type="text" name="creation_date_to" class="form-control" id="creation_date_to" value="{$gui->creation_date_to|escape}" />
			<div class="input-group-addon">
				<span class="glyphicon glyphicon-calendar"></span>
			</div>
		</div>
      </td>

     
      <td>
      	<div class="input-group date myDatepicker" data-date-format="dd/mm/yyyy">		
			<input type="text" name="modification_date_from" id="modification_date_from" 
       			 value="{$gui->modification_date_from|escape}" class="form-control"/>
			<div class="input-group-addon">
				<span class="glyphicon glyphicon-calendar"></span>
			</div>
		</div>       
      </td>

      
      <td>
      	<div class="input-group date myDatepicker" data-date-format="dd/mm/yyyy">		
			 <input type="text" name="modification_date_to" id="modification_date_to" 
        		value="{$gui->modification_date_to|escape}" class="form-control"/>
			<div class="input-group-addon">
				<span class="glyphicon glyphicon-calendar"></span>
			</div>
		</div>
      </td>
      
      
	</tr>
	<tr class="spacer"></tr>
	<tr>
       <td class="small-category">{$labels.jolly}<img src="{$tlImages.info}" title="{$labels.jolly_hint}"></td>
        {if $gui->filter_by.keyword}
      		<td class="small-category">{$labels.keyword}</td>
      	{/if}
      	
      	{if $gui->filter_by.requirement_doc_id}
      		<td class="small-category">{$labels.requirement_document_id}</td>
      	{/if}
      	
      	 {if $gui->filter_by.design_scope_custom_fields}
      		 <td class="small-category">{$labels.custom_field}</td>
      		 <td class="small-category">{$labels.custom_field_value}</td>
      	 {/if}
    </tr>
    <tr>
      
      <td>
      	<input type="text" name="jolly" id="jolly" value="{$gui->jolly|escape}" class="form-control" placeholder="{$labels.jolly}"
                 size="{#SUMMARY_SIZE#}" maxlength="{#SUMMARY_MAXLEN#}" />
      </td>
       {if $gui->filter_by.keyword}
      	 <td>
		      <select name="keyword_id" class="form-control">
		          <option value="0">&nbsp;</option>
		          {section name=Row loop=$gui->keywords}
		          <option value="{$gui->keywords[Row]->dbID}">{$gui->keywords[Row]->name|escape}</option>
		        {/section}
		        </select>
		      </td>
      	{/if}
      	
      	{if $gui->filter_by.requirement_doc_id}
      	  <td>
	    	<input type="text" name="requirement_doc_id" id="requirement_doc_id"
	               title="{$labels.search_type_like}" class="form-control" placeholder="{$labels.requirement_document_id}"
	               size="{#REQ_DOCID_SIZE#}" maxlength="{#REQ_DOCID_MAXLEN#}"/>
       		</td>
      	{/if}
      	
      	{if $gui->filter_by.design_scope_custom_fields}
	      	<td>
	      		<select name="custom_field_id" class="form-control">
	              <option value="0">&nbsp;</option>
	              {foreach from=$gui->design_cf key=cf_id item=cf}
	                <option value="{$cf_id}">{$cf.label|escape}</option>
	              {/foreach}
	            </select>
	         </td>
	         <td> 
	         	<input type="text" name="custom_field_value"  class="form-control"  placeholder="{$labels.custom_field_value}"
                   size="{#CFVALUE_SIZE#}" maxlength="{#CFVALUE_MAXLEN#}"/>
	         </td>
      	{/if}

    </tr>
  </table>
</form>

</div>