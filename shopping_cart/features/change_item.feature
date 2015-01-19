Feature: Change item to cart
  As a customer
  I need to able to change items to cart

  Scenario: Customer adds additional items to the cart
    Given the cart has "item_1"
    When "item_2" is added to cart
    Then customer should see "item_1" and "item_2" in the cart

  Scenario: Customer adds some item to the cart
    Given the cart has quantity of "1" of "item_1"
    When "item_1" is added to cart
    Then cart should have  quantity of "2" of "item_1"

  Scenario: Customer removes only some items to the cart
    Given the cart has "item_1" and "item_2"
    When customer remove "item_1" from cart
    Then customer should see "item_1" in the cart
    And  customer should not see "item_2" in the cart