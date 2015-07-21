define(["app", "jquery", "underscore", "lib/forms", "models/bomb"],
  function (App, $, _, FormHelper, BombModel) {
    "use strict";
    var NewBombView = App.View.extend({
      template: App.loadTemplate("new-bomb-form"),

      events: {
        "click :submit": "create_bomb"
      },

      render: function () {
        this.setElement(this.template());

        return this;
      },

      create_bomb: function (event) {
        event.preventDefault();
        if (this.processing === true) {
          return;
        }
        var data = FormHelper.serialize("form");

        var bomb = new BombModel(data);

        if (!bomb.isValid()) {
          alert(bomb.validationError);
          return;
        }
        this.processing = true;

        var self = this;

        bomb.save(bomb.attributes, {
          success: function (model) {
            self.processing = false;

            if (model.get("error") === true) {
              alert("Activation and/or Deactivation code invalid");
              return;
            }

            App.events.trigger("render-view", "existing_bomb");
          },
          error: function () {
            self.processijng = false;
            alert("Could not create bomb.");
          }
        });

      }
    });

    return NewBombView;
});