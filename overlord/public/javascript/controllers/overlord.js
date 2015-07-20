define(function(require){

  var BaseApp = require("app");
  var NewBombView = require("views/new-bomb");

  var OverlordController = BaseApp.Controller.extend({
    initialize: function(){
      this.setElement($("#page"));
    },

    actions: {
      new_bomb: function(){
        this.view = new NewBombView();
      }
    }
  });

  return OverlordController;

});