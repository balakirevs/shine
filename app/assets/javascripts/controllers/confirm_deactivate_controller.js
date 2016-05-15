var app = angular.module('customers');
app.controller("ConfirmDeactivateController", [ 
  "$scope","$uibModalInstance",
  function($scope , $uibModalInstance ) {
    $scope.deactivate = function () {
      $uibModalInstance.close();
    };

    $scope.nevermind = function () {
      $uibModalInstance.dismiss('cancel');
    };
  }
]);