"use strict";

$(document).ready(function(){
  globals.removeNotice($(".notice"));
});


var globals = _.extend({}, {
  removeNotice: function($element, timeout, easing) {
    if (!$element.length) {
      return;
    }
    timeout = timeout || 3000;
    easing = easing || 1000;
    setTimeout(function(){
      $element.fadeToggle(easing);
    }, timeout);
  }
});