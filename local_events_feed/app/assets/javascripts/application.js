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

function setUserShowingsScrollable() {
	$( "#user-event-showings" ).addClass("scrollable");
}

function drawTripod(ctx, centerX, centerY, bgnR, endR) {
	var cos30 = Math.cos(33 * Math.PI / 180.0);
	var sin30 = Math.sin(33 * Math.PI / 180.0);

	ctx.beginPath();
	ctx.moveTo(centerX, centerY - bgnR);
	ctx.lineTo(centerX, centerY - endR);

	ctx.moveTo(centerX - bgnR * cos30, centerY + bgnR * sin30);
	ctx.lineTo(centerX - endR * cos30, centerY + endR * sin30);

	ctx.moveTo(centerX + bgnR * cos30, centerY + bgnR * sin30);
	ctx.lineTo(centerX + endR * cos30, centerY + endR * sin30);
	ctx.stroke();
}

function drawHomeBackground() {
	var canvas = document.getElementById("home-menu-canvas");
	var ctx = canvas.getContext("2d");

	canvas.width = 500;
	canvas.height = 500;

	ctx.globalAlpha = 0.4;
	ctx.strokeStyle = "#000077";
	ctx.lineCap = "round";

	ctx.lineWidth = 20;
	drawTripod(ctx, 247, 303, 75, 160);
}
