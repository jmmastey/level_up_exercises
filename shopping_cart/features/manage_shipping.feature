Feature: Manage Shipping
  In order to view my shipping rates
  As a customer
  I want to input my address and view shipping estimates

  Background:
    Given I am on the shopping cart page

  @happy
  Scenario: Input Valid Shipping Address
    When I input my address "346 S Boo Road, Apt. 101"
    And I input my city "Chesterton"
    And I input my state "IN"
    And I input my zip code "46304"
    Then I should see a shipping estimate for my address

  @sad
  Scenario: Input Invalid Shipping Address
    When I input my address "This is incorrect road"
    And I input my city "Fake"
    And I input my state "ZZ"
    And I input my zip code "345"
    Then I should see an "Invalid Address" message