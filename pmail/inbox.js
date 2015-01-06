$(document).ready(init)

function init()
{
  init_dropdowns();
}

var CLS_CONTROL_ACTIVE = "control-active";

function activate_control(control) { control.addClass(CLS_CONTROL_ACTIVE); }
function deactivate_control(control) { control.removeClass(CLS_CONTROL_ACTIVE); }
function control_is_active(control) { return control.hasClass(CLS_CONTROL_ACTIVE); }

var DPD_POS_METHOD = 'dropdown-position-method';

var CLS_DPD_CONTROL = "dropdown-button";
var CLS_DPD_COLLAPSED = "collapsed";
var CLS_DPD_ALIGN_RT = "dropdown-right-align";
var CLS_DPD_ALIGN_LT = "dropdown-left-align";
var CLS_DPD_ALIGN_CT = "dropdown-center-align";

function dot(css_class) { return "." + css_class; }

var dpd_position_methods = {};
dpd_position_methods[dot(CLS_DPD_ALIGN_RT)] = dropdown_right_align;
dpd_position_methods[dot(CLS_DPD_ALIGN_LT)] = dropdown_left_align;
dpd_position_methods[dot(CLS_DPD_ALIGN_CT)] = dropdown_center_align;

function init_dropdowns()
{
  all_dropdowns().bind("click", dropdown_click)
  for (var css_selector in dpd_position_methods)
    $(css_selector).data(DPD_POS_METHOD,
                         dpd_position_methods[css_selector]);
}

function all_dropdowns() { return $(dot(CLS_DPD_CONTROL)); }

function dropdown_content_pane(button) { return $(button).next(); }

function dropdown_right_align(data)
{
  with (data) { return button.left + button.width - content.width; }
}

function dropdown_left_align(data) { return data.button.left; }

function dropdown_center_align(data)
{
  with (data) { return button.left + (button.width - content.width) / 2; }
}

function dropdown_align_params(button, content)
{
  var par_node = button.offsetParent();
  var par_pos = par_node.position();
  var button_pos = button.position();

  return {
    parent: { node: par_node, left: par_pos.left,
              top: par_pos.top, width: par_node.outerWidth() },
    button: { node: button, left: button_pos.left,
              top: button_pos.top, width: button.outerWidth() },
    content: { node: content, width: content.outerWidth() }
  };
}

function dropdown_set_content_position(button, content)
{
  var params = dropdown_align_params(button, content);
  var max_x_pos = $('body').width() - params.content.width
                  - params.parent.node.offset().left;
  var ideal_x_pos = dropdown_align_content(button, params);
  var x_pos = Math.min(ideal_x_pos, max_x_pos);

  content.css('top', (params.button.top + button.outerHeight()) + "px");
  content.css('left', x_pos + "px");
}

function dropdown_align_content(button, data)
{
  align_method = button.data(DPD_POS_METHOD) || dropdown_left_align;
  return align_method(data)
}

function dropdown_close_all()
{
  all_dropdowns().each(function() { dropdown_close($(this)); });
}

function dropdown_close(button)
{
  dropdown_content_pane(button).addClass(CLS_DPD_COLLAPSED);
  deactivate_control(button);
}

function dropdown_open(button)
{
  dropdown_close_all();
  var content_pane = dropdown_content_pane(button);
  activate_control(button);
  dropdown_set_content_position(button, content_pane);
  content_pane.removeClass(CLS_DPD_COLLAPSED);
}

function dropdown_toggle(control)
{
  control_is_active(control) ? dropdown_close(control) : dropdown_open(control);
}

function dropdown_click() { dropdown_toggle($(this)) }
