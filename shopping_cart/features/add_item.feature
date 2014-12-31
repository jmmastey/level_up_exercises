Feature: Add item to cart
  As a shopper
  I want to be able to add items to my shopping cart
  So I can purchase the items I need

  Background: 
    Given an empty cart

  @happy
  Scenario: Adding 1 valid item
    When I add "item1" for $10.00
    Then I expect to see "item1" in my cart
    Then the cart quantity should be 1
    And have a subtotal of $10.00

  @happy
  Scenario: Adding multiple valid items
    When I add 1 "item1" for $10.00
    And  I add 2 "item2" for $15.00
    Then I should "item1", "item2", and "item3" in my cart
    And the cart quantity should be 6
    And have a subtotal of $40.00

  @happy
  Scenario: Adding multiple items to a cart with existing items
    Given a cart with 2 Cars for $10.00 each and 3 Trucks for $15.00 each
    When I add 1 plane for $5.00 and 1 boat for $1.00
    And have a subtotal of $71.00
    And the cart quantity should be 6
