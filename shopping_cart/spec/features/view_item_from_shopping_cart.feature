Feature: View Item from Shopping Cart
  In order to review an item I've added to my cart
  As a customer
  I want to be able to go to the item's page from my shopping cart

  @happy
  Scenario: View a selected item
    Given I am on the shopping cart page
    And I have 1 of an item in my cart
    When I click on an item in my cart
    Then I see the item's page