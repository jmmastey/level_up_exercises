define(["app", "jquery", "underscore", "lib/forms", "models/bomb"],
function(App, $, _, FormHelper, BombModel){
  "use strict";

  var BombView = App.View.extend({
    template: App.loadTemplate("bomb"),

    initialize: function () {
      this.bomb = new BombModel();
      this.bomb.fetchWait();
    },

    events: {
      "click input[type='button']": "button_action"
    },

    render: function(){
      var data = this.bomb.attributes;

      data.status = data.status.toUpperCase();

      if (data.timer === 0) {
        data.timer = "00:00";
      }

      this.setElement(this.template(data));

      return this;
    },

    button_action: function(event) {
      var $button = $(event.target);
      this.actions[$button.val().toLowerCase()].call(this);
    },

    actions: {
      activate: function(){
        
      }
    }
  });

  return BombView;
});