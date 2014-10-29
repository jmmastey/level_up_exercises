Feature: Shopping Cart
  A simple shopping cart that allows people to add a item to a cart
  and then on those items be able to add, remove or change quantities.

  The shopping cart should provide shipping estimates on items without
  forcing the user to checkout. Additionally, the user should be allowed
  to add unexpired coupons and have the new price reflected for the item
  once the coupons have been applied.

  The user's cart can have 2 states: a cart with items when the user is not
  logged in, and a cart from a previous session.

  Background:
    Given I have a empty shopping cart
    And "Item 1" which costs $10.00
    And "Item 2" which costs $20.00
    And "Item 3" which costs $30.00

  Scenario: Add products as existing user and log out
    When I login as "cust111"
    And I add 1 of "Item 1" to shopping cart
    Then I should see 1 of "Item 1" in the shopping cart
    And I log out
    And I should see items subtotal of $0 in shopping cart


  Scenario: Add products as existing user and log out and log in again
    When I login as "cust111"
    And I add 1 of "Item 1" to shopping cart
    Then I should see 1 of "Item 1" in the shopping cart
    And I log out
    Then I should see items subtotal of $0 in shopping cart
    When I login as "cust111"
    Then I should see items subtotal of $10.00 in shopping cart
