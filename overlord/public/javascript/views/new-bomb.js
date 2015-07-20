define(["app", "jquery", "underscore"],
function(App, $, _){
  var NewBombView = App.View.extend({
    template: App.loadTemplate('new-bomb-form'),

    render: function(){
      this.setElement(this.template());

      return this;
    }
  });

  return NewBombView;
});