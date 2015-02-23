$(".message").click(function(event) {
  checkbox = $(this).find(":checkbox");
  checkbox_status = checkbox.prop("checked");
  checkbox.prop("checked", !checkbox_status);
});

$(":checkbox").click(function(event) {
  message = $(this).closest("article.message");
  event.stopPropagation();
});

$("label").click(function(event) {
  message = $(this).closest("article.message");
  event.stopPropagation();
});
