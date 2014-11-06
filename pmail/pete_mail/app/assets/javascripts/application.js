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


function setup_tooltips() {

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
}

function setup_popups() {

	// Child
	$( ".has-popup" ).click( function() {
		$( this ).find(".popup").toggle();
	});

	// Sibling
	$( ".has-popup-sibling" ).click( function() {
		$( this ).find("~.popup").toggle();
	});
}

function setup_select_ones() {

	$( ".select-one" ).click( function() {
		$( this ).siblings( ".select-one" ).removeClass("selected");
		$( this ).addClass("selected");
	});
}

function setup_event_handlers() {

	setup_tooltips();
	setup_popups();
	setup_select_ones();

	// Mail Selection: Check/Uncheck All
	$( ".mail-selection input.check-all" ).change( function() {
		$( this ).prop('checked', this.checked);
		$( ".mail-items .checkbox input" ).prop('checked', this.checked);
	});

	// Mail Selection: All
	$( ".mail-selection li.all" ).click( function() {
		$( ".mail-items .checkbox input" ).prop('checked', true);
		$( ".mail-selection .options" ).toggle();
	});

	// Mail Selection: None
	$( ".mail-selection li.none" ).click( function() {
		$( ".mail-items .checkbox input" ).prop('checked', false);
		$( ".mail-selection .options" ).toggle();
	});

	// Mail Selection: Starred
	$( ".mail-selection li.starred" ).click( function() {
		$( ".mail-items .star.starred" ).each( function() {
			$( this ).parent().find(".checkbox input").prop('checked', true);
		});
		$( ".mail-selection .options" ).hide();
	});

	// Mail Selection: Unstarred
	$( ".mail-selection li.unstarred" ).click( function() {
		$( ".mail-items .star" ).each( function() {
			if (!$( this ).hasClass("starred")) {
				$( this ).parent().find(".checkbox input").prop('checked', true);
			}
		});
		$( ".mail-selection .options" ).hide();
	});

	// Mail Items Starred - Individual
	$( ".mail-items .star" ).click( function() {
		$( this ).toggleClass("starred");
	});
}


$(document).ready(function() {
});

$(window).load(function() {
	setup_event_handlers();
});
