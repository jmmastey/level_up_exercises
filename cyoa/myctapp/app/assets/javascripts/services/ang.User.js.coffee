window.myctapp.factory('User', ['Utilities', '$http', (Utilities, $http)->
  User = {}

  User.loggedIn = false
  User.favoriteRoutes = []
  User.recentRoutes = []

  User.authcheck = (callback = false)->
    $http.get("/api/authcheck").then((response)->
      try
        if response.data.status is "ok"
          User.loggedIn = response.data.logged_in
        else
          User.loggedIn = false
      catch error
        console.warn("Auth error", error)
        User.loggedIn = false

      if callback isnt false
        callback()
    )

  User.refreshFavoriteRoutes = (callback = false)->
    $http.get("/api/user/favorite_routes").then((response)->
      try
        if response.data.status is "ok"
          User.loggedIn = true
          # console.log("FAVORITES", response.data.favorite_routes)
          User.favoriteRoutes = response.data.favorite_routes
        else
          User.loggedIn = false
          User.favoriteRoutes = []
      catch error
        console.warn("Favorite route refresh error", error)
        User.loggedIn = false
        User.favoriteRoutes = []

      if callback isnt false
        callback()
    )

  User.refreshRecentRoutes = (callback = false)->
    $http.get("/api/user/recent_routes").then((response)->
      try
        if response.data.status is "ok"
          User.loggedIn = true
          User.recentRoutes = response.data.recent_routes
        else
          User.loggedIn = false
          User.recentRoutes = []
      catch error
        console.warn("Favorite route refresh error", error)
        User.loggedIn = false
        User.recentRoutes = []

      if callback isnt false
        callback()
    )

  User.favoriteRouteIndex = (routeId)->
    return User.favoriteRoutes

  User.queueFavoriteRoute = (route)->
    console.info(User.hasFavorite(route.stop.stop_id))
    unless User.hasFavorite(route.stop.stop_id)
      return "added" if User.addFavorite(route)
    else
      return "removed" if User.removeFavorite(route)
    return false
    # User.removeFavorite(route)
    # return "removed" if User.removeFavorite(routeId)
    # console.log("NOT REMOVED")
    # return "added" if User.addFavorite(routeId)
    # console.log("NOT ADDED")
    # return false

  User.hasFavorite = (routeId)->
    try
      return User.favoriteRoutes.some((element, index, array)->
        # console.info("(" + element.stop_id + " == " + this.routeId + ")\n", element.stop_id == this.routeId)
        element.stop_id == this.routeId
      , { routeId: routeId })
    catch error
    false

  User.addFavorite = (route)->
    console.info("ADDING")
    $http.patch("/api/user/save_favorite", route).then((response)->
      try
        if response.data.status is "ok"
          User.favoriteRoutes = response.data.favorite_routes
          console.log("ROUTES:", User.favoriteRoutes)
          return true
      catch error
        console.warn("Unable to add favorite route", error)
      false
    )

  User.removeFavorite = (route)->
    console.info("REMOVING")
    $http.patch("/api/user/remove_favorite", route).then((response)->
      try
        if response.data.status is "ok"
          User.favoriteRoutes = response.data.favorite_routes
          console.log("ROUTES:", User.favoriteRoutes)
          return true
      catch error
        console.warn("Unable to remove favorite route", error)
      false
    )

  User
])
