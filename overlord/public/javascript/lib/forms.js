define(["jquery", "underscore"],
function($, _){
  "use strict";
  var forms = {
    serialize: function(element){
      var data = {};
      
      _.each($(element).serializeArray(), function(element){
        data[element.name] = element.value;
      });

      return data;
    }
  };

  return forms;

});