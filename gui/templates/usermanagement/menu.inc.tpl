{*
Testlink Open Source Project - http://testlink.sourceforge.net/
@filesource menu.inc.tpl
include to generate menu when managing users and roles

@internal revisions
@since 1.9.15
*}

{* Action managed via menu *}
{$lib = 'lib/usermanagement'}
{$act['view_users']['url'] = $lib|cat:'/usersView.php'}
{$act['view_roles']['url'] = $lib|cat:'/rolesView.php'}
{$act['assign_users_tproject']['url'] = $lib|cat:'/usersAssign.php?featureType=testproject'}
{$act['assign_users_tplan']['url'] = $lib|cat:'/usersAssign.php?featureType=testplan'}

{lang_get var="menuLbl"
          s="menu_new_user,menu_view_users,menu_edit_user,menu_define_roles,menu_edit_role,menu_view_roles,menu_assign_testproject_roles,menu_assign_testplan_roles"}

{foreach from=$act key=ak item=mx }
  {$act[$ak]['class'] = ''}
  {if $gui->highlight->$ak == 1}
    {$act[$ak]['class'] = ' active '}
  {/if}
{/foreach}

{if $gui->grants->user_mgmt == "no"}
  {$act[$ak]['class'] = ''}
{/if}

<div class="space-10"></div>
<div class="center">
	<div class="btn-toolbar inline">
		<div class="btn-group">

        {if $gui->grants->user_mgmt == "yes"}
    	    <a class="btn btn-sm btn-white btn-primary {$act['view_users']['class']}" href="{$act['view_users']['url']}">{$menuLbl.menu_view_users}</a>
		{/if}
    
        {if $gui->grants->role_mgmt == "yes"}    
          <a class="btn btn-sm btn-white btn-primary {$act['view_roles']['class']}" href="{$act['view_roles']['url']}">{$menuLbl.menu_view_roles}</a>
        {/if}
    
        {if $gui->grants->tproject_user_role_assignment == "yes"}
          <a class="btn btn-sm btn-white btn-primary {$act['assign_users_tproject']['class']}" href="{$act['assign_users_tproject']['url']}">{$menuLbl.menu_assign_testproject_roles}</a>
        {/if}
    
        {if $gui->grants->tplan_user_role_assignment == "yes"}
          <a class="btn btn-sm btn-white btn-primary {$act['assign_users_tplan']['class']}" href="{$act['assign_users_tplan']['url']}">{$menuLbl.menu_assign_testplan_roles}</a>
        {/if}
        
		</div>
	</div>  
</div>
<div class="space-10"></div>