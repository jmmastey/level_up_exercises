Feature: Shopping cart
  As an online shopper
  I want to manage my cart
  Because I want to prepare to checkout

  Scenario: Adding item to cart
    Given I am viewing product "X"
    And I have no product "X" in my cart
    When I add 2 items to cart
    Then I have 2 item of product "X" in my cart

  Scenario: Remove some items of product from cart
    Given I have 3 items of product "Y" in my cart
    When I remove 2 items of product "Y" from my cart
    Then I have 1 item of product "Y" in my cart

  Scenario: Remove all items of product from cart
    Given I have 3 items of product "Y" in my cart
    When I remove 3 items of product "Y" from my cart
    Then there is no product "Y" in my cart

  Scenario: Change quantity of item
    Given I have 3 items of product "Z" in my cart
    When I change the quantity of product "Z" to 2
    Then I have 2 items of product "Z" in my cart

  Scenario: Back to item page
    Given I have 3 items of product "Y" in my cart
    And I am viewing the cart
    When I click on product "Y"
    Then I am viewing product "Y"
