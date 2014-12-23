Feature: Add item to cart

  As a shopper
  I want to be able to add items to my shopping cart
  So I can purchase the items I need

  Background: 
    Given an empty cart

  @happy
  Scenario: Adding 1 valid item
    When I add "item1" for "price1"
    Then I should "item1", "item2", and "item3" in my cart
    Then the cart quantity should be 1
    And have a subtotal of "price1"
  
  @happy
  Scenario: Adding multiple valid items
    When I add 1 "item1" for "price1"
    And I add 2 "item2" for "price2"
    And I add 3 "item3" for "price3"
    Then I should "item1", "item2", and "item3" in my cart
    And the cart quantity should be 6
    And have a subtotal of "(price1 + 2*price2 + 3*price3)"

  @happy
  Scenario: Adding multiple items to a cart with existing items
    Given a cart with 2 Cars for $10.00 each and 3 Trucks for $15.00 each
    When I add 1 plane for $5.00 and 1 boat for $1.00
    And have a subtotal of $71.00
    And the cart quantity should be 6

#==============================================================
# Where/how do we test unavailable / out of stock items?
# Should we assume the customer couldn't add them to the cart
#==============================================================
  @sad
  Scenario: I cannot add an out of stock item to my cart
    Given an empty cart
    When I try to add item that is "out of stock" to my cart
    Then I should not be able to add the item to my cart
    

# What's a 'bad' path in this scenario?