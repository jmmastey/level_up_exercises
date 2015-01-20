Feature: Visit the items page when clicked in the cart

  Scenario: There are multiple items in the cart
    Given the cart has "item_1" and "item_2"
    When customer click on "item_1"
    Then customer should visit "item_1" page

