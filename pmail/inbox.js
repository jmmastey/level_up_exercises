$(document).ready(init)

function init()
{
  $(".dropdown-button").bind("click", dropdown_click)
}

function dropdown_click()
{
  content = $(this).next();
  pos = this.getBoundingClientRect();

  content[0].style.top = pos.bottom + "px"
  content.toggleClass("collapsed");
}
