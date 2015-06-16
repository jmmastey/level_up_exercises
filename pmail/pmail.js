$(".message").click(function() {
  checkbox = $(this).find(":checkbox");
  checkboxStatus = checkbox.prop("checked");
  checkbox.prop("checked", !checkboxStatus);
  });

$(":checkbox").click(function(event) {
  event.stopPropagation();
});

$("label").click(function(event) {
  event.stopPropagation();
});