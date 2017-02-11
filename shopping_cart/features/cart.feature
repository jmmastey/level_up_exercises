@Happy
Scenario: Checking out
  Given that I am on the order page
  And that the order has at least one product
  When I click on the checkout button
  Then I am forwarded to the checkout page.

@Happy
Scenario: Refreshing the cart
  Given that I am on the order page
  When I click the refresh button
  Then the order content is refreshed
  Then the line amounts are recalculated
  Then the shipping estimates are recalculated
  Then the orders' totals are recalculated

@Happy
Scenario: Emptying the cart
  Given that I am on the order page
  When I click on the empty button
  Then the cart is flushed of all items
  Then the orders' totals are recalculated

@Happy
Scenario: Logging In with an empty cart
  Given that I entered valid login information
  When I click on the log in button
  Then the content of my previous cart is placed in my current cart

@Happy
Scenario: Logging In with an existing anonymous cart
    Given that I entered valid login information
    When I click on the log in button
    Then I am presented with the option to delete the anonymous Cart or Merge carts
    When I click on delete the anonymous cart
    Then the cart is emptied
    And the content of my previous cart is placed in my current cart
    When I click on merge carts
    Then The saved carts content is merged.
