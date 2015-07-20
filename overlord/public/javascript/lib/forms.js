define(["jquery", "underscore"],
function($, _){

  var forms = {
    serialize: function(element){
      var data = {};
      
      _.each($(element).serializeArray(), function(element, index){
        data[element.name] = element.value;
      });

      return data;
    }
  }

  return forms;

});