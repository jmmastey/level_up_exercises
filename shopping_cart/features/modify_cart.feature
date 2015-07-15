#encoding: utf-8

Feature: Modifying my shopping cart
  In order modify the shopping cart
  As an online shopper
  I should add items or update their quantities

  @happy
  Scenario: Adding an item to my shopping cart
    Given I'm at the online store
    When I click 'add to cart' on an item
    Then the item should be in my cart
    And the quantity should be 1
    And my total price should add the item's price

  @happy
  Scenario: Modifying an item in my shopping cart
    Given I'm at the online store
    And I have an item in my shopping cart
    When I change the item's quantity from 1 to 2
    Then the quantity should be 2
    And my total price should add the item's price

  @happy
  Scenario: Changing an item's quantity to 0
    Given I'm at the online store
    And I have an item in my shopping cart
    When I change the item's quantity to 0
    Then the item should be removed from my shopping cart
    And my total price should subtract the item's price

  @happy
  Scenario: Removing an item from my shopping cart
    Given I'm at the online store
    And I have an item in my shopping cart
    When I press delete on the item
    Then the item should be removed from my shopping cart
    And my total price should subtract the item's prices
    