$(document).ready(function() {
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
