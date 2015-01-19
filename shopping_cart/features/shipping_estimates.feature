Feature: Get shipping estimates
  As a customer, before I check out
  They should get shipping estimates, when they enter address

  Scenario:
    Given the cart has "item_1"
    When customer enters shipping address
    Then shipping cost should be calculated