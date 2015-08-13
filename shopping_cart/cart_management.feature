Feature: Cart management
  As an online shopper
  I want to manage my cart
  Because I want to prepare to checkout

  Scenario: Adding item to cart
    Given I am viewing a product
    And I do not have any of that product in my cart
    When I add 2 items to my cart
    Then I have 2 items in my cart

  Scenario: Remove some items of product from cart
    Given I have 3 items of a product in my cart
    When I remove 2 items from my cart
    Then I have 1 item in my cart

  Scenario: Remove all items of product from cart
    Given I have 3 items of a product in my cart
    When I remove 3 items from my cart
    Then there are no items left in my cart

  Scenario: Set quantity of item
    Given I have 3 items of a product in my cart
    When I change the item quantity to 2
    Then I have 2 items in my cart

  Scenario: Visit product page
    Given I have 3 items of a product in my cart
    And I am viewing the cart
    When I click on the product
    Then I am viewing the product page
