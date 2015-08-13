Ability: Provide Shipping Estimates

  As a business
  We need the ability to provide shipping estimates to customers
  So that we can better enhance their overall experience
  And allow them to make decisions around high-buying times

  Background:
    Given an authenticated customer

  Scenario: Valid shipping address provided
    Given a cart with products that have been purchased
    When the customer enters an address that can be validated
    Then the customer will see an estimated shipping time

  Scenario: Invalid shipping address provided
    Given a cart with products that have been purchased
    When the customer enters an address that cannot be validated
    Then an invalid shipping address message will be displayed

  Scenario: Products with different shipping methods
    Given a cart with the following purchased products:
      | one product shipped from the company warehouse  |
      | one product shipped from a third-party supplier |
    When the customer enters an address that can be validated
    Then the customer will see estimated shipping for the company product
    And the customer will see estimated shippiny for the third-party product
