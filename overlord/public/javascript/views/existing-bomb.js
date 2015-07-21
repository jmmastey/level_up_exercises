define(["app", "jquery", "underscore", "lib/forms", "models/bomb"],
function(App, $, _, FormHelper, BombModel){
  var BombView = App.View.extend({
    template: App.loadTemplate('bomb'),

    initialize: function(options){
    },

    render: function(){
      var data = {};
      this.setElement(this.template(data));

      return this;
    }

  });

  return BombView;
});