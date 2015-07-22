Feature: Reconcile Shopping cart content when customer is logging in
  In order to allow reconciling shopping cart content
  As a Customer
  I want to keep content of my shopping cart from previous sessions and make sure I do not lose any items while logging in

  Scenario: Customer with empty anon shopping cart has a saved authenticated shopping cart with items and is logging in
    Given There are no items in the cart
    And I am not logged in
    And In a previous session my shopping cart had items
    When I log in
    Then I should see the items that i previously had in the cart

  Scenario: Customer with full anon shoping cart has a saved authenticated shopping cart with items and is logging in
    Given There are items in the cart
    And I am not logged in
    And In a previous session my shopping cart had items
    When I log in
    Then I should see the items that i previously had in the cart combined with the other items i have in my anon cart

  Scenario: Customer with full anon shoping cart has a saved authenticated shopping cart no items and is logging in
    Given There are items in the cart
    And I am not logged in
    And In a previous session my shopping cart had no items
    When I log in
    Then I should see the items that had before i logged in, in the cart