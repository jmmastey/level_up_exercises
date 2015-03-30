// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
  $(".cb-blacklist").change(function() {
    var venue_id = $(this).attr("data-venue-id");
    var checked = $(this).is(":checked");

    if (checked) {
      $.ajax({
        type: "POST",
        url: "/blacklist/add/" + venue_id,
        data: { id: venue_id },
        error: function(xhr, status, error) {
          alert("Error: " + error);
        }
      });
    } else {
      $.ajax({
        type: "DELETE",
        url: "/blacklist/del/" + venue_id,
        data: { id: venue_id },
        error: function(xhr, status, error) {
          alert("Error: " + error);
        }
      });
    }
  }) 
})
