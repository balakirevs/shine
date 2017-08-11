import "polyfills";

import { Component, NgModule    } from "@angular/core";
import { BrowserModule          } from "@angular/platform-browser";
import { FormsModule            } from "@angular/forms";
import { platformBrowserDynamic } from "@angular/platform-browser-dynamic";
import { HttpModule             } from "@angular/http";
import { RouterModule           } from "@angular/router";

import { CustomerSearchComponent  } from "CustomerSearchComponent";
import { CustomerDetailsComponent } from "CustomerDetailsComponent";
import { CustomerInfoComponent    } from "CustomerDetailsComponent/CustomerInfoComponent";
import { AddressComponent         } from "CustomerDetailsComponent/AddressComponent";
import { CreditCardComponent      } from "CustomerDetailsComponent/CreditCardComponent";
import { TextFieldComponent       } from "TextFieldComponent";
import { NameCasePipe             } from "NameCasePipe";
import { NgxPaginationModule      } from 'ngx-pagination';

import intl from "intl";
import "intl/locale-data/jsonp/en.js";

if (!window.Intl) {
  window.Intl = intl;
}

var AppComponent = Component({
  selector: "shine-customers-app",
  template: "<router-outlet></router-outlet>"
}).Class({
  constructor: [
    function() {}
  ]
});

var router = RouterModule.forRoot(
  [
    {
      path: "",
      component: CustomerSearchComponent
    },
    {
      path: ":id",
      component: CustomerDetailsComponent
    }
  ]
);

var CustomerAppModule = NgModule({
    imports:      [ BrowserModule, FormsModule, HttpModule, NgxPaginationModule, router ],
    declarations: [ CustomerSearchComponent, CustomerDetailsComponent, CustomerInfoComponent, AddressComponent,
                    CreditCardComponent, TextFieldComponent, NameCasePipe, AppComponent ],
    bootstrap:    [ AppComponent ]
})
.Class({
  constructor: function() {}
});

platformBrowserDynamic().bootstrapModule(CustomerAppModule);