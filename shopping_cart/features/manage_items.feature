Feature: Manage Items
  In order to manage items
  As a customer
  I want to view, add, remove, and change quantities of items in my cart

  Background:
    Given I am on the shopping cart page

  @happy
  Scenario: Add New Item
    Given The shopping cart has none of the item
    When I add an item to the cart
    Then I should see the item in the cart
    And the item quantity should be one

  @happy
  Scenario: Add Existing Item By Click
    Given I already have the item in my shopping cart
    When I click to add an existing item to the cart
    Then I should see the item in the cart
    And the item quantity should be incremented by one

  @happy
  Scenario: Add Existing Item By Plus Button
    Given I already have the item in my shopping cart
    When I click on the plus button by the item
    Then I should see the item in the cart
    And the item quantity should be incremented by one

  @happy
  Scenario: Remove One of Existing Item With Quantity of More Than One
    Given I have a quantity of more than one of an item
    When I click the minus button by the item
    Then I should see the item in the cart
    And the item quantity should be decremented by one

  @happy
  Scenario: Remove Existing Item By Decrementing Quantity
    Given I have one of an item in the shopping cart
    When I click the minus button by the item
    Then I should not see the item in the cart

  @happy
  Scenario: Remove All of an Item in the Shopping Cart
    Given I have one or more of an item in the shopping cart
    When I click the 'Remove' button by the item
    Then I should not see the item in my cart 

  @happy
  Scenario: Redirect to the Item Page on Item Click
    Given I have an item in my shopping cart
    When I click on the item
    Then I am redirected to that item's page
