define(function(require){

  var $ = require("jquery"),
      _ = require("underscore"),
      Backbone = require("backbone"),
      Handlebars = require("handlebars");

  var App = _.extend({}, {
    templates: {},
    events: _.extend({}, Backbone.Events),

    getTemplate: function(template) {
      var normalizedTemplate = template.replace(/\./g, '/');

      if (!_.isUndefined(this.templates[template])) {
        return this.templates[template];
      }

      var self = this;

      $.ajax({
        url: 'javascripts/templates' + normalizedTemplate + '.handlebars',
        type: 'GET',
        async: false,
        success: function(response) {
          self.templates[templates] = Handlebars.compile(response);
        },
        error: function(response) {
          console.log("Could not load: " + template);
          console.log(response);
        }
      });

      return this.templates[template];
    }
  });

  App.Controller = Backbone.View.extend({
    start: function(options) {
      
    }
  });

  return App;
});