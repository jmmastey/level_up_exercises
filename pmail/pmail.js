function toggleSelection(id) {
    $(id).toggleClass('fa-square-o fa-check-square');
    $(id).closest('.email').toggleClass('selected');
  };

  function toggleFavorite(id) {
    $(id).toggleClass('fa-star fa-star-o');
  };

  $('.top-dropdown').click(function() {
    $(this).siblings('.dropdown-panel').toggle();
  })

  $('.sidebar-menu li a').click(function() {
    if ($(this).hasClass('top-dropdown')) {
      $('.more-list').toggle();
    } else {
      $('.sidebar-menu li').removeClass('active');
      return $(this.parentNode).addClass('active');
    }
  })