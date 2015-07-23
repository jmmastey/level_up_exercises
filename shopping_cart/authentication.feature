Ability: Maintain Cart From Anonymous to Authenticated

  As a business
  We need customers to be authenticated before making purchases
  So that we can provide secure transactions

  Scenario: Anonymous cart will be added to authenticated empty cart
    Given an anonymous user who adds a product to the cart
    When the user logs in
    Then the shopping cart will contain the added products

  Scenario: Anonymous cart will be added to authenticated non-empty cart
    Given a cart with the following products from an authenticated user session:
      | product  | quantity |
      | abc      | 1        |
      | xyz      | 1        |
    And a cart with the following products from an anonymous user session:
      | product  | quantity |
      | abc      | 1        |
    When the anonymous user logs in
    Then the cart will have the following products:
      | product  | quantity |
      | abc      | 2        |
      | xyz      | 1        |
