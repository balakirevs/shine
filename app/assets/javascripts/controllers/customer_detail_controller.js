var app = angular.module('customers');
app.controller("CustomerDetailController", [
          "$scope","$routeParams","$resource","$uibModal",
  function($scope , $routeParams , $resource , $uibModal) {
    $scope.alert = undefined;
    $scope.customerId = $routeParams.id;

    var Customer = $resource('/customers/:customerId.json',
                             {"customerId": "@customer_id"},
                             { "save": { "method": "PUT" }});
    $scope.customer = Customer.get({ "customerId": $scope.customerId})



    $scope.customer.billingSameAsShipping = false;
    $scope.$watch('customer.billing_address_id',function() {
      $scope.customer.billingSameAsShipping = 
        $scope.customer.billing_address_id == 
          $scope.customer.shipping_address_id;
    });

    $scope.deactivate = function() {
      var modalInstance = $uibModal.open({
        templateUrl: 'confirm_deactivate.html',
        controller: 'ConfirmDeactivateController'
      });

      modalInstance.result.then(function () {
        $scope.alert = {
          type: "success",
          message: "Customer deactivated"
        }
      }, function (reason) {
        $scope.alert = {
          type: "warning",
          message: "Customer still active"
        }
      });
    };

    $scope.save = function() {
      if ($scope.form.$valid) {
        $scope.customer.$save(
          function() {
            $scope.form.$setPristine();
            $scope.form.$setUntouched();
            $scope.alert = {
              type: "success",
              message: "Customer successfully saved."
            };
          },
          function(data) {
            $scope.alert = {
              type: "danger",
              message: "Customer couldn't be saved"
            };
          }
        );
      }
    }

    $scope.closeAlert = function(index) {
      $scope.alert = undefined;
    }
  }
]);
