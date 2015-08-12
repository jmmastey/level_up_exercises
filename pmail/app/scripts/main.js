// jshint devel:true

$('table input:checkbox').click(function() {
  $(this).closest('tr').toggleClass('highlight')
  var num_checked = $("table input:checkbox:checked").length;
  if (num_checked == 0) {
    $('.selection').prop("checked", false);
  } else {
    $('.selection').prop("checked", true);
  }
})

$('.selection').on('click', function(){
  var selected = $(this).prop('checked');
  var checkboxes = $('table input:checkbox');
  for (var i = 0; i < checkboxes.length; i++) {
    if ($(checkboxes[i]).prop("checked") != selected) {
      $(checkboxes[i]).click();
    }
  }
})
