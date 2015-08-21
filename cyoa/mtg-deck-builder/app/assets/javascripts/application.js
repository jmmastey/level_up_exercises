// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require tag-it.min
//= require tipped
//= require nouislider.min
//= require_tree .

function setupLogoClickHandler (logo_selector) {
  $(logo_selector).on("click", function (event) {
    document.location.href = "/";
  });
}

$(document).ready(function () {
  setupLogoClickHandler("#logo");
});