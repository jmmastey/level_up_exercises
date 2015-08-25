$(document).ready(function() {
    $(document).on('click', '.query-filter.disabled', function(e){
        var active_button = $('.query-filter.active');
        active_button.removeClass('active').addClass('disabled');
        $(e.currentTarget).removeClass('disabled').addClass('active');
        var resource = $('.query-filter.active').text();
        $('#search').attr('action', '/' + resource.toLowerCase());
        $("input[type='search']").attr('name', resource.toLowerCase().slice(0,-1) + '[query]');
    });

    $(document).on('click', '.clickable tr', function() {
        var url = $(this).attr("data-url");
        if(url) {
            window.location = url;
        }
    });

});
