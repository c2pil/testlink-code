/**
 * TestLink Open Source Project - http://testlink.sourceforge.net/
 * This script is distributed under the GNU General Public License 2 or later.
 *
 * @package     TestLink
 * @author      C2pil
 * @copyright   2010,2014 TestLink community
 * @filesource  menu_active.js
 * @link        http://www.testlink.org
 * @since       1.9
 *
 * Function to activate menu buttons.
 *
 *
 */

function activeButton(button_id){
	var button_number = 7;
	for(i=1; i<=button_number; i++){
		document.getElementById('button_'+i).setAttribute("class", "");
	}
	
	document.getElementById(button_id).setAttribute("class", "active");
}