//= require jquery/dist/jquery
//= require angular/angular
//= require angular-google-maps/dist/angular-google-maps
//= require lodash/lodash
//= require jquery-timeago
//= require twitter-text-js/js/twitter-text

//= require_self
//= require_tree .

angular.module('TweetMapper', [
    'uiGmapgoogle-maps'
  ])
  .config(function(uiGmapGoogleMapApiProvider) {
    uiGmapGoogleMapApiProvider.configure({
      key: 'AIzaSyAi5FSBSe5ghOhpYOgZaWGCARZcjPrLYMs',
      libraries: 'geometry'
        // transport: 'https',
        // isGoogleMapsForWork: false,
        // china: false,
        // v: '3',]
        // language: 'en',
        // sensor: 'false'
    });
  })
  .controller('AppCtrl', function($scope, $http, uiGmapIsReady) {
    var map_refresh_interval_seconds = 15;
    var marker_limit = 100;
    var map_refresh_delay_seconds = 0.5; // seconds to wait until a map refresh is initiated
    var zoom_level = 14;

    var active_tweet_id = null;
    var infowindow = null;
    var map = null;
    var markers = [];
    var refresh_is_queued = false;
    var refresh_interval = null;
    var refresh_timeout = null;

    var display_errors = function(errors) {
      errors = typeof errors !== 'undefined' ? errors : [];
      if (!errors.isArray) {
        errors = [errors];
      }
      alert('ERROR: ' + errors.join("\n"));
    };

    var queue_refresh = function() {
      clearTimeout(refresh_timeout);
      refresh_timeout = setTimeout(get_tweets, map_refresh_delay_seconds * 1000);
    };

    var refresh_map_refresh_interval = function() {
      clearInterval(refresh_interval);
      refresh_interval = setInterval(function() {
        get_tweets();
      }, map_refresh_interval_seconds * 1000);
    };

    var get_tweets = function() {
      if (map) {
        refresh_map_refresh_interval();
        var center = map.getCenter();
        $http.post('/tweets/latest', {
          center: {
            lat: center.lat(),
            lng: center.lng()
          },
          miles_radius: map_radius_in_miles()
        }).success(function(response) {
          if (response.messages.length > 0) {
            display_errors(response.messages);
          } else {
            refresh_tweets(response.data);
          }
        }).error(function() {
          display_errors('There was a problem updating your session. Please contact a site administrator.');
        });
      }
    };

    var map_radius_in_miles = function() {
      var bounds = map.getBounds();
      var sw = bounds.getSouthWest();
      var ne = bounds.getNorthEast();
      var nw = new google.maps.LatLng(sw.lat(), ne.lng());
      var se = new google.maps.LatLng(ne.lat(), sw.lng());

      var distance_horizontal = google.maps.geometry.spherical.computeDistanceBetween(ne, nw);
      var distance_vertical = google.maps.geometry.spherical.computeDistanceBetween(ne, se);
      var radius_as_meters = distance_horizontal > distance_vertical ? distance_vertical : distance_horizontal;
      var radius_as_miles = (radius_as_meters / 2) * 0.000621371192;

      return radius_as_miles;
    };

    var refresh_tweets = function(tweets) {
      tweets = typeof tweets !== 'undefined' ? tweets : [];
      clear_all_markers();
      for (var i = 0; i < tweets.length; i++) {
        create_marker(tweets[i]);
      }
    };

    var create_marker = function(tweet) {
      var marker = new google.maps.Marker({
        icon: marker_icon(tweet.tweet_created_at),
        map: map,
        position: new google.maps.LatLng(tweet.latitude, tweet.longitude),
        title: $.timeago(tweet.tweet_created_at) + ': @' + tweet.author_screen_name + ': ' + tweet.tweet_text,
        tweet_id_from_twitter: tweet.tweet_id_from_twitter,
        tweet_created_at: tweet.tweet_created_at
      });
      bind_info_window(marker, infowindow_content(tweet));
      markers.push(marker);
    };

    var marker_icon = function(timestamp) {
      timestamp = typeof timestamp !== 'undefined' ? timestamp : new Date();

      var minutes_ago = Math.floor((new Date() - new Date(timestamp)) / 1000 / 60);
      if (minutes_ago <= 20) {
        hex = 'f3443c';
      } else if (minutes_ago <= 60) {
        hex = 'e1544e';
      } else if (minutes_ago <= 120) {
        hex = 'ce6560';
      } else if (minutes_ago <= 240) {
        hex = 'aa8785';
      } else {
        hex = '979797';
      }
      return 'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|' + hex;
    };

    var clear_all_markers = function() {
      var new_markers = [];
      for (var i = 0; i < markers.length; i++) {
        if (markers[i].tweet_id_from_twitter != active_tweet_id) {
          google.maps.event.clearInstanceListeners(markers[i]);
          markers[i].setMap(null);
        } else {
          new_markers = [markers[i]];
        }
      }
      markers = new_markers;
    };

    var bind_info_window = function(marker, content) {
      content = typeof content !== 'undefined' ? content : '';
      google.maps.event.addListener(marker, 'click', function() {
        infowindow.setContent(content);
        infowindow.open(map, marker);
        active_tweet_id = marker.tweet_id_from_twitter;
      });
    };

    var infowindow_content = function(tweet) {
      var output = '<div class="infowindow">';
      output += '<span class="author_name">' + tweet.author_name + '</span> ';
      output += '<a class="author_screen_name" href="https://twitter.com/' + tweet.author_screen_name + '" target="_blank">@' + tweet.author_screen_name + '</a>' + "\n";
      output += '<p class="tweet_text">' + autolink_tweet(tweet.tweet_text) + '</p>';
      output += '<span class="tweet_created_at">' + $.timeago(tweet.tweet_created_at) + '</span>';
      output += '</div>';
      return output;
    };

    var autolink_tweet = function(tweet) {
      return twttr.txt.autoLink(tweet, {
        targetBlank: true
      });
    };

    var render_map = function(latitude, longitude) {
      latitude = typeof latitude !== 'undefined' ? latitude : 51.219053;
      longitude = typeof longitude !== 'undefined' ? longitude : 4.404418;

      infowindow = new google.maps.InfoWindow({
        content: ""
      });
      $scope.map = {
        center: {
          latitude: latitude,
          longitude: longitude
        },
        pan: false,
        zoom: zoom_level
      };
      uiGmapIsReady.promise().then(function(maps) {
        map = maps[0].map;
        map.bounds_changed = queue_refresh;
        map.center_changed = queue_refresh;
        get_tweets();
      });
    };

    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        render_map(position.coords.latitude, position.coords.longitude);
      }, function() {
        render_map();
      });
    }
  });