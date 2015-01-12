// Generated by CoffeeScript 1.8.0
(function() {
  var init_dropdown, init_message_list, init_refresh, init_search_box, init_sidebar, resize_main_pane;

  init_dropdown = function() {
    return $('.dropdown-toggle').click(function() {
      return $(this).siblings('.dropdown-panel').toggle();
    });
  };

  init_refresh = function() {
    return $('button#refresh').click(function() {
      return window.location.reload();
    });
  };

  init_message_list = function() {
    return $('input[name="selected_message"]').change(function() {
      if ($(this).prop('checked')) {
        return $(this).parents('.message').addClass('active');
      } else {
        return $(this).parents('.message').removeClass('active');
      }
    });
  };

  init_search_box = function() {
    var search_box, search_input;
    search_box = $('.search-box');
    search_input = $('.search-box input[type="search"]');
    search_input.focus(function() {
      return search_box.addClass('focus');
    });
    return search_input.blur(function() {
      return search_box.removeClass('focus');
    });
  };

  init_sidebar = function() {
    return $('.sidebar-links li a').click(function() {
      if (!$(this).attr("data-target")) {
        $('.sidebar-links li').removeClass('active');
        return $(this.parentNode).addClass('active');
      }
    });
  };

  resize_main_pane = function() {
    return $('.main-pane').css('width', $(window).width() - $('.sidebar').outerWidth());
  };

  $(function() {
    init_dropdown();
    init_message_list();
    init_refresh();
    init_search_box();
    init_sidebar();
    resize_main_pane();
    return $(window).resize(resize_main_pane);
  });

}).call(this);
