var app = angular.module('customers');
app.factory("customerSearch", [
          "$http",
  function($http) {

    var page = 0;
    var mostRecentSearchTerm = undefined;
    var success = function() {};

    var successCallback = function(newCallback) {
      success = newCallback;
    };
    var search = function(searchTerm) {
      if (searchTerm.length < 3) {
        return;
      }
      mostRecentSearchTerm = searchTerm;
      $http.get("/customers.json",  
                { "params": { "keywords": searchTerm, "page": page } }
      ).success(success).error(
        function(data,status,headers,config) {
          alert("There was a problem: " + status);
        }
      );
    };
    var previousPage = function() {
      if ( (page > 0) && mostRecentSearchTerm) {
        page = page - 1;
        search(mostRecentSearchTerm);
      }
    };

    var nextPage = function() {
      if (mostRecentSearchTerm) {
        page = page + 1;
        search(mostRecentSearchTerm);
      }
    };
    return {
      "successCallback": successCallback,
      "search": search,
      "previousPage": previousPage,
      "nextPage": nextPage
    };
}]);