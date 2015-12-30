Feature: Shopping Cart
  As a customer
  I want the ability to add/remove items to/from my cart
  So that I can buy all the things

  Scenario: Empty shopping cart
    Given I have an empty shopping cart
    When I go to see my shopping cart
    Then my shopping cart should be empty

  Scenario: Display items in shopping cart
    Given I have items in my shopping cart
    When I go to see my shopping cart
    Then I should see those items in my shopping cart

  Scenario: Add items to shopping cart
    Given I am on a product page
    When I add an item
    And I enter the quantity
    Then the corresponding quantity of items should be added to the cart

  Scenario: Remove the same item from shopping cart
    Given I am on the shopping cart page
    When I remove an item
    And I enter the quantity
    Then the corresponding quantity of items should be removed from the cart

  Scenario: Remove item completely from shopping cart
    Given I have a particular quantity of an item in the shopping cart
    When I remove all of the respective item
    Then the item should vanish completely from the shopping cart

  Scenario: Add the same item to shopping cart
    Given I have an item in the shopping cart
    And I am on the shopping cart page
    When I re-add that same item with a specified quantity
    Then the corresponding quantity of items should be added to the cart

  Scenario: Go to item page from shopping cart page
    Given I am on the shopping cart page
    When I click on an item
    Then I should be directed to that respective item's page

  Scenario: Increase quantity of item on shopping cart page
    Given I am on the shopping cart page
    When I increase the quantity of that item
    Then the quantity for that item should change respectively
