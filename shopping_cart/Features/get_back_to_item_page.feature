Feature: Ability To Get Back To Item Page From Shopping Cart
  In order to view the product description
  As a customer
  I want to be able to navigate back to the item page

  Scenario: Customer wants to navigate back to the item page
    Given There are items in the cart
    When I click the navigate back to item page control
    Then I should be redirected back to the item page

  Scenario: Customer wants to navigate back to an item page that was removed from the store
    Given There are items in the cart
    When I click the navigate back to an invalid item page control
    Then I should see a warning that this item is no longer valid
    And I should see that this item has been removed from my cart
    And I should see that cart totals have been updated to reflect removing this item

