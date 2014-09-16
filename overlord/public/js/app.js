'use strict';
var bombApp = angular.module("bombApp", ["ngResource", "ngRoute", "rcForm", "rcDisabled", "ngKeypad", "timer"]);


bombApp.config(function($routeProvider, $locationProvider){
    $locationProvider.html5Mode(true);

    $routeProvider.
        when("/", {
            templateUrl: '/bomb/main_display.html',
            controller: 'BombController'
        }).
        when('/code/:name/:value', {
            templateUrl: '/bomb/code_entry_display.html',
            controller: 'CodeController'
        })

})

//app.config(function($routeProvider, $locationProvider) {
//    $locationProvider.html5Mode(true);
//    $routeProvider
//        .when("/contacts", { templateUrl: "<%= asset_path('contacts/index.html') %> ", controller: "ContactsIndexCtrl" })
//        .when("/contacts/new", { templateUrl: "<%= asset_path('contacts/edit.html') %> ", controller: "ContactsEditCtrl" })
//        .when("/contacts/:id", { templateUrl: "<%= asset_path('contacts/show.html') %> ", controller: "ContactsShowCtrl" })
//        .when("/contacts/:id/edit", { templateUrl: "<%= asset_path('contacts/edit.html') %> ", controller: "ContactsEditCtrl" })
//        .otherwise({ redirectTo: "/contacts" });
//});
//
//app.config(function($httpProvider) {
//    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
//});