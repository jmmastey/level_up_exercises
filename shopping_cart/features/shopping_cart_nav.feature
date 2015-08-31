Feature: Shopping Cart Items
  In order to see an item's product page
  As a shopper
  I should be able to click on an item

  Background:
    Given I am viewing the cart
    When I click on an item

  Scenario: Product does not exist
    And the item does not exist
    Then I expect an error message "item not found"

  Scenario: Product does exist
    And the item does exist
    Then I see the item page
