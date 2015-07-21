define(["app", "jquery", "underscore", "lib/forms", "models/bomb"],
function(App, $, _, FormHelper, BombModel){
  var BombView = App.View.extend({
    template: App.loadTemplate('bomb'),

    initialize: function(options){
      this.bomb = new BombModel();
      this.bomb.fetchWait();
    },

    render: function(){
      var data = this.bomb.attributes;

      data.status = data.status.toUpperCase();

      if (data.timer == 0) {
        data.timer = '00:00';
      }

      this.setElement(this.template(data));

      return this;
    }

  });

  return BombView;
});