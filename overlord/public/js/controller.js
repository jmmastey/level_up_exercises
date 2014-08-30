/**
 * Created by jbonfante on 8/24/14.
 */
'use strict';

//var bombApp = angular.module('bombApp', []);


function timeFormatter(text)
{
    text = text.toString()
    var i = text.length
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
            ngModel.$formatters.push(timeFormatter)
        }
    };
})
    .controller('BombController', ['$scope', '$routeParams',
    '$location', 'Bomb', function($scope, $routeParams, $location, Bomb){
    $scope.activationCode = '';
    $scope.deactivationCode = '';
    $scope.detonationCode = 60;
    $scope.currentStep = 0;
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
            $scope.currentForm.form = $scope.currentForm.form.toString().concat(key)

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

    $scope.submit = function() {
        console.log("submit");

        function success(response) {
            console.log("success", response);
            $location.path("/");

        }

        function failure(response) {
            console.log("failure", response)

                    $scope.form[$scope.currentForm.formName].$dirty = true;
                    $scope.form[$scope.currentForm.formName].$setValidity($scope.currentForm.formName, false);
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

    $scope.cancel = function() {
        $location.path("/"+$scope.activation.code);
    };

    $scope.errorClass = function(name) {
        var s = $scope.form[name];
        return s.$invalid && s.$dirty ? "error" : "";
    };

    $scope.errorMessage = function(name) {
        var s = $scope.form[name].$error;
        var result = [];
        for(var value in s){
            result.push(s[value])
        }
        return result.join(", ");
    };



}]);

