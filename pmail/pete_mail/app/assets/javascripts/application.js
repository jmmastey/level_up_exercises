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
	$( ".search-options-div" ).mouseenter( function() {
		$( ".search-options-div .tooltip" ).show();
	});

	$( ".search-options-div" ).mouseleave( function() {
		$( ".search-options-div .tooltip" ).hide();
	});

	$( ".search-options-div" ).click( function() {
		$( ".search-options-menu-div" ).toggle();
	});


	// Apps Button
	$( ".apps-button-div" ).mouseenter( function() {
		$( ".apps-button-div .tooltip" ).show();
	});

	$( ".apps-button-div" ).mouseleave( function() {
		$( ".apps-button-div .tooltip" ).hide();
	});


	// Manage Account
	$( ".manage-account" ).click( function() {
		$( ".manage-account-menu" ).toggle();
	});

	
	// Mail Options
	$( ".mail-options-button-div" ).click( function() {
		$( ".mail-options-list-div" ).toggle();
	});


	// Mail Item Selection
	$( ".mail-item-selection-div .down-arrow" ).click( function() {
		$( ".mail-item-selection-options-div" ).toggle();
	});

	$( ".mail-item-selection-div input" ).change( function() {
		if (this.checked) {
			$( ".mail-items-div .checkbox input" ).prop('checked', true);
		}
		else {
			$( ".mail-items-div .checkbox input" ).prop('checked', false);
		}
	});

	// Mail Item Selection: All
	$( ".mail-item-selection-options-div li.all" ).click( function() {
		$( ".mail-items-div .checkbox input" ).prop('checked', true);
		$( ".mail-item-selection-options-div" ).toggle();
	});

	// Mail Item Selection: None
	$( ".mail-item-selection-options-div li.none" ).click( function() {
		$( ".mail-items-div .checkbox input" ).prop('checked', false);
		$( ".mail-item-selection-options-div" ).toggle();
	});

	// Mail Item Selection: Starred
	$( ".mail-item-selection-options-div li.starred" ).click( function() {
		$( ".mail-items-div .checkbox input" ).each( function() {
			var star = $( this ).parent().parent().find('td.starred');
			if ($( star ).hasClass("checked")) {
				$( this ).prop('checked', true);
			}
		});
		$( ".mail-item-selection-options-div" ).toggle();
	});

	// Mail Item Selection: Unstarred
	$( ".mail-item-selection-options-div li.unstarred" ).click( function() {
		$( ".mail-items-div .checkbox input" ).each( function() {
			var star = $( this ).parent().parent().find('td.starred');
			if (!($( star ).hasClass("checked"))) {
				$( this ).prop('checked', true);
			}
		});
		$( ".mail-item-selection-options-div" ).toggle();
	});

	

	// Mark All As Read
	$( ".mark-all-as-read-div" ).click( function() {
		$( ".mark-all-as-read-menu-div" ).toggle();
	});


	// Settings
	$( ".settings-div" ).click( function() {
		$( ".settings-menu-div" ).toggle();
	});

	$( ".settings-menu-div li.density" ).click( function() {
		$( ".settings-menu-div li.density" ).removeClass("selected");
		$( this ).addClass("selected");
	});


	// Folders
	$( ".folders li" ).click( function() {
		$( ".folders li" ).removeClass("selected");
		$( this ).addClass("selected");
	});


	// Mail Items Starred - Individual
	$( ".mail-items-div .table td.starred" ).click( function() {
		if ($( this ).hasClass("checked")) {
			$( this ).removeClass("checked");
		}
		else {
			$( this ).addClass("checked");
		}
	});
}

function clear_settings_menu_options() {
	
}

$(document).ready(function() {
});

$(window).load(function() {
	setup_event_handlers();
});
