/**
 * Created by jbonfante on 8/24/14.
 */
'use strict';

//var bombApp = angular.module('bombApp', []);


function timeFormatter(text)
{
    if(!text) text = '';
    text = text.toString();
    var i = text.length;
    while(i < 6)
    {
        text = "0".concat(text); i++
    }
    return vsprintf("%d%d:%d%d:%d%d", text.split(""))

}

app.directive('bombtime', function() {
    return {
        restrict: 'A',
        require: 'ngModel',
        link: function(scope, element, attr, ngModel) {
            ngModel.$formatters.push(timeFormatter);
            ngModel.$parsers.push(timeFormatter);

        }
    };
})
    .controller('BombController', ['$scope', '$routeParams',
    '$location', 'Bomb', function($scope, $routeParams, $location, Bomb){
    $scope.activationCode = '';
    $scope.deactivationCode = '';
    $scope.detonationCode = '';
    $scope.currentStep = 0;
    $scope.bombActive = false
    $scope.currentCode = ['activationCode', 'deactivationCode', 'detonationCode'];


    $scope.currentForm = {
        get form()
        {
            return $scope[$scope.currentCode[$scope.currentStep]];
        },
        set form(value)
        {
            $scope[$scope.currentCode[$scope.currentStep]] = value;
        },
        get method()
        {
            return $scope.currentCode[$scope.currentStep]
        },
        get formName()
        {
          return this.method
        }

    };


    $scope.keypadClick = function(key)
    {
        if(key != 'C' && key != 'S')
        {
//            $scope.form[$scope.currentCode[$scope.currentStep]].$se
            $scope.currentForm.form = $scope.currentForm.form.toString().concat(key);

        }

        if(key === 'C')
        {

            $scope.currentForm.form = ($scope.currentForm.form.slice(0, -1));
        }

        if(key == 'S')
        {
            if($scope.currentStep < 3)
            {
                $scope.currentStep++;
            }
            if($scope.currentStep == 3)
            {
                $scope.submit()
            }
        }


    };

    if ($routeParams.activationCode && $routeParams.deactivationCode && $routeParams.detonationCode) {
        $scope.bomb= Bomb.show({ activationCode: $routeParams.activationCode,
            deactivationCode: $routeParams.deactivationCode,
            detonationCode: $routeParams.detonationCode });
    } else {
        $scope.bomb = new Bomb();
    }
    $scope.bombActionClick = function(name){
      if(name == 'Activate')
      {
          $scope.submit();
      }
      else{
          $scope.submit();
      }
    };

    $scope.submit = function() {

        console.log("submit");
//        if(!$scope.activationCode.length)
//        {
//            $scope.activationCode = '1234'
//        }
//        if(!$scope.deactivationCode.length)
//        {
//            $scope.deactivationCode = '0000'
//        }
//        if(!$scope.detonationCode.length)
//        {
//            $scope.detonationCode = 60
//        }


        function success(response) {
            console.log("success", response);
            $location.path("/");
            $('form[name="form"]').hide();
            $scope.bombActive = true;
            $scope.detonationTime = timeFormatter(response.detonation)

        }

        function failure(response) {
            console.log("failure", response);
            $('form[name="form"]').show();
            $.each(response.data, function(key, error){
//                $.each(key, function(e){
                console.log(error)
                    $scope.form[key].$dirty = true;
                    $scope.form[key].$setValidity(error, false);
//                })

            });


        }

        if ($routeParams.code) {

            Bomb.submitCodes($scope.form, success, failure);
//            Bomb.update($scope.activation, success, failure);
        } else {
            var codes = {};
            for(var value in $scope.currentCode)
            {
                console.log(value)
                var key = $scope.currentCode[value];
                var val = $scope[key];
                codes[key] = val;
            }

            Bomb.submitCodes(codes, success, failure);
        }

    };

    $scope.setStep = function(step){
        $scope.currentStep = step
    }

    $scope.cancel = function() {
        $location.path("/"+$scope.activation.code);
    };

    $scope.errorClass = function(name) {
        var s = $scope.form[name];
        return s.$invalid && s.$dirty ? "has-error" : "";
    };

    $scope.errorMessage = function(name) {
        var result = [];
        $.each($scope.form[name].$error, function(key, value){
             value ? result.push(key) : null;
        });

        return result.join(", ");
    };

            $scope.activeErrorMessage = function(name) {
                var result = [];
                $.each($scope.deactivationForm[name].$error, function(key, value){
                    value ? result.push(key) : null;
                });

                return result.join(", ");
            };

            $scope.activeErrorClass = function(name) {
                var s = $scope.deactivationForm[name];
                return s.$invalid && s.$dirty ? "has-error" : "";
            };



}]);

