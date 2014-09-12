/**
 * Created by jbonfante on 8/24/14.
 */
'use strict';

//var bombApp = angular.module('bombApp', []);


function timeFormatter(text) {
    if (!text) text = '';
    text = text.toString();
    var i = text.length;
    while (i < 6) {
        text = "0".concat(text);
        i++
    }
    return vsprintf("%d%d:%d%d:%d%d", text.split(""))

}

bombApp.directive('bombtime', function () {
    return {
        restrict: 'A',
        require: 'ngModel',
        link: function (scope, element, attr, ngModel) {
            ngModel.$formatters.push(timeFormatter);
            ngModel.$parsers.push(timeFormatter);

        }
    };
})
    .controller('BombController', ['$scope', '$routeParams',
        '$location', 'Bomb', function ($scope, $routeParams, $location, Bomb) {
            var self = this;
            var selectedInputIndex = 1;
            $scope.opened = true;
            $scope.activationCode = '';
            $scope.deactivationCode = '';
            $scope.detonationCode = '';
            $scope.currentStep = 0;
            $scope.bombActive = false;

            $scope.$on(Keypad.MODIFIER_KEY_PRESSED, function (event, key, id) {
                var focusedInput = $('a[data-ng-keypad-input]:focus'),
                    inputs = $('a[data-ng-keypad-input]'),
                    foundIndex = findInputInInputs(focusedInput, inputs),
                    index = 0;

                switch (key) {
                    case "PREVIOUS":
                        if (!focusedInput.length) {
                            index = inputs.length - 1;
                        } else {
                            if (foundIndex === 0) {
                                index = inputs.length - 1;
                            } else {
                                index = foundIndex - 1;
                            }
                        }
                        inputs.eq(index).focus();
                        break;
                    case "NEXT":
                        if (focusedInput.length) {
                            if (foundIndex === inputs.length - 1) {
                                index = 0;
                            } else {
                                index = foundIndex + 1;
                            }
                        }
                        inputs.eq(index).focus();
                        break;
                }
            });


            function findInputInInputs(input, inputs) {
                var foundIndex = 0;
                inputs.each(function (index) {
                    if ($(this).is(input.eq(0))) {
                        foundIndex = index;
                    }
                });

                return foundIndex;
            }


            if ($routeParams.activationCode && $routeParams.deactivationCode && $routeParams.detonationCode) {
                $scope.bomb = Bomb.show({ activationCode: $routeParams.activationCode,
                    deactivationCode: $routeParams.deactivationCode,
                    detonationCode: $routeParams.detonationCode });
            } else {
                $scope.bomb = new Bomb();
            }
            $scope.bombActionClick = function (name) {
                if (name == 'Activate') {
                    $scope.submit();
                }
                else {
                    $scope.submit();
                }
            };

            $scope.submit = function () {

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

                }

                function failure(response) {
                    console.log("failure", response);

                }


            };

            $scope.cancel = function () {
                $location.path("/" + $scope.activation.code);
            };

            $scope.errorClass = function (ngModelController) {
                if (ngModelController.$pristine) return "";
                return ngModelController.$valid ? "" : "has-error";

            };

            $scope.showError = function (ngModelController) {
                return ngModelController.$invalid && ngModelController.$dirty;

            };

            $scope.errorMessage = function (ngModelController) {
                var result = [];
                $.each(ngModelController.$error, function (key, value) {
                    value ? result.push(key) : null;
                });

                return result.join(", ");
            };


        }]);

