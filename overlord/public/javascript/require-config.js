require.config({
    baseUrl: "javascript/",
    paths: {
      "jquery": "vendor/jquery",
      "backbone": "vendor/backbone",
      "handlebars": "vendor/handlebars",
      "underscore": "vendor/underscore",
      "app": "app"
    },

    shim: {
      backbone: {
        deps: ['jquery', 'underscore'],
        exports: 'Backbone'
      },
      underscore: {
        exports: '_'
      },
      jquery: {
        exports: '$'
      }
    }
});


require(["jquery", "controllers/overlord"],
function($, App){
  var app = new App();
  app.start();
});