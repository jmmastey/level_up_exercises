define(["app", "jquery", "underscore"],
function(App, $, _){
  "use strict";
  var BombModel = App.Model.extend({
    url: "bomb",
    defaults: {
      activation_code: "0000",
      deactivation_code: "0000",
      attempts: 0
    },

    validate: function (attributes) {
      var errors = [];
      if (_.isUndefined(attributes.activation_code) ||
          !attributes.activation_code.match(/^\d{4}$/)) {
        errors.push("Activation code is required and must be 4 numbers");
      }

      if (_.isUndefined(attributes.deactivation_code) ||
          !attributes.deactivation_code.match(/^\d{4}$/)) {
        errors.push("Deactivation code is required and must be 4 numbers");
      }
      
      if (errors.length) {
        return "- " + errors.join("\n- ");
      }
    },

    action: function(method, data) {
      var errorStatus = false;
      var self = this;

      $.ajax({
        url: "bomb/" + method,
        type: "POST",
        data: JSON.stringify(data),
        dataType: "json",
        async: false,
        contentType: "application/json",
        success: function(response){
          if (!_.isUndefined(response.error) && response.error === true) {
            errorStatus = true;
            alert("Invalid code");
          }
          else {
            self.set(response);
          }
        },
        error: function(response) {
          console.log(response);
          alert("Could not determine if code was correct.");
          errorStatus = true;
        }
      });

      return !errorStatus;
    },

    activate: function() {
      var data = {
        activation_code: this.get("activation_code")
      };
      return this.action("activate", data);
    },

    deactivate: function() {
      var data = {
        deactivation_code: this.get("deactivation_code")
      };
      var result = this.action("deactivate", data);

      if (result === false) {
        this.increment_failed_deactivate_attempts();
      }

      return result;
    },

    increment_failed_deactivate_attempts: function() {
      var attempts = this.get("attempts");
      attempts++;
      this.set({attempts: attempts});
    },

    reached_attempt_limit: function() {
      return this.get("attempts") == 3;
    },

    deactive: function() {
      return this.get("status") == "deactivated";
    },

    explode: function() {
      this.set({status: "exploded"});

      var data = {
        explode_pin: this.get("pin")
      };

      $.ajax({
        url: "bomb/explode",
        type: "POST",
        data: JSON.stringify(data),
        dataType: "JSON",
        contentType: "application/json",
        success: function(response) {
          if (!_.isUndefined(response.error) && response.error === true) {
            return; // Wrong explosion pin
          }
          App.events.trigger("bomb.explode");
        }
      });
    },

    exploded: function() {
      return this.get("status") == "exploded";
    },

    armed: function() {
      return this.get("status") == "armed";
    }
  });

  return BombModel;
});