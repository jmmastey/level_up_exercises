window.myctapp.factory('Utilities', ['$rootScope', ($rootScope)->
  Utilities = {}

  Utilities.broadcast = (eventName, data = {})->
    $rootScope.$broadcast(eventName, data)

  Utilities
])
