#encoding: utf-8

Feature: Happy Logging In
  In order to register
  As an online shopper
  I should log in
  And begin shopping

  Scenario: I enter valid credentials
    Given I have an account on the shopping site
    When I correctly enter my username and password
    Then I will be taken to the home page
