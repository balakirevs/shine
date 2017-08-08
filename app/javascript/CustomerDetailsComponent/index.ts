import { Component }      from "@angular/core";
import { ActivatedRoute } from "@angular/router";
import { Http }           from "@angular/http";
import                    "rxjs/add/operator/map";
import   template         from "./template.html";

var CustomerDetailsComponent = Component({
  selector: "shine-customer-details",
  template: template
}).Class({
  constructor: [
    ActivatedRoute, Http,
    function(activatedRoute, http) {
      this.activatedRoute = activatedRoute;
      this.http = http;
      this.id = null;
      this.customer = null;
    }
  ],
  ngOnInit: function() {
    var self = this;
    var observableFailed = function(response) {
      alert(response);
    };
    var parseCustomer = function(response) {
      var customer = response.json().customer;

      customer.billing_address = {
        street:  customer.billing_street,
        city:    customer.billing_city,
        state:   customer.billing_state,
        zipcode: customer.billing_zipcode
      };

      customer.shipping_address = {
        street:  customer.shipping_street,
        city:    customer.shipping_city,
        state:   customer.shipping_state,
        zipcode: customer.shipping_zipcode
      };

      return customer;
    };
    var routeSuccess = function(params) {
      var observable = self.http.get(
        "/customers/" + params["id"] + ".json"
      );
      var mappedObservable = observable.map(parseCustomer);

      mappedObservable.subscribe(
        function(customer) { self.customer = customer; },
        observableFailed
      );
    };
    self.activatedRoute.params.subscribe(routeSuccess, observableFailed);
  },
});
export { CustomerDetailsComponent };
