window.myctapp.filter('estimatedTime', ()->
  (time_int)->
    if time_int > 2
      return "#{time_int} Minutes"
    else if time_int <= 2 and time_int.length != 0
      return "Approaching"
    else
      return "--"
)

# tacchiMediaApp.filter('cleanDate', function() {
#   return function(anUglyDate) {
#     var date;
#     if (anUglyDate) {
#       anUglyDate = anUglyDate !== void 0 ? anUglyDate : "";
#       if (anUglyDate.indexOf(':') === -1) {
#         date = anUglyDate.split('-');
#         return "" + date[1] + "/" + date[2] + "/" + date[0];
#       } else {
#         return anUglyDate;
#       }
#     } else {
#       return "";
#     }
#   };
# });
