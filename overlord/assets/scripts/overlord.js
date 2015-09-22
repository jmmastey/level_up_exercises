EvilBombApp = angular.module("EvilBombApp", []);

EvilBombApp.controller("HomeCtrl", ["$scope", "Bomb", function($scope, Bomb){
  $scope.Bomb = Bomb;
}]);

EvilBombApp.factory("Bomb", ["$http", function($http){
  var Bomb = {};

  Bomb.state = "Awaiting Deployment..."; 
  Bomb.active = false;
  Bomb.deployed = false;
  Bomb.attemptsRemaining = 3;
  Bomb.codeActivate = "0000";
  Bomb.codeDeactivate = "1234";
  Bomb.exploded = false;
  Bomb.busy = false;

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
        console.info("-- Bomb Deactivated --");
        break;
      case "active":
        Bomb.active = true;
        Bomb.state = "activated"
        console.info("-- Bomb Activated --");
        break;
      case "exploded":
        Bomb.active = false;
        Bomb.exploded = true;
        Bomb.state = "exploded"
        console.info("-- Bomb Exploded --");
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
    console.log("! Activating...");
    $http.post("/activate", { code: codeInput }).success(function(data){
      Bomb.attemptsRemaining = (data.max_attempts - data.attempts)
      if (data.status && data.status == 200) {
        Bomb.setState(data.state);
        console.info("-- Bomb Activated --");
      }
    });
  };

  Bomb.deactivate = function(codeInput){
    if (!Bomb.busy && Bomb.attemptsRemaining > 0) {
      Bomb.busy = true;
      console.log("ATTEMPTING DEACTIVATION...");
      $http.post("/deactivate", { code: codeInput }).success(function(data){
        Bomb.attemptsRemaining = (data.max_attempts - data.attempts)
        if (data.status && data.status == 200) {
          Bomb.setState(data.state);
        }
        Bomb.busy = false;
      });
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

// var deactivated = true;

// function submitCode() {
//   var code = $('input').val();
//   var json = {'code':code};
//   $.ajax({
//     url: '/',
//     type: 'POST',
//     data: json,
//     success: function(data) {
//       var jsonData = JSON.parse(data);
//       analyzeData(jsonData);
//       $('#codeForm')[0].reset();
//     }
//   });
// }

// function analyzeData(jsonObj) {
//   if (jsonObj.status == 200) {
//     hideWarning();
//     if (jsonObj.state == 'Activated') {
//       activatedUpdates(jsonObj);
//     } else if (jsonObj.state == 'Deactivated') {
//       deactivatedUpdates();
//     } else { // Exploded
//       explodedUpdates();
//     }
//   } else if (jsonObj.status == 401) {
//     showInvalid();
//     if (jsonObj.state == 'Activated') {
//       activatedUpdates(jsonObj);
//     } else if (jsonObj.state == 'Deactivated') {
//       deactivatedUpdates();
//     } else { // Exploded
//       explodedUpdates();
//       hideWarning();
//     }
//   } else { // 400 - not numerical format
//     showInputWarning();
//   }
// }

// function activatedUpdates(jsonObj) {
//   deactivated = false;
//   var bombState = '<span style="color:red">Activated!</span>';
//   var deactivateLabel = 'To deactivate, enter your deactivation code: ';
//   $('#bombState').html(bombState);
//   $('#formLabel').text(deactivateLabel);
//   if (jsonObj.attempts_remaining <= 0) {
//     explodedUpdates();
//   } else if (jsonObj.attempts_remaining < 3) {
//     var attemptsRemaining = '(' + jsonObj.attempts_remaining;
//     attemptsRemaining = attemptsRemaining + ' attempts remaining!)';
//     $('#AttemptsRemaining').text(attemptsRemaining);
//   }
//   timer(jsonObj.timer_end);
// }

// function deactivatedUpdates() {
//   deactivated = true;
//   hideTimer();
//   var activateLabel = 'To activate, enter your activation code: ';
//   $('#bombState').text('Deactivated');
//   $('#formLabel').text(activateLabel);
//   $('#AttemptsRemaining').text('');
// }

// function explodedUpdates() {
//   deactivated = true;
//   hideTimer();
//   var explodedLabelText = 'To deactiv ent fjds as;dfasåß∂¬ƒåƒ∆å…ßˆƒ˙Ω©∫˚∫´å: ';
//   $('#bombState').text('!@#$%^&*!@#&$!');
//   $('#formLabel').text(explodedLabelText);
//   $('#AttemptsRemaining').text('');
//   disableButtons();
// }

// function updatePage() {
//   $.ajax({
//     url: '/status',
//     type: 'GET',
//     success: function(data) {
//       var jsonData = JSON.parse(data);
//       analyzeData(jsonData);
//     }
//   });
// }

// function timer(timerEnd) {
//   updateTimer(getTimeString(getNumSecondsLeft(timerEnd)));
//   showTimer();
//   var timerHandler = setInterval(function() {
//     var numSecondsLeft = getNumSecondsLeft(timerEnd);
//     updateTimer(getTimeString(numSecondsLeft));

//     if(deactivated) {
//       clearInterval(timerHandler);
//       updatePage();
//     } else if (!deactivated && numSecondsLeft <= 0) {
//       clearInterval(timerHandler);
//       $.ajax({
//         url: '/explode',
//         type: 'POST',
//         success: function() {
//           hideTimer();
//           updatePage();
//         }
//       });
//     }
//   }, 500);
// }

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

// function updateTimer(string) {
//   $('#timer').text(string);
// }

// function showTimer() {
//   $('#timer').removeClass('hidden');
// }

// function showInvalid() {
//   $('#Invalid').text('Invalid!');
// }

// function hideWarning() {
//   $('#Invalid').text('');
// }

// function showInputWarning() {
//   var text = 'Only numeric input is allowed.';
//   $('#Invalid').text(text);
// }

// function hideTimer() {
//   $('#timer').addClass('hidden');
// }

// function disableButtons() {
//   $('#formButton').prop('disabled', true);
// }

// window.onload = updatePage();
