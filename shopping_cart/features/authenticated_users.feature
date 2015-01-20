Feature: Customer logs in before checkout

  Background:
    Given customer is not logged in
    And the cart has "item_1" and "item_2"

  Scenario: Customer logs in
    Given customer logs in
    When customer visits the cart
    Then customer should see "item_1" and "item_2" in the cart