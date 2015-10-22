window.myctapp.directive('modalBox', ()->
  return {
    templateUrl: '/assets/modalBox.html.erb',
    replace: true,
    controller: ['$scope', '$http', ($scope, $http)->
      # console.info("Im alive!")

      $scope.modalTitle = ""
      $scope.modalBody = ""

      $scope.$on(window.myctapp.eventList.APP_MODAL, (event, data)->
        $scope.modalTitle = data.title
        $scope.modalBody = data.body
        $("#appModal").modal({
          keyboard: true
        })
      )

      $scope.closeModal = ()->
        $scope.modalTitle = ""
        $scope.modalBody = ""

      return
    ]
  }
)
