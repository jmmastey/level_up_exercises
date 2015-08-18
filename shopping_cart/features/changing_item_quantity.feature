Feature: Changing item quantity
  In order to quickly update desired item amounts
  As an online shopper
  I want to be able to seemlessly change how many of each item I want

  Background:
    Given I have 3 items in my shopping cart

  Scenario: Incrementing quantity
    When I increment the first item's quantity by 2
    Then the first item's quantity should be 3

  Scenario: Decrementing quantity
    When I increment the first item's quantity by 2
    And I decrement the first item's quantity by 1
    Then the first item's quantity should be 2

  Scenario: Setting quanity to zero removes item
    When I decrement the first item's quantity by 1
    Then the cart should have 2 items each with quanitty 1

  Scenario: Decrementing quantity below zero removes item
    When I decrement the first item's quantity by 3
    Then the cart should have 2 items each with quanitty 1

  Scenario: Incrementing quanity maxes out to what is in stock
    And the first item has 5 in stock
    When I increment the first item's quantity by 7
    Then I should receive a max quantity warning
    And the first item should have quantity 5
    