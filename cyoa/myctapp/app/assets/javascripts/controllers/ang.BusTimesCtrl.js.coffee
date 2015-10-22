window.myctapp.controller('BusHomeCtrl', ['$scope', '$http', '$interval', 'Utilities', 'User', ($scope, $http, $interval, Utilities, User)->
  NO_SELECTION = "-----"

  $scope.User = User

  $scope.no_selection = NO_SELECTION
  $scope.directionList = []
  $scope.stopList = []
  $scope.routeList = []
  $scope.etaList = []
  $scope.route = {
    number: NO_SELECTION
    direction: NO_SELECTION
    stop: NO_SELECTION
  }
  $scope.busTimer = null
  $scope.activeSearch = false
  $scope.favorite_route_select = NO_SELECTION

  $scope.clearBusWatch = ()->
    $interval.cancel($scope.busTimer)
    $scope.activeSearch = false

  $scope.refreshEta = ()->
    console.log("REFRESHING")
    $scope.getEta()


  $http.get("/api/routes").then((response)->
    try
      if response.status and response.data.status is "ok"
        for route in response.data.routes
          route.label = "(#{route.route_id}) #{route.route_name}"
          $scope.routeList.push(route)
      console.error("Error occurred", error)
    # console.log("FINALLY", response)
  )

  User.authcheck(()->
    console.log("AUTHCHECK SUCCESS -- #{User.logged_in}")
    if User.loggedIn
      User.refreshFavoriteRoutes(()->
        console.info("Favorite Routes loaded", User.favoriteRoutes)
      )
      User.refreshRecentRoutes(()->
        console.info("Recent Routes loaded", User.recentRoutes)
      )
  )


  $scope.toggleFavoriteStop = ()->
    console.info("active search? #{$scope.activeSearch}")
    if $scope.activeSearch
      alertMessage = ""
      if User.loggedIn
        switch User.queueFavoriteRoute($scope.route)
          when "added"
            alertMessage = "Route has been saved to your favorite routes."
          when "removed"
            alertMessage = "Route has been removed from your favorite routes."
          else
            alertMessage = "Unable to favorite this route. Please try again later."

        console.info("FAVORITE ROUTES\n", User.favoriteRoutes)
      else
        alertMessage = "To save routes you must first <a href='/login'>login</a> to your MyCTApp account. No account? No problem, <a href='signup'>click here</a> to create one now. It'll only take a minute."
      Utilities.broadcast(window.myctapp.eventList.APP_MODAL, {
        title: "Favorite Route",
        body: "Route: <strong>#{$scope.route.stop.stop_name} going #{$scope.route.direction}</strong><br/><br/>" + alertMessage
      })


  $scope.selectFavoriteRoute = (route)->
    route = JSON.parse(route)
    console.info("USE FAVRITE ROUTE", route)
    $scope.clearBusWatch()
    $scope.directionList = []
    $scope.stopList = []
    $scope.etaList = []

    $scope.route.number = route.number
    console.info($scope.route)
    $scope.getDirections(()->
      $scope.route.direction = route.direction
      $scope.getStops(()->
        $scope.route.stop = { stop_id: route.stop_id, stop_name: route.stop_name }
        $scope.getEta()
      )
    )
    # $scope.route.direction = route.direction
    # $scope.route.stop = { stop_id: route.stop_id, stop_name: route.stop_name }
    # $scope.getEta(()->
    #   $scope.activeSearch = true
    #   # console.log("SET WATCHER")
    #   # $scope.busTimer = $interval(()->
    #   #   $scope.refreshEta()
    #   # , 10000)
    # )

  # $scope.$watch("favorite_route_select", (newVal)->
  #   $scope.clearBusWatch()
  #   console.log("ROUTE SELECT", newVal)
  #   return unless newVal
  #   $scope.directionList = []
  #   $scope.stopList = []
  #   $scope.etaList = []
  #
  #   $scope.route.number = newVal.number
  #   $scope.route.direction = newVal.direction
  #   $scope.route.stop = { stop_id: newVal.stop_id, stop_name: newVal.stop_name }
  #   $scope.getEta(()->
  #     $scope.activeSearch = true
  #     # console.log("SET WATCHER")
  #     # $scope.busTimer = $interval(()->
  #     #   $scope.refreshEta()
  #     # , 10000)
  #   )
  # )


  $scope.$watch("route.number", (newVal)->
    $scope.clearBusWatch()
    $scope.directionList = []
    $scope.stopList = []
    $scope.etaList = []
    $scope.route.direction = NO_SELECTION
    $scope.route.stop = NO_SELECTION
    return if newVal is NO_SELECTION
    $scope.getDirections(()->
      # console.log("GOT DIRECTIONS")
    )
  )

  $scope.$watch("route.direction", (newVal)->
    $scope.clearBusWatch()
    $scope.stopList = []
    $scope.etaList = []
    $scope.route.stop = NO_SELECTION
    return if newVal is NO_SELECTION
    $scope.getStops(()->
      # console.log("GOT STOPS")
    )
  )

  $scope.$watch("route.stop", (newVal)->
    return if newVal is NO_SELECTION
    $scope.clearBusWatch()
    $scope.getEta(()->
      $scope.activeSearch = true
      # console.log("SET WATCHER")
      # $scope.busTimer = $interval(()->
      #   $scope.refreshEta()
      # , 10000)
    )
  )


  $scope.getEta = (callback = false)->
    $http.get("/api/stop_eta/#{$scope.route.stop.stop_id}/#{$scope.route.number}").then((response)->
      try
        if response.status and response.data.status is "ok"
          $scope.etaList = response.data.predictions

          if callback isnt false
            callback()
      catch error
        console.error("Error occurred", error)
      # console.log("FINALLY", response)
    )

  $scope.getStops = (callback = false)->
    $http.get("/api/route_stops/#{$scope.route.number}/#{$scope.route.direction}").then((response)->
      try
        if response.status and response.data.status is "ok"
          $scope.stopList = response.data.stops

          if callback isnt false
            callback()
      catch error
        console.error("Error occurred", error)
      # console.log("FINALLY", response)
    )

  $scope.getDirections = (callback = false)->
    $http.get("/api/route_directions/#{$scope.route.number}").then((response)->
      try
        if response.status and response.data.status is "ok"
          $scope.directionList = response.data.directions

          if callback isnt false
            callback()
      catch error
        console.error("Error occurred", error)
      # console.log("FINALLY", response)
    )
])
