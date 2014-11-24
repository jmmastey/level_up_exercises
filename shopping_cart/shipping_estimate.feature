Feature: Obtain shipping estimates
  As a customer
  I want to add my address information
  In order to see how much shipping will cost

  Background
    Given I am on the Shopping Cart page
    When I click "Estimate Shipping Costs"
    Then I should see "Add Address Information"

  Scenario: Submit a valid address (Good path)
    Given I have added a hammer to my cart
    And I am logged in
    When I enter 1 in the "Product Quantity" box
    When I enter "123 Main Street" in the "Street Address" box
    And I enter "Chicago" in the "City" box
    And I enter "IL" in the "State" box
    And I enter "60614" in the "Zip Code" box
    And I enter "United States" in the "Country" box
    And I click "Submit My Address"
    Then I should see "Your estimated shipping costs are $10.00"

  Scenario: Add an address where shipping cannot be estimated (Sad Path)
    Given I have added a hammer to my cart
    And I am logged in
    When I enter "123 Main Street" in the "Street Address" box
    And I enter "San Francisco" in the "City" box
    And I enter "CA" in the "State" box
    And I enter "10235" in the "Zip Code" box
    And I enter "United States" in the "Country" box
    And I click "Submit My Address"
    Then I should see "Sorry. Shipping cannot be estimated at this time for your address."

  Scenario: No items in cart (Sad Path)
    Given I am logged in
    When I enter "123 Main Street" in the "Street Address" box
    And I enter "San Francisco" in the "City" box
    And I enter "CA" in the "State" box
    And I enter "10235" in the "Zip Code" box
    And I enter "United States" in the "Country" box
    And I click "Submit My Address"
    Then I should see "Sorry. You have not added any items to your cart."

  Scenario: Address is not valid (Sad Path)
    Given I am logged in
    When I enter "" in the "Street Address" box
    And I enter "" in the "City" box
    And I enter "123" in the "State" box
    And I enter "Ohio" in the "Zip Code" box
    And I enter "" in the "Country" box
    And I click "Submit My Address"
    Then I should see "The Street Address was not entered correctly."
    Then I should see "The City was not entered correctly."
    Then I should see "The State was not entered correctly."
    Then I should see "The Zip Code was not entered correctly."
    Then I should see "The Country was not entered correctly."

  Scenario: Add an address that is not served (Bad Path)
    Given I have added a hammer to my cart
    And I am logged in
    When I enter "123 Main Street" in the "Street Address" box
    And I enter "London" in the "City" box
    And I enter "Great Britain" in the "Country" box
    And I click "Submit My Address"
    Then I should see "Sorry. We do not ship to your address."

  Scenario: Not logged in (Bad path)
    Given I have added a hammer to my cart
    And I am not logged in
    When I enter "123 Main Street" in the "Street Address" box
    And I enter "Chicago" in the "City" box
    And I enter "IL" in the "State" box
    And I enter "60614" in the "Zip Code" box
    And I enter "United States" in the "Country" box
    And I click "Submit My Address"
    Then I should see "Please log in to estimate your shipping cost."
