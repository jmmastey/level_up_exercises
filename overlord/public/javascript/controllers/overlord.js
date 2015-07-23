define(function(require){
  "use strict";
  var BaseApp = require("app");
  var NewBombView = require("views/new-bomb");
  var ExistingBombView = require("views/existing-bomb");
  var ExplodedView = require("views/exploded-bomb");

  var OverlordController = BaseApp.Controller.extend({
    initialize: function(){
      this.setElement($("#page"));
    },

    actions: {
      new_bomb: function(){
        this.view = new NewBombView();
      },
      existing_bomb: function() {
        this.view = new ExistingBombView();
      },
      explode: function() {
        this.view = new ExplodedView();
      }
    }
  });

  return OverlordController;

});