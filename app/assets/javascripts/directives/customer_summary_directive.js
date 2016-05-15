var app = angular.module('customers');
app.directive("customerSummary", function() {
  return {
    "scope": {
      "cust": "=",
      "viewDetailsFunction": "="
    },
    "templateUrl": "customer_summary.html"
  }
});