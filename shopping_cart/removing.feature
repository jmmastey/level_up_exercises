Feature: Removing items from my cart
  As a customer
  I want to remove item(s) from my cart
  So that I don't have to buy those items

  Background:
    Given I have an empty cart

  @bad
  Scenario: I remove an item from my empty cart
    When I remove "1" "Sample Item A" from my cart
    Then I should see the message "The cart is empty"

  @happy
  Scenario: I remove an item from my cart with items
    When I add "1" "Sample Item A" to my cart
    And I add "1" "Sample Item B" to my cart
    And I remove "1" "Sample Item A" from my cart
    Then I should see "1" "Sample Item B" in my cart

  @happy
  Scenario: I remove the same item from my cart twice
    When I add "1" "Sample Item B" to my cart
    And I remove "2" "Sample Item B" from my cart
    Then I should see the message "Sample Item B is no longer in cart"
