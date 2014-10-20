Feature: Adding items to my cart
  As a customer
  I want to add item(s) to my cart
  So that I can make purchases

  Background:
    Given I have an empty cart

  @happy
  Scenario: I add an item to my empty cart
    When I add "1" "Sample Item A" to my cart
    Then I should see "1" "Sample Item A" in my cart

  @happy
  Scenario: I add an item to my cart with items
    When I add "1" "Sample Item A" to my cart
    And I add "1" "Sample Item B" to my cart
    Then I should see "1" "Sample Item A" in my cart
    And I should see "1" "Sample Item B" in my cart

  @happy
  Scenario: I add the same item to my cart twice
    When I add "1" "Sample Item B" to my cart
    And I add "1" "Sample Item B" to my cart
    Then I should see "1" "Sample Item B" in my cart
    And I should see the message "Sample Item B is already in cart"
