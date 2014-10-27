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

function hide_toggle_menues_other_than(element) {
}

function setup_event_handlers() {

	// Search Options
	$( "#search-options-div" ).mouseenter( function() {
		$( "#search-options-div .tooltip" ).show();
	});

	$( "#search-options-div" ).mouseleave( function() {
		$( "#search-options-div .tooltip" ).hide();
	});

	$( "#search-options-div" ).click( function() {
		$( "#search-options-menu-div" ).toggle();
	});


	// Apps Button
	$( "#apps-button-div" ).mouseenter( function() {
		$( "#apps-button-div .tooltip" ).show();
	});

	$( "#apps-button-div" ).mouseleave( function() {
		$( "#apps-button-div .tooltip" ).hide();
	});


	// Mail Options
	$( "#mail-options-button-div" ).click( function() {
		$( "#mail-options-list-div" ).toggle();
	});


	// Manage Account
	$( "#manage-account" ).mouseenter( function() {
		$( "#manage-account-menu" ).show("fast");
	});

	$( "#manage-account-menu" ).click( function() {
		$( "#manage-account-menu" ).hide();
	});

	
	// Mail Item Selection
	$( "#mail-item-selection-div .down-arrow" ).click( function() {
		$( "#mail-item-selection-options-div" ).toggle();
	});

	
	// Mark All As Read
	$( "#mark-all-as-read-div" ).click( function() {
		$( "#mark-all-as-read-menu-div" ).toggle();
	});
}

$(document).ready(function() {
	console.log("document loaded");
});

$(window).load(function() {
	console.log("window loaded");
	setup_event_handlers();
});
