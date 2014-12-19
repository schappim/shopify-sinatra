$(document).ready(function() {

/* =================================
   Sidebar tabs
   ================================= */
$('.sidebar-icon a:not(:first)').click(function (e) {
	e.preventDefault();
	$(this).tab('show');
});

/* =================================
   Show menu button on mobile
   ================================= */
$("#show-menu").click(function(e) {
	e.preventDefault();
	$("#wrapper").toggleClass("active");
});
});