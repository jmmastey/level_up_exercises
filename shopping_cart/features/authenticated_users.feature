Feature: Customer logs in before checkout

  Background:
    Given customer is not logged in
    And the cart has "item_1" and "item_2"

  Scenario: Customer logs in
    Given customer logs in
    When I visit the cart
    Then I should see "item_1" and "item_2" in the cart