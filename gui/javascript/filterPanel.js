/**

JS file for control panel Filter

IMPORTANT : Jquery is require
**/

jQuery("#filter-toogle").click(function() {
	
	if (jQuery("#filter-toogle > .serviceCollapse").hasClass("glyphicon-chevron-up")) {
		jQuery("#filter-toogle > .serviceCollapse").removeClass("glyphicon-chevron-up");
		jQuery("#filter-toogle > .serviceCollapse").addClass("glyphicon-chevron-down");
	} else {
		jQuery("#filter-toogle > .serviceCollapse").addClass("glyphicon-chevron-up");
		jQuery("#filter-toogle > .serviceCollapse").removeClass("glyphicon-chevron-down");
	}
});
