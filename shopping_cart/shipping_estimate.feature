Feature: Obtain shipping estimates
  As a customer
  I want to add my address information
  In order to see how much shipping will cost

  Background
    Given I am on the Shopping Cart page
    When I click "Estimate Shipping Costs"
    Then I should see "Add Address Information"

    Scenario Outline: Using Coupons
        Given I have added <hammer> hammers to my cart
        And I am logged <login_status>
        When I enter <address> in the "Street Address" box
        And I enter <city> in the "City" box
        And I enter <state> in the "State" box
        And I enter <zip> in the "Zip Code" box
        And I enter <country> in the "Country" box
        And I click "Submit My Address"
        Then I should see <message>

        Examples:
          | hammer | login_status |     address     |      city     | state |  zip  | country |                    message                                   |
          |    1   |      in      | 123 Main Street |     Chicago   |  IL   | 60614 |   US    | Your estimated shipping costs are $5.00                      | (Good path)
          |    1   |      in      | 123 Main Street | San Francisco |  CA   | 10235 |   US    | Shipping cannot be estimated at this time for your address.  | (Sad Path)
          |    0   |      in      | 123 Main Street |     Chicago   |  IL   | 60614 |   US    | You have not added any items to your cart.                   | (Sad Path)
          |    1   |      in      |        "        |        ""     |  123  | Ohio  |   ""    | The address was not entered correctly.                       | (Sad Path)
          |    1   |      in      | 123 Main Street |     London    |  ""   |  ""   |   UK    | We do not ship to your address.                              | (Bad Path)
          |    1   |      out     | 123 Main Street |     Chicago   |  IL   | 60614 |   US    | Please log in to estimate your shipping cost.                | (Bad Path)
