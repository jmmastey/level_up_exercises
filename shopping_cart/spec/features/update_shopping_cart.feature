Feature: Update Shopping Cart
  In order to get what I want
  As a customer
  I want to be able to change what items are in my cart
  
  Background:
    Given I am logged in

  Scenario: Add New Item to Cart
    Given I have 0 of the item in my cart
    And I am on the browse items page
    When I click to add the item to my cart
    Then I have 1 of the item in my cart

  Scenario: Add Item Already in Cart
    Given I have 1 of the item in my cart
    And I am on the browse items page
    When I click to add the item to my cart
    Then I have 2 of the item in my cart

  Scenario: Remove Item from Cart
    Given I have 1 of the item in my cart
    And I am on the shopping cart page
    When I click to remove the item from my cart
    Then I have 0 of the item in my cart

  Scenario: Update Item Quantity
    Given I have 2 of the item in my cart
    And I am on the shopping cart page
    When I change the quantity to 1
    Then I have 1 of the item in my cart

  Scenario: Invalid Quantity Update
    Given I have 2 of the item in my cart
    And I am on the shopping cart page
    When I change the quantity to -1
    Then I see an "invalid quantity" message