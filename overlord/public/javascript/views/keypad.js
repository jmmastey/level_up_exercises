define(["app", "jquery"],
function(App, $){
  "use strict";

  var KeypadView = App.View.extend({
    template: App.loadTemplate("keypad"),

    initialize: function() {
      this.listenTo(App.events, "keypad.close", "this.remove");
    },

    events: {
      "click .key": "update_display",
      "click :submit": "save_results"
    },

    render: function() {
      // Just make sure keypad is not rendered already
      $("#keypad").remove(); 
      
      this.setElement(this.template());
      $("body").append(this.el);
    },

    update_display: function(event) {
      var $display = this.$("#display");

      if ($display.text().length == 4) {
        return;
      }

      var $button = $(event.target);
      
      if (!$button.val().match(/\d/)) {
        return;
      }

      $display.text($display.text() + $button.val());
    },

    save_results: function() {
      App.events.trigger("keypad.value", $("#display").text());
      this.remove();
    }

  });

  return KeypadView;
});