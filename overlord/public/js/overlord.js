$(document).ready(function() {
    $('#change-bomb-state').click(function(e) {
        window.location = '/enter/' + $('#trigger-code').val();
    });
});
