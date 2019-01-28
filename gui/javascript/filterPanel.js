/**
 * TestLink Open Source Project - http://testlink.sourceforge.net/
 * This script is distributed under the GNU General Public License 2 or later.
 *
 * @package     TestLink
 * @author      C2pil
 * @filesource  filterPanel.js
 * @link        http://www.testlink.org
 * @since       1.9
 *
 * JS file for control panel Filter
 *
 * IMPORTANT : Jquery is require
 *
 *
 */

// For each chevron clicked
jQuery('.chevron-toogle').on('click', function (event) {
	// Div class targeted 
	let div_class = jQuery(jQuery(this).attr('href')).attr('class');
	// Chevron class
	let child = jQuery(this).children(".serviceCollapse");
	
	if(div_class.match(/collapse in/)){
		child.removeClass("glyphicon-chevron-up").addClass("glyphicon-chevron-down");
	}else{
		if(div_class.match(/collapse/)){
			child.removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-up");
		}
	}
});

