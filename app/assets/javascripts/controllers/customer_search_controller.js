var app = angular.module('customers');
app.controller("CustomerSearchController", [
          '$scope','$location', "customerSearch",
  function($scope , $location ,  customerSearch) {                         

    $scope.customers = [];
    customerSearch.successCallback(function(customers) {
      $scope.customers = customers;
    });

    $scope.search       = customerSearch.search
    $scope.previousPage = customerSearch.previousPage;
    $scope.nextPage     = customerSearch.nextPage;

    $scope.viewDetails = function(customer) {
      $location.path("/" + customer.id);
    }
  }
]);