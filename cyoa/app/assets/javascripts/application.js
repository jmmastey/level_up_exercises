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
//= require jquery-ui
//= require jquery_ujs
//= require materialize-sprockets
//= require_tree .

$(document).ready(function() {

    $('#user_political_party').material_select();

    $(document).on('click', '.query-filter.disabled', function(e){
        var active_button = $('.query-filter.active');
        active_button.removeClass('active').addClass('disabled');
        $(e.currentTarget).removeClass('disabled').addClass('active');
        var resource = $('.query-filter.active').text();
        $('#search').attr('action', '/' + resource.toLowerCase());
    });

    $(document).on('click', '.clickable tr', function() {
        var url = $(this).attr("data-url");
        if(url) {
            window.location = url;
        }
    });

    $('#tag_name').autocomplete({
        source: $('#tag_name').data('autocomplete-source'),
        focus: function( event, ui ) {
            $( "#tag_name" ).val( ui.item.label );
            return false;
        },
        select: function(event, ui){
            $('#tag_name').val(ui.item.label);
            $('#user_tag_tag_id').val(ui.item.value);
            return false;
        }
    }).autocomplete( "instance" )._renderItem = function( ul, item ) {
      return $( "<li>" )
        .append(item.label)
        .appendTo( ul );
    };
});
