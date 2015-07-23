define(function(require){
  "use strict";

  var $ = require("jquery"),
      App = require("app"),
      BombModel = require("models/bomb"),
      KeypadView = require("views/keypad");

  var BombView = App.View.extend({
    template: App.loadTemplate("bomb"),

    initialize: function () {
      this.bomb = new BombModel();
      this.bomb.fetchWait();

      if (this.bomb.exploded()) {
        this.triggerView("new_bomb");
      }

      this.listenTo(App.events, "bomb.explode", this.explode);
    },

    events: {
      "click input[type='button']": "button_action"
    },

    render: function(){
      var data = this.bomb.attributes;

      data.status = data.status.toUpperCase();

      if (data.timer === 0) {
        data.timer = "00:00";
      }

      this.setElement(this.template(data));

      if (data.timer !== 0 && data.status == "armed") {
        this.start_timer();
      }

      return this;
    },

    update_status: function(status) {
      $(".status").text(status.toUpperCase());
    },

    start_timer: function(){
      var seconds = this.bomb.get("timer") - parseInt(Date.now() / 1000);
      this.bomb.set({seconds: seconds});

      if (seconds < 0) {
        return;
      }

      var time_details = this.get_minutes_and_seconds(seconds);

      this.$timer = $("#timer p");
      this.$timer.text(time_details.minutes + ":" + time_details.seconds);

      var self = this;
      this.timerId = window.setInterval(function(){
        self.update_timer.call(self);
      }, 1000);
    },

    get_minutes_and_seconds: function(seconds) {
      var minutes = parseInt(seconds / 60);
      if (minutes < 10) {
        minutes = "0" + minutes;
      }
      seconds = seconds % 60;
      if (seconds < 10) {
        seconds = "0" + seconds;
      }
      return {
        minutes: minutes,
        seconds: seconds
      };
    },

    update_timer: function() {
      var current_time = this.bomb.get("seconds");
      current_time--;

      if (current_time < 0) {
        this.stop_timer();
        this.bomb.explode();
        return;
      }


      this.bomb.set({seconds: current_time});

      var time_details = this.get_minutes_and_seconds(current_time);
      this.$timer.text(time_details.minutes + ":" + time_details.seconds);
    },

    stop_timer: function() {
      clearInterval(this.timerId);
      this.timerId = null;
    },

    deactivate_timer: function() {
      this.stop_timer();
      this.$timer.text("99:99");
    },

    button_action: function(event) {
      var $button = $(event.target);
      App.events.trigger("keypad.close");

      if (this.bomb.deactive()) {
        return;
      }

      if ($button.val().toLowerCase() == "activate" && this.bomb.armed()) {
        return;
      }

      this.view = new KeypadView($button.val());
      this.view.render();

      this.actions[$button.val().toLowerCase()].call(this);
    },

    activate_bomb: function(activation_code) {
      this.bomb.set({activation_code: activation_code});
      if (!this.bomb.activate()) {
        return;
      }
      this.update_status(this.bomb.get("status"));
      this.start_timer();  
    },

    deactivate_bomb: function(deactivation_code) {
       this.bomb.set({deactivation_code: deactivation_code});
       if (!this.bomb.deactivate()) {
         if (this.bomb.reached_attempt_limit()) {
          this.bomb.explode();
         }
         return;
       }

       this.update_status(this.bomb.get("status"));
       this.deactivate_timer();
    },

    explode: function() {
      this.stop_timer();
      this.triggerView("explode");
    },

    actions: {
      activate: function(){
        this.listenToOnce(App.events, "keypad.value", this.activate_bomb);
      },

      deactivate: function(){
        this.listenToOnce(App.events, "keypad.value", this.deactivate_bomb);
      }
    }
  });

  return BombView;
});