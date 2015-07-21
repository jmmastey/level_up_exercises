define(["app", "jquery", "underscore"],
function(App, $, _){
  "use strict";
  var BombModel = App.Model.extend({
    url: "bomb",
    
    defaults: {
      activation_code: "0000",
      deactivation_code: "0000"
    },

    validate: function (attributes) {
      var errors = [];
      if (_.isUndefined(attributes.activation_code) ||
          attributes.activation_code.match(/^\d{4}$/)) {
        errors.push("Activation code is required and must be 4 numbers");
      }

      if (_.isUndefined(attributes.deactivation_code) ||
          !attributes.deactivation_code.match(/^\d{4}$/)) {
        errors.push("Deactivation code is required and must be 4 numbers");
      }
      
      if (errors.length) {
        return "- " + errors.join("\n- ");
      }
    }
  });


  return BombModel;
});