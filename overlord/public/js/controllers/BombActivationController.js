/**
 * Created by jbonfante on 9/3/14.
 */
var BombActivationController = ['$scope', '$q', '$timeout', '$location', '$routeParams', 'Bomb',
    function ($scope, $q, $timeout, $location, $routeParams, Bomb) {

        $scope.session = {};

        $scope.login = function () {
            // process $scope.session

            var deferred = $q.defer();

            // fake a long running task
            $timeout(function() {

                deferred.resolve();
                alert('logged in!');
            }, 5000);

            return deferred.promise;
        };
    }];
