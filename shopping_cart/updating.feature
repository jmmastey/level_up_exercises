Feature: Updating My Online Shopping Cart
  In order to purchase items online
  As an online shopper
  I want to be able to update my items in my cart

  Background: My cart already contains some items
    Given my cart contains 3 pairs of socks
    And my cart contains 1 pair of jeans

  Scenario: Removing items
    Given I'm on the shopping cart page
    When I click "remove" on the jeans
    Then I should not see jeans on the page
    And the total quantity of items in my cart is 3

  Scenario: Changing item quantity
    Given I'm on the shopping cart page
    When I change quantity of socks to 4
    And I click "Update Items"
    Then my cart contains 4 pairs of socks
    And the total quantity of items in my cart is 5

  Scenario: Adding items
    Given I'm on the product page for a blouse
    When I click "Add Item to Cart"
    Then my cart contains 1 blouse
    And the total quantity of items in my cart is 5

  Scenario: Adding items already in cart
    Given I'm on the product page for the same pair of jeans in my cart
    When I click "add item to cart"
    Then I should see the message "This item is already in your cart"
    And I should see the link "Go to Cart Now"