/**
 * Created by lwalters on 9/30/2014.
 */

$(document).ready(function(){
    $("#show_attempts").on("click", function() {
        get_attempts_remaining();
    });
});

function get_attempts_remaining() {
    $.ajax({
        url: "/attempts_remaining",
        cache: false
      })
    .done(function( html ) {
        $( "#attempts_remaining" ).replaceWith( html );
    });
}
