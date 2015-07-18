require.config({
    baseUrl: "javascript/",
    paths: {
      "jquery": "vendor/jquery",
      "backbone": "vendor/backbone",
      "handlebars": "vendor/handlebars",
      "underscore": "vendor/underscore"
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


require(["jquery", "app"],
function($, App){
 var app = new App.Controller();

 app.start();
});