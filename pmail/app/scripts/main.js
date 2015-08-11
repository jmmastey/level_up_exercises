// jshint devel:true

$('table input:checkbox').click(function() {
  $(this).closest('tr').toggleClass('highlight')
})
