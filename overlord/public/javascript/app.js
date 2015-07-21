define(function(require){

  var $ = require("jquery"),
      _ = require("underscore"),
      Backbone = require("backbone"),
      Handlebars = require("handlebars");

  
  var App = _.extend({}, {
    templates: {},
    events: _.extend({}, Backbone.Events),

    loadTemplate: function(template){
      if (!_.isUndefined(this.templates[template])) {
        return this.templates[template];
      }

      var normalizedTemplate = template.replace(/\./g, '/');
      var self = this;

      $.ajax({
        url: 'javascript/templates/' + normalizedTemplate + '.handlebars',
        type: 'GET',
        async: false,
        success: function(response) {
          self.templates[template] = Handlebars.compile(response);
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
    defaultView: 'index',
    actions: {},
    view: null,

    start: function(){
      this.listenTo(App.events, "render-view", this.renderView);

      var viewName = 'new_bomb';
      if (!_.isUndefined(haveBomb) && haveBomb !== false) {
        viewName = 'existing_bomb';
      }

      this.renderView(viewName);
    },

    renderView: function(viewName) {
      if (!_.isNull(this.view)) {
        this.view.remove();
      }
      this.actions[viewName].call(this);

      this.$el.html(this.view.render().el);
    }
  });

  App.View = Backbone.View.extend({

  });

  App.Model = Backbone.Model.extend({
    fetchWait: function(){
      var self = this;
      
      $.ajax({
        url: this.url() + this.id,
        type: 'GET',
        async: false,
        success: function(attributes) {
          self.set(attributes);
        },
        error: function(response) {
          alert("Could not load model");
        }
      });
    }
  });

  App.Collection = Backbone.Collection.extend({

  });

  return App;
});