// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function setup_event_handlers() {
	$( "#search-options-div" ).mouseenter( function() {
		console.log("Mouse entered");
		$( "#search-options-div .tooltip" ).show();
	});

	$( "#search-options-div" ).mouseleave( function() {
		console.log("Mouse left");
		$( "#search-options-div .tooltip" ).hide();
	});

	$( "#apps-button-div" ).mouseenter( function() {
		console.log("Mouse entered");
		$( "#apps-button-div .tooltip" ).show();
	});

	$( "#apps-button-div" ).mouseleave( function() {
		console.log("Mouse left");
		$( "#apps-button-div .tooltip" ).hide();
	});

	$( "#mail-options-button-div" ).click( function() {
		$( "#mail-options-list-div" ).toggle();
	});
}

$(document).ready(function() {
	console.log("document loaded");
});

$(window).load(function() {
	console.log("window loaded");
	setup_event_handlers();
});
