Feature: View Item from Shopping Cart
  In order to review an item I've added to my cart
  As a customer
  I want to be able to go to the item's page from my shopping cart

  Scenario Outline: View a selected item
    Given I am on the shopping cart page
    And I have <number_of_item> "<item_name>" items in my cart
    When I click on the "<item_name>" item
    Then <something_happens>

  @happy
  Examples:
    | number_of_item | item_name  | something_happens                  |
    | 1              | fishbowl   | I go to the "fishbowl" item page   |
    | 2              | monkey hat | I go to the "monkey hat" item page |