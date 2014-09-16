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
            $scope.currentStep = 0;
            $scope.bombActive = false;
            $scope.buttonLabel = 'NEXT';

            $scope.$on('timer-stopped', function (event, data){
                console.log('Timer Stopped - data = ', data);
                var completed = data.seconds;

                if(completed >= $scope.detonation_time)
                {
                    $scope.detonate();
                }
            });

//            $scope.$on(Keypad.KEY_PRESSED, function(event){
//                controller.$valid = true;
//                controller.$dirty = false;
//            });

            $scope.$on(Keypad.MODIFIER_KEY_PRESSED, function (event, key, id) {
                var focusedInput = $('a[data-ng-keypad-input]:focus'),
                    inputs = $('a[data-ng-keypad-input]'),
                    foundIndex = findInputInInputs(focusedInput, inputs),
                    index = 0;

                if($scope.activationForm.$valid)
                {
                    $scope.buttonLabel = 'SUBMIT'
                }
                else
                {
                    $scope.buttonLabel = 'NEXT'
                }

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
                        if($scope.activationForm.$valid && !$scope.bombActive)
                        {
                            $scope.submit();
                        }
                        if($scope.bombActive)
                        {
                            $scope.deactivate();
                        }
                        break;
                    case "ACTIVATE":
                        if($scope.bombReady && !$scope.bombActive)
                        {
                            $scope.activate();
                        }
                        if($scope.bombReady && $scope.bombActive)
                        {
                            $scope.deactivate();
                        }
                        break;
                    case "DEACTIVATE":
                        if($scope.bombReady && $scope.bombActive)
                        {
                            $scope.deactivate();
                        }
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
            $scope.detonate = function (name) {
                console.log("detonate");


                function success(response) {
                    console.log("success", response);
                    $scope.bombActive = false;
                    $scope.bombStatus = response.status;
                    $scope.bomb_id = response.id;
                    $scope.buttonLabel = 'YOU DIED'
//                    $scope.$broadcast('timer-stop');
                }

                function failure(response) {
                    console.log("failure", response);
                    $scope.code_error = response.data.error;
                    $scope.bombStatus = response.data.status;

                }

                Bomb.detonate({id: $scope.bomb_id}, success, failure)



            };
            $scope.deactivate = function (name) {
                console.log("deactivate");


                function success(response) {
                    console.log("success", response);
                    $scope.bombActive = false;
                    $scope.bombStatus = response.status;
                    $scope.bomb_id = response.id;
                    $scope.buttonLabel = 'DEFUSED'
                    $scope.$broadcast('timer-stop');
                    $scope.code_error = "success";
                }

                function failure(response) {
                    console.log("failure", response);
                    $scope.code_error = response.data.error;
                    $scope.bombStatus = response.data.status;

                }

                Bomb.deactivate({id: $scope.bomb_id, deactivation_code: $scope.deactivation_entry}, success, failure)



            };

            $scope.activate = function (name) {
                console.log("activate");


                function success(response) {
                    console.log("success", response);
                    $scope.bombActive = true;
                    $scope.bombStatus = response.status;
                    $scope.bomb_id = response.id;
                    $scope.buttonLabel = 'DEACTIVATE'
                    $scope.$broadcast('timer-start');
                }

                function failure(response) {
                    console.log("failure", response);

                }

                Bomb.activate({id: $scope.bomb_id, activation_code: $scope.activation_code}, success, failure)



            };

            $scope.submit = function () {

                console.log("submit");


                function success(response) {
                    console.log("success", response);
                    $scope.bombReady = true;
                    $scope.bombStatus = response.status
                    $scope.bomb_id = response.id
                    $scope.$broadcast('timer-set-countdown', $scope.detonation_time);


                }

                function failure(response) {
                    console.log("failure", response);
                    $(response.data).each(function(errors, key)
                    {
                        for(var k in key){
                            $('#'+k+'_errors').html(key[k])
                        }
                    });
                }
                var form = $scope.activationForm;
                var data = {activation_code: form.activation_code.$modelValue,
                        deactivation_code: form.deactivation_code.$modelValue,
                        detonation_time: form.detonation_time.$modelValue};
                Bomb.submit(data, success, failure)


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

