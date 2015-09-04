Feature: Manage Shipping
  In order to view my shipping rates
  As a customer
  I want to input my address and view shipping estimates

  Background:
    Given I am on the shopping cart page

  Scenario: Input Valid Shipping Address
    When I input a valid shipping address
    Then I see a shipping estimate for my address

  Scenario: Input Invalid Shipping Address
    When I input an invalid shipping address
    Then I should see an "Invalid Address" message