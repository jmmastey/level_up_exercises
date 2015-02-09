Feature: get back to item pages from the cart by clicking on individual cart item lines, get back to cart from item pages
  Background: 
    Given I am at the cart page
    And I add the item to the cart

  Scenario: get to item page
    When I click the item name
    Then I am at the item page

  Scenario: get to cart
    Given I click the item name
    And I am at the item page
    When I click the "Cart" button
    Then I am at the cart page
    