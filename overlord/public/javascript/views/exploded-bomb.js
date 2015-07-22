define(function(require){
  "use strict";

  var App = require("app");

  var BombView = App.View.extend({
    template: App.loadTemplate("exploded-bomb"),

    initialize: function () {
    },

    render: function(){

      this.setElement(this.template());

      return this;
    }
  });

  return BombView;
});