Feature: Updating items in my cart
  As a customer
  I want to update item(s) quantities in my cart
  So that I can make purchases

  Background:
    Given I have an empty cart

  @happy
  Scenario: I update an item quantity in my empty cart
    When I add "Sample Item A" to my cart
    And I update quantity of "Sample Item A" to "3"
    Then I should see "3" "Sample Item A" in my cart
