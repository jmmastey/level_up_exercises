$(document).ready(init)

function init()
{
  init_dropdowns();
  init_checkboxes();
  init_radiobuttons();
  init_rollups();
  init_grid_rows();
  init_folder_items();
}

var CLS_CONTROL_ACTIVE = "control-active";

var DPD_POS_METHOD = 'dropdown-position-method';

var CLS_DPD_CONTROL = "dropdown-button";
var CLS_DPD_ALIGN_RT = "dropdown-right-align";
var CLS_DPD_ALIGN_LT = "dropdown-left-align";
var CLS_DPD_ALIGN_CT = "dropdown-center-align";
var CLS_DPD_MATCH_WIDTH = "dropdown-match-width";
var CLS_DPD_CLOSE_CONTROL = "close-dropdown";
var ATR_DPD_PARENT_ID = "dropdown-parent-id";

var CLS_CKB_CONTROL = "checkbox";
var CLS_CHECKED = "checked";

var CLS_RDB_CONTROL = "radio-button";
var CLS_RDB_LIST_ITEM = "radio-button-item";
var ATR_RDB_GROUP = "radio-group";

var CLS_MNI_SIMPLE = "simple-menu-item";
var CLS_MNI_REPLACE_LABEL = "replace-label";

var CLS_RUB_CONTROL = "rollup-button";
var ATR_RUB_TARGET = "rollup-target";

var CLS_GRD_CONTROL = "mailbox-list";
var CLS_GRW_CONTROL = "mailbox-list-row";
var CLS_GDH_CONTROL = "mailbox-list-handle";
var CLS_GDC_FAVORITE = "mailbox-list-fav";
var CLS_GDC_IMPORTANT = "mailbox-list-important";

var CLS_FOL_ITEM = "folder-item";

var CBK_ON_ACTUATE = "control-on-actuate";
var CBK_ON_ACTIVATE = "control-on-activate";
var CBK_ON_DEACTIVATE = "control-on-deactivate";

var CLS_PRE_ARROW_DOWN = "pre-arrow-down";
var CLS_PRE_ARROW_RIGHT = "pre-arrow-right";

var CLS_STE_COLLAPSED = "collapsed";
var CLS_STE_CURRENT = "current";

function dot(css_class) { return "." + css_class; }

/* GENERIC CONTROLS */

function control_activate(control)
{
  control_run_callback(control, CBK_ON_ACTIVATE);
  control.addClass(CLS_CONTROL_ACTIVE);
}

function control_deactivate(control)
{
  control_run_callback(control, CBK_ON_DEACTIVATE);
  control.removeClass(CLS_CONTROL_ACTIVE);
}

function control_is_active(control) { return control.hasClass(CLS_CONTROL_ACTIVE); }

function control_run_callback(control, callback_name, args)
{
  var callback = control.data(callback_name);
  if (! callback) return;

  var callback_args = Array.prototype.slice.call(arguments, 2);
  callback_args.unshift(control);
  callback.apply(this, callback_args);
}

/* DROPDOWN CONTROLS */

var dpd_position_methods = {};
dpd_position_methods[dot(CLS_DPD_ALIGN_RT)] = dropdown_right_align;
dpd_position_methods[dot(CLS_DPD_ALIGN_LT)] = dropdown_left_align;
dpd_position_methods[dot(CLS_DPD_ALIGN_CT)] = dropdown_center_align;

function init_dropdowns()
{
  all_dropdowns().bind("click", dropdown_click)
  $(document).bind("click", dropdown_check_if_mouse_leaves);

  for (var css_selector in dpd_position_methods)
    $(css_selector).data(DPD_POS_METHOD,
                         dpd_position_methods[css_selector]);

  $(dot(CLS_DPD_CLOSE_CONTROL)).bind("click", function() {
    dropdown_close_parent($(this));
  });

  $(dot(CLS_MNI_SIMPLE)).bind("click", menu_item_click);

  $(dot(CLS_MNI_REPLACE_LABEL)).each(function() {
    $(this).data(CBK_ON_ACTUATE, menu_item_replace_dropdown_label);
  });
}

function all_dropdowns() { return $(dot(CLS_DPD_CONTROL)); }

function dropdown_content_pane(button) { return $(button).next(); }

function dropdown_right_align(data)
{
  with (data) { return parent.left + parent.width - content.width; }
}

function dropdown_left_align(data) { return data.parent.left; }

function dropdown_center_align(data)
{
  with (data) { return parent.left + (parent.width - content.width) / 2; }
}

function dropdown_align_params(parent, content)
{
  var container_node = parent.offsetParent();
  var container_pos = container_node.offset();
  var parent_pos = parent.offset();

  return {
    container: { node: container_node, left: container_pos.left,
              top: container_pos.top, width: container_node.outerWidth() },
    parent: { node: parent, left: parent_pos.left,
              top: parent_pos.top, width: parent.outerWidth() },
    content: { node: content, width: content.outerWidth() }
  };
}

function dropdown_parent(element)
{
  return element.closest('.dropdown-frame').prev();
}

function dropdown_close_parent(element)
{
  dropdown_close(dropdown_parent($(element)));
}

function dropdown_aligning_control(button, content)
{
  var parent_id = content.attr(ATR_DPD_PARENT_ID);
  return parent_id ? $('#' + parent_id) : button;
}

function dropdown_set_content_position(button, content)
{
  var parent = dropdown_aligning_control(button, content);
  var params = dropdown_align_params(parent, content);
  dropdown_align_content(params);
  dropdown_set_width(params);
}

function dropdown_set_width(data)
{
  with (data) {
    if (content.node.hasClass(CLS_DPD_MATCH_WIDTH))
      content.node.css('width', parent.width + "px");
  }
}

function dropdown_align_content(data)
{
  with (data) {
    var max_x_pos = $('body').width() - content.width;
    align_method = parent.node.data(DPD_POS_METHOD) || dropdown_left_align;
    var ideal_x_pos = align_method(data);
    var x_pos = Math.min(ideal_x_pos, max_x_pos);

    content.node.css('top', parent.top + parent.node.outerHeight());
    content.node.css('left', x_pos);
  }
}

function dropdown_close_unrelated(dropdown)
{
  var active_dropdowns = $(dot(CLS_DPD_CONTROL) + dot(CLS_CONTROL_ACTIVE))
  
  active_dropdowns.each(function() {
    var its_dropdown_pane = dropdown_content_pane($(this));
    if (its_dropdown_pane.has(dropdown).length == 0)
      dropdown_close($(this));
  });
}

function dropdown_close(button)
{
  dropdown_content_pane(button).addClass(CLS_STE_COLLAPSED);
  control_deactivate(button);
}

function dropdown_open(button)
{
  dropdown_close_unrelated(button);
  var content_pane = dropdown_content_pane(button);
  control_activate(button);
  dropdown_set_content_position(button, content_pane);
  content_pane.removeClass(CLS_STE_COLLAPSED);
  content_pane.focus();
}

function dropdown_toggle(control)
{
  control_is_active(control) ? dropdown_close(control) : dropdown_open(control);
}

function dropdown_click(event)
{
  event.stopPropagation();
  dropdown_toggle($(this))
}

function dropdown_check_if_mouse_leaves(event)
{
  var open_dropdowns = $(dot(CLS_DPD_CONTROL) + dot(CLS_CONTROL_ACTIVE));
  var open_panes = open_dropdowns.map(
    function() { return dropdown_content_pane($(this)); });

  open_panes.each(function() {
    if (! point_in_element(event.pageX, event.pageY, $(this)))
      dropdown_close(dropdown_parent($(this)));
  });
}

// MENU ITEMS

function menu_item_click(event)
{
  item = $(this);
  control_run_callback(item, CBK_ON_ACTUATE);
  dropdown_close_parent(item);
}

function menu_item_replace_dropdown_label(item)
{
  var parent = dropdown_parent(item);
  parent.text(item.text());
}

// CHECKBOX LOGIC

function all_checkboxes() { return $(dot(CLS_CKB_CONTROL)) }

function init_checkboxes()
{
  all_checkboxes().bind('click', checkbox_click);
}

function checkbox_click(event)
{
  event.stopPropagation();
  checkbox_toggle($(this))
}

function checkbox_toggle(control)
{
  control_is_active(control) ? checkbox_uncheck(control) : checkbox_check(control);
}

function checkbox_check(checkbox)
{
  control_activate(checkbox);
  control_run_callback(checkbox, CBK_ON_ACTUATE);
  checkbox.addClass(CLS_CHECKED);
}

function checkbox_uncheck(checkbox)
{
  control_deactivate(checkbox);
  control_run_callback(checkbox, CBK_ON_ACTUATE);
  checkbox.removeClass(CLS_CHECKED);
}

// RADIO BUTTON LOGIC

function all_radiobuttons() { return $(dot(CLS_RDB_CONTROL)); }
function all_radiobutton_items() { return $(dot(CLS_RDB_LIST_ITEM)); }

function init_radiobuttons()
{
  all_radiobuttons().bind('click', radiobutton_click);
  all_radiobutton_items().bind('click', radiobutton_item_click);
}

function radiobutton_click(event)
{
  radiobutton_select($(this));
}

function radiobutton_select(radiobutton)
{
  var group = radiobutton.attr(ATR_RDB_GROUP);
  control_activate(radiobutton);

  if (group)
    $(dot(CLS_RDB_CONTROL) + "[radio-group=\"" + group + "\"]").each(
      function() {
        var this_button = $(this);
        if ((this != radiobutton[0]) && control_is_active(this_button))
          radiobutton_deselect(this_button);
      })

  control_run_callback(radiobutton, CBK_ON_ACTUATE);
  radiobutton.addClass(CLS_CHECKED);
}

function radiobutton_deselect(radiobutton)
{
  control_deactivate(radiobutton);
  radiobutton.removeClass(CLS_CHECKED);
}

function radiobutton_item_click(event)
{
  var radiobutton = $(this).find(dot(CLS_RDB_CONTROL));
  if (radiobutton)
    radiobutton_select(radiobutton);
}

// ROLLUP BUTTON LOGIC

function init_rollups()
{
  $(dot(CLS_RUB_CONTROL)).bind("click", rollup_click);
}

function rollup_click(event)
{
  rollup_toggle($(this));
}

function rollup_content_pane(rollup)
{
  var target_selector = rollup.attr(ATR_RUB_TARGET);
  return $(target_selector);
}

function rollup_rolled_up(rollup)
{
  return rollup_content_pane(rollup).hasClass(CLS_STE_COLLAPSED);
}

function rollup_roll_up(rollup)
{
  rollup.removeClass(CLS_PRE_ARROW_DOWN);
  rollup.addClass(CLS_PRE_ARROW_RIGHT);
  rollup_content_pane(rollup).addClass(CLS_STE_COLLAPSED);
}

function rollup_roll_down(rollup)
{
  rollup.removeClass(CLS_PRE_ARROW_RIGHT);
  rollup.addClass(CLS_PRE_ARROW_DOWN);
  rollup_content_pane(rollup).removeClass(CLS_STE_COLLAPSED);
}

function rollup_toggle(rollup)
{
  rollup_rolled_up(rollup) ? rollup_roll_down(rollup) : rollup_roll_up(rollup);
}

// GRID 

function grid_handle_click(event)
{
  not_implemented();
}

function init_grid_rows()
{
  $(dot(CLS_GRW_CONTROL)).bind('keydown', grid_row_keypress);
  $(dot(CLS_GRW_CONTROL)).bind('click', grid_row_click);
  $(dot(CLS_GDC_FAVORITE)).bind('click', grid_favorite_click);
  $(dot(CLS_GDC_IMPORTANT)).bind('click', grid_important_click);
  $(dot(CLS_GDH_CONTROL)).bind("click", grid_handle_click);
}

function grid_row_set_current(row)
{
  $(dot(CLS_GRW_CONTROL) + dot(CLS_STE_CURRENT)).removeClass(CLS_STE_CURRENT);
  row.addClass(CLS_STE_CURRENT);
  row.find(dot(CLS_GDH_CONTROL) + ' > a').focus();
}

function grid_row_click(event)
{
  grid_row_set_current($(this));
}

function grid_row_keypress(event)
{
  switch(event.which)
  {
    case 38:
      grid_row_set_current(grid_row_previous($(this)));
      break;
    case 40:
      grid_row_set_current(grid_row_next($(this)));
      break;
  }
}

function grid_row_previous(row)
{
  var prev = row.prev();
  return (prev.length == 0) ? row : prev;
}

function grid_row_next(row)
{
  var next = row.next();
  return (next.length == 0) ? row : next;
}

function grid_favorite_click(event)
{
  $(this).toggleClass('starred');
}

function grid_important_click(event)
{
  $(this).toggleClass('important');
}

// FOLDER ITEMS

function init_folder_items()
{
  $(dot(CLS_FOL_ITEM)).bind("click", not_implemented);
}

// UTILITIES

function not_implemented()
{
  alert("OPERATION NOT IMPLEMENTED");
}

function point_in_element(x, y, element)
{
  var elem_pos = element.offset();
  return (x >= elem_pos.left) && (x <= elem_pos.left + element.width()) &&
         (y >= elem_pos.top) && (y <= elem_pos.top + element.height());
}
