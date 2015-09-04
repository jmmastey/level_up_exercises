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
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets
//= require vis
function check_user_depth(){
    var current_depth = $('#recursion-depth').val();
    var logged_in = $('a[href$="/users/sign_up"]').length == 0;
    if(!logged_in && current_depth > 2){
        alert("You must log in to search at depths greater than 2");
    }
    if(logged_in && current_depth > 5) {
        alert("Searching at depths greater than 5 is too computationally expensive.");
    }
}