/**

JS file for control panel Filter

IMPORTANT : Jquery is require
**/

jQuery(".chevron-toogle").click(function() {

	if (jQuery(this).children(".serviceCollapse").hasClass("glyphicon-chevron-up")) {
		jQuery(this).children(".serviceCollapse").removeClass("glyphicon-chevron-up");
		jQuery(this).children(".serviceCollapse").addClass("glyphicon-chevron-down");
	} else {
		jQuery(this).children(".serviceCollapse").addClass("glyphicon-chevron-up");
		jQuery(this).children(".serviceCollapse").removeClass("glyphicon-chevron-down");
	}
});
