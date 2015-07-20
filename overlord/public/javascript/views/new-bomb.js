define(["app", "jquery", "underscore", "lib/forms", "models/bomb"],
function(App, $, _, FormHelper, BombModel){
  var NewBombView = App.View.extend({
    template: App.loadTemplate('new-bomb-form'),

    events: {
      "click :submit": "create_bomb"
    },

    render: function(){
      this.setElement(this.template());

      return this;
    },

    create_bomb: function(event) {
      event.preventDefault();
      if (this.processing === true) {
        return;
      }
      var data = FormHelper.serialize("form");
      console.log(data);

      var bomb = new BombModel(data);

      if (!bomb.isValid()) {
        alert(bomb.validationError);
        return;
      }
      var self = this;

      bomb.save(bomb.attributes, {
        success: function(model) {
          self.$(".no-bomb-alert").remove();
        },
        error: function(response) {
          alert("Could not create bomb.");
        }
      });

    }
  });

  return NewBombView;
});