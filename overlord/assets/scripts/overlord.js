EvilBombApp = angular.module("EvilBombApp", []);

EvilBombApp.controller("HomeCtrl", ["$scope", "Bomb", function($scope, Bomb){
  $scope.Bomb = Bomb;
}]);

EvilBombApp.factory("Bomb", ["$http", "$timeout", function($http, $timeout){
  var Bomb = {};

  var BOMB_TIMER_START = 120 // 2 minutes (60 * 2)
  var BOMB_DEACTIVATE_FAIL_PERCENT = 45; // percentage to increase detonation speed if fail attempt

  Bomb.state = "Awaiting Deployment..."; 
  Bomb.active = false;
  Bomb.deployed = false;
  Bomb.attemptsRemaining = 3;
  Bomb.exploded = false;
  Bomb.busy = false;
  Bomb.timerId = null;
  Bomb.refreshId = null;
  Bomb.detonateTime = -1;
  Bomb.timeoutRate = 1000; // 1 second
  Bomb.increasedRate = 0;
  Bomb.serverResponse = "";

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
        Bomb.state = "activated";
        Bomb.timeoutRate = 1000;
        Bomb.increasedRate = 0;
        Bomb.checkDetonation();
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
    Bomb.serverResponse = "";
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
        else {
          Bomb.serverResponse = data.error;
        }
      });
    }
  };

  Bomb.activate = function(codeInput){
    Bomb.serverResponse = "";
    var postData = {
      code: codeInput, 
      time: BOMB_TIMER_START
    };

    $http.post("/activate", postData).success(function(data){
      Bomb.attemptsRemaining = (data.max_attempts - data.attempts)
      if (data.status && data.status == 200 && data.detonation_time) {
        Bomb.detonateTime = Math.round(data.detonation_time);
        Bomb.setState(data.state);
      }
      else {
        Bomb.serverResponse = data.error;
      }
    });
  };

  Bomb.deactivate = function(codeInput){
    Bomb.serverResponse = "";
    if (!Bomb.busy && Bomb.attemptsRemaining > 0) {
      Bomb.busy = true;
      $http.post("/deactivate", { code: codeInput }).success(function(data){
        Bomb.attemptsRemaining = (data.max_attempts - data.attempts)
        if (data.status && data.status == 200) {
          Bomb.setState(data.state);
        }
        else {
          // console.warn("!@#$ !@#$");
          // Bomb.increasedRate = BOMB_DEACTIVATE_FAIL_PERCENT * (data.max_attempts - Bomb.attemptsRemaining)
          // console.warn("WARNING -- RATE OF DETONATION INCREASED %s%", Bomb.increasedRate);
          // Bomb.timeoutRate -= (Bomb.timeoutRate * (Bomb.increasedRate / 100));

          page = angular.element(document.querySelector("#bomb-wrap"));
          page.addClass("shake");
          $timeout(function(){
            page.removeClass("shake");
          }, 400);
        }
        Bomb.busy = false;
      });
    }
  };

  Bomb.checkDetonation = function() {
    Bomb.timerId = $timeout(function(){
      Bomb.detonate();
      if (Bomb.detonateTime >= 0) {
        Bomb.checkDetonation();
      }
    }, Bomb.timeoutRate);
  };

  Bomb.detonate = function() {
    Bomb.detonateTime--;
    if (Bomb.detonateTime <= 0) {
      Bomb.detonateTime = -1;
      Bomb.clearCountdown();
      Bomb.setState("exploded");
    }
  }

  Bomb.clearCountdown = function() {
    $timeout.cancel(Bomb.timerId);
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

EvilBombApp.filter('detonateTimeText', function() {
  return function(input) {
    if (!input) return
    var mins = Math.floor(input / 60);
    var secs = input - (mins * 60);
    return leadingZero(mins) + ":" + leadingZero(secs);
  };
});

function leadingZero(number) {
  return ("0" + number).slice(-2);
}
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
