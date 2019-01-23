/**
 * TestLink Open Source Project - http://testlink.sourceforge.net/
 * This script is distributed under the GNU General Public License 2 or later.
 *
 * @package     TestLink
 * @author      C2pil
 * @filesource  sideBar.js
 * @link        http://www.testlink.org
 * @since       1.9
 *
 * Function to activate menu buttons.
 *
 *
 */

var sidebar = document.getElementById("sidebar").getElementsByTagName("li");

jQuery(document).ready( function() {
	jQuery('#sidebar-btn.sidebar-toggle').on('click', function (event) {
		if(jQuery('#sidebar').attr('class').match(/sidebar-large/)){
			jQuery('#sidebar').addClass('sidebar-small').removeClass('sidebar-large');
			jQuery('.menu-text-shown').addClass('menu-text-hidden').removeClass('menu-text-shown');
			jQuery('#collapse_btn').addClass('fa-angle-double-right').removeClass('fa-angle-double-left');
			jQuery('#contentFrame').addClass('contentFrame-large').removeClass('contentFrame-small');
		}else{
			jQuery('#sidebar').addClass('sidebar-large').removeClass('sidebar-small');
			jQuery('.menu-text-hidden').addClass('menu-text-shown').removeClass('menu-text-hidden');
			jQuery('#collapse_btn').addClass('fa-angle-double-left').removeClass('fa-angle-double-right');
			jQuery('#contentFrame').addClass('contentFrame-small').removeClass('contentFrame-large');
		}
	});
});

function activeButton(button_id){
	for(var i=0; i<sidebar.length; i++){
		sidebar[i].setAttribute("class", "");
	}	
	document.getElementById(button_id).setAttribute("class", "active");
}