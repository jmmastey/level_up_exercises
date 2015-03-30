// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
  $(".edit_profile").on("ajax:error", function(e, xhr, status, error) {
    alert("An error occurred: " + error);
  }) 

  $(".edit_profile input[type='text']").keydown(function() {
    $("#flash_box").empty();
    $("#profile_save").removeClass("disabled");
  });

  $(".edit_profile select").change(function() {
    $("#flash_box").empty();
    $("#profile_save").removeClass("disabled");
  });
});
