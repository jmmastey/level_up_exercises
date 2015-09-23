EvilBombApp = angular.module("EvilBombApp", []);

EvilBombApp.controller("HomeCtrl", ["$scope", "Bomb", function($scope, Bomb){
  $scope.Bomb = Bomb;
}]);

EvilBombApp.factory("Bomb", ["$http", "$interval", function($http, $interval){
  var Bomb = {};

  var BOMB_TIMER_START = 120 // 2 minutes (60 * 2)

  Bomb.state = "Awaiting Deployment..."; 
  Bomb.active = false;
  Bomb.deployed = false;
  Bomb.attemptsRemaining = 3;
  Bomb.exploded = false;
  Bomb.busy = false;
  Bomb.timerCount = 0;
  Bomb.timerId = null;

  Bomb.isActive = function(){
    return true === Bomb.active;
  };

  Bomb.isDeployed = function(){
    return true === Bomb.deployed;
  }

  Bomb.setState = function(bombState){
    switch(bombState.toLowerCase()){
      case "inactive":
        Bomb.active = false;
        Bomb.state = "ready for activation"
        Bomb.clearCountdown();
        console.info("-- Bomb Deactivated --");
        break;
      case "active":
        if (Bomb.isActive()) break;
        Bomb.active = true;
        Bomb.state = "activated"
        Bomb.startCountdown();
        console.info("-- Bomb Activated --");
        break;
      case "exploded":
        Bomb.active = false;
        Bomb.exploded = true;
        Bomb.state = "exploded";
        console.info("-- Bomb Exploded --");
        $http.get("/explode").success(function(data){
          console.log("EXPLODE GET", data);
        });
        break
    }
  }

  Bomb.deploy = function(formData){
    if (formData.activateCode && formData.deactivateCode) {
      $http.post("/deploy", formData).success(function(data) {
        if (data.status && data.status == 200) {
          Bomb.setState(data.state);
          Bomb.deployed = true;
          console.info(
            "-- Bomb Deployed --\nActivation Code:\t%s\nDeactivation Code:\t%s", 
            formData.activateCode,
            formData.deactivateCode
          )
        }
      });
    }
  };

  Bomb.activate = function(codeInput){
    $http.post("/activate", { code: codeInput }).success(function(data){
      Bomb.attemptsRemaining = (data.max_attempts - data.attempts)
      if (data.status && data.status == 200) {
        Bomb.setState(data.state);
      }
    });
  };

  Bomb.deactivate = function(codeInput){
    if (!Bomb.busy && Bomb.attemptsRemaining > 0) {
      Bomb.busy = true;
      $http.post("/deactivate", { code: codeInput }).success(function(data){
        Bomb.attemptsRemaining = (data.max_attempts - data.attempts)
        if (data.status && data.status == 200) {
          Bomb.setState(data.state);
        }
        Bomb.busy = false;
      });
    }
  };

  Bomb.startCountdown = function() {
    Bomb.timerCount = BOMB_TIMER_START;
    Bomb.timerId = $interval(function(){
      Bomb.timerCount--;
      if (Bomb.timerCount <= 0) {
        Bomb.timerCount = 0;
        Bomb.clearCountdown();
        Bomb.setState("exploded");
      }
    }, 1000)
  };

  Bomb.clearCountdown = function() {
    if (Bomb.timerId != null) {
      $interval.cancel(Bomb.timerId);
      Bomb.timerId = null;
    }
  };

  return Bomb;
}]);

EvilBombApp.directive("restrict", function($parse){
  return {
    restrict: "A",
    require: "ngModel",
    link: function(scope, el, attrs, ctrl) {
      scope.$watch(attrs.ngModel, function(val){
        if(!val) return
        $parse(attrs.ngModel).assign(scope, val.replace(new RegExp(attrs.restrict, "g"), ""));
      });
    }
  };
});

// function getNumSecondsLeft(timerEnd) {
//   var now = Math.floor(new Date().getTime() / 1000);
//   if (timerEnd - now <= 0) {
//     return 0;
//   } else {
//     return (timerEnd - now);
//   }
// }

// function getTimeString(seconds) {
//   var mins = Math.floor(seconds / 60);
//   var secs = seconds - (mins * 60);
//   var timeString = '0' + mins + ':';
//   if (secs < 10) {
//     timeString = timeString + '0' + secs;
//   } else {
//     timeString = timeString + secs;
//   }
//   return timeString;
// }
