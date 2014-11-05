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

	// Tool-Tips
	$( ".has-tooltip" ).mouseenter( function() {

		// Tip
		var tip = $( this ).data("tip");

		// Element
		var element = document.createElement('div');

		$( element )
			.addClass("tooltip")
			.html(tip)
			.appendTo( $( this ) )
			.show();

	}).mouseleave( function() {
		$( this ).find( ".tooltip" ).remove();
	});


	// Search
	$( ".search .down-arrow" ).click( function() {
		$( ".search .menu" ).toggle();
	});


	// Manage Account
	$( ".manage-account" ).click( function() {
		$( this ).find( ".menu" ).toggle();
	});

	
	// Mail Options
	$( ".mail-options" ).click( function() {
		$( this ).find( ".menu" ).toggle();
	});


	// Mail Item Selection
	$( ".mail-selection .down-arrow" ).click( function() {
		$( this ).parent().find(".options").toggle();
	});

	// Mail Item Selection: Check/Uncheck All
	$( ".mail-selection input.check-all" ).change( function() {
		$( this ).prop('checked', this.checked);
		$( ".mail-items .checkbox input" ).prop('checked', this.checked);
	});

	// Mail Item Selection: All
	$( ".mail-selection li.all" ).click( function() {
		$( ".mail-items .checkbox input" ).prop('checked', true);
		$( ".mail-selection .options" ).toggle();
	});

	// Mail Item Selection: None
	$( ".mail-selection li.none" ).click( function() {
		$( ".mail-items .checkbox input" ).prop('checked', false);
		$( ".mail-selection .options" ).toggle();
	});

	// Mail Item Selection: Starred
	$( ".mail-selection li.starred" ).click( function() {
		$( ".mail-items .star.starred" ).each( function() {
			$( this ).parent().find(".checkbox input").prop('checked', true);
		});
		$( ".mail-selection .options" ).hide();
	});

	// Mail Item Selection: Unstarred
	$( ".mail-selection li.unstarred" ).click( function() {
		$( ".mail-items .star" ).each( function() {
			if (!$( this ).hasClass("starred")) {
				$( this ).parent().find(".checkbox input").prop('checked', true);
			}
		});
		$( ".mail-selection .options" ).hide();
	});

	// More
	$( ".more" ).click( function() {
		$( this ).find(".menu").toggle();
	});


	// Settings
	$( ".settings" ).click( function() {
		$( this ).find(".menu").toggle();
	});

	$( ".settings li.density" ).click( function() {
		$( this ).siblings( "li.density" ).removeClass("selected")
		$( this ).addClass("selected");
	});


	// Folders
	$( ".folders li" ).click( function() {
		$( ".folders li" ).removeClass("selected");
		$( this ).addClass("selected");
	});


	// Mail Items Starred - Individual
	$( ".mail-items .star" ).click( function() {
		$( this ).toggleClass("starred");
	});
}

function clear_settings_menu_options() {
	
}

$(document).ready(function() {
});

$(window).load(function() {
	setup_event_handlers();
});
