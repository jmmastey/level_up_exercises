Feature: Get shipping estimate for items in cart
  As a customer
  I want to enter my ZIP code and get a shipping estimate
  So that I know how much shipping will cost for the items in my cart

  Background:
    Given I am at the shopping cart home page
    And I have a widget in my shopping cart

  Scenario: Calculate shipping estimate
    Given I have entered my ZIP code
    When I submit my ZIP code
    Then I see a shipping estimate for the items in my cart

  Scenario: Invalid ZIP code
    Given I have entered an invalid ZIP code
    Then I see an "invalid ZIP code error"
    And I do not get a shipping estimate

  Scenario: Shipping estimate as logged in user
    Given I have logged in to my account
    And my account already has my shipping information
    Then I see a shipping estimate for the items in my cart
