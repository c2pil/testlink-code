/**
 * TestLink Open Source Project - http://testlink.sourceforge.net/
 * This script is distributed under the GNU General Public License 2 or later.
 *
 * @package     TestLink
 * @author      C2pil
 * @filesource  menu_active.js
 * @link        http://www.testlink.org
 * @since       1.9
 *
 * Function to activate menu buttons.
 *
 *
 */

var sidebar = document.getElementById("sidebar").getElementsByTagName("li");

function activeButton(button_id){
	for(var i=0; i<sidebar.length; i++){
		sidebar[i].setAttribute("class", "");
	}	
	document.getElementById(button_id).setAttribute("class", "active");
}