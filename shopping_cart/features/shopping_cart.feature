Feature: Shopping Cart
  As a customer
  I want the ability to add/remove items to/from my cart
  So that I can buy all the things

  Scenario: Empty shopping cart
    Given I have an empty shopping cart
    When I click on the shopping cart link
    Then my shopping cart should be empty

  Scenario: Display items in shopping cart
    Given I have items in my shopping cart
    When I click on the shopping cart link
    Then my shopping cart should display those items

  Scenario: Add items to shopping cart
    Given I am on a product page
    When I click Add Item
    And I enter the quantity
    Then the corresponding quantity of items should be added to the cart

  Scenario: Remove items from shopping cart
    Given I am on the shopping cart page
    When I click Remove Item
    And I enter the quantity
    Then the corresponding quantity of items should be removed from the cart

  Scenario: Items vanishing from shopping cart
    Given I have a particular quantity of an item in the shopping cart
    When I remove all of the respective item
    Then the item should vanish from the shopping cart

  Scenario: Adding the same item twice to shopping cart
    Given I have an item in the shopping cart
    When I re-add that same item with a specified quantity
    Then the corresponding quantity of items should be added to the cart

  Scenario: Go to item page from shopping cart page
    Given I am on the shopping cart page
    When I click on an item
    Then I should be directed to that item page

  Scenario: Change quantity of item on shopping cart page
    Given I am on the shopping cart page
    When I increase the quantity of that item
    Then the quantity for that item should change respectively
