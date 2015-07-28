Feature: Change item quantity
  As a customer
  I should be able to change the quantity of items in my cart
  In order to buy necessary goods
  @Happy
  Scenario: When I try to increase the quantity of an item in my cart, the quantity should update
    Given I have 5 items in my cart
    When I increase the quantity of the first item in the cart
    Then I should see the quantity increase by "1"

  @Happy
  Scenario: When I try to increase the quantity of an item in my cart, the price should update
    Given I have 5 items in my cart
    When I increase the quantity of the first item in the cart
    Then I should see the price update correctly

  @Happy
  Scenario: When I try to decrease the quantity of an item in my cart, the quantity should decrease
    Given I have 5 items in my cart
    When I decrease the quantity of the fist item in the cart
    Then I should see the quantity decrease by "1"

  @Happy
  Scenario: When I try to decrease the quantity of an item in my cart, the price should decrease
    Given I have 5 items in my cart
    When I decrease the quantity of the fist item in the cart
    Then I should see the price update correctly

  @Happy
  Scenario: The quantity of an item in the cart should display correctly
    Given I have <number> items in my cart
    And I am on a random item page
    When I add that item to my cart <quantity> of times
    Then I should have <total> items in my cart
  Examples:
  | number | quantity | total |
  |  10    |  10      |  20   |
  |  10    |  5       |  15   |
  |  10    |  4       |  14   |
  |  10    |  3       |  13   |
  |  10    |  2       |  12   |
  |  10    |  1       |  11   |

  @Happy
  Scenario: When I adjust the quantity of an item in my cart to zero, it should remove from the cart
    Given I have 1 item in my cart
    When I set the quantity of an item to zero
    Then I should have no items in my cart

  @Sad
  Scenario: When I try to adjust the quantity of an item in my cart to something other than the positive integers including zero, we should give an error message
    Given I have 1 item in my cart
    When I try to enter <value> as a quantity of the item
    Then I should see an error message
  Examples:
  | value |
  | -1    |
  | -2    |
  | tons  |
  | one   |
  | 1.0   |
  | 2.0   |
  | F     |

  @Sad
  Scenario: When I try to set the number of items in the cart above the on-hand quantity, we should reset to the on-hand quantity and give an error message
    Given I have 1 item in my cart
    And We have 2 of that item in stock
    When I try to update the quantity to "3"
    Then I should see an error message

  @Bad
  Scenario: The quantity field should sanitize input
    Given I have 1 item in my cart
    And I try to update the quantity of the item to "; DROP TABLE products"
    Then I should see an error message