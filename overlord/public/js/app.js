'use strict';
var app = angular.module("bombApp", ["ngResource", "ngRoute", "rcForm", "rcDisabled"]);

app.config(function($routeProvider, $locationProvider) {
    $locationProvider.html5Mode(true);
    $routeProvider
        .when("/contacts", { templateUrl: "<%= asset_path('contacts/index.html') %> ", controller: "ContactsIndexCtrl" })
        .when("/contacts/new", { templateUrl: "<%= asset_path('contacts/edit.html') %> ", controller: "ContactsEditCtrl" })
        .when("/contacts/:id", { templateUrl: "<%= asset_path('contacts/show.html') %> ", controller: "ContactsShowCtrl" })
        .when("/contacts/:id/edit", { templateUrl: "<%= asset_path('contacts/edit.html') %> ", controller: "ContactsEditCtrl" })
        .otherwise({ redirectTo: "/contacts" });
});

app.config(function($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
});