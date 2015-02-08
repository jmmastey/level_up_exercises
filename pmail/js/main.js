$(function() {

  // Check and uncheck emails

  $('.emails').on('click', 'tr td:nth-child(1) span', function() {
    var $checkbox = $(this);
    $checkbox.closest('tr').toggleClass('checked');
    $checkbox.toggleClass('fa-square-o fa-check-square-o');
    toggleDeleteButton();
  });

  // Add delete button when email is checked
  var $deleteButton = $('.delete-button'); // Initially hide the delete button
  $deleteButton.hide();

  function hasCheckmark() {
    $('.emails tr').each(function() {
      result = false;
      if ( $(this).hasClass('checked') ) {
        result = true;
        return false;
      } 
    });
    return result;
  }
  
  function toggleDeleteButton() { // Toggle delete button if any email is checked
    var checkmark = hasCheckmark();
    if ( checkmark === true ) {
      $deleteButton.show();
    } else {
      $deleteButton.hide();
    }
  }

  // Star and unstar emails
  $('.emails').on('click', 'tr td:nth-child(2) span', function() {
    var $star = $(this);
    $star.toggleClass('fa-star-o fa-star');
  });

  // Animate in additional inbox items

  $('.mailboxes a:gt(5)').hide();

  $('.mailboxes li:contains(More)').on('click', function() {
    $(this).closest('ul').find('a:gt(5)').toggle();
  });

  // Delete Checkmarked Emails

  $('.delete-button').on('click', function() {
    var $checkedEmails = $('.checked');
    $checkedEmails.each(function() {
      $(this).remove();
    });
    displayFlash("The conversation has been deleted.");
  });

  // Display Flash message

  function displayFlash(message) {
    var $flashMessage = $('<p>' + message + '</p>');
    $('#email-controls-1').append($flashMessage);
  }

  // Display Gmail menu

  var $mailboxDropdownMenu = $('#mailbox-dropdown-menu');
  $mailboxDropdownMenu.hide();

  $('#mail-dropdown').on('click', function(event) {
    $mailboxDropdownMenu.toggle();
  });

  $(document).on('click', function() {
    if (!$(event.target).closest('.app-control').length) {
      $mailboxDropdownMenu.hide();
    }
  });

});
