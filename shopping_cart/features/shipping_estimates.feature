Feature: I can get shipping estimates for my shipping address
  In order to get shipping estimates
  As a remote customer
  I want to provide a shipping address and get an associated estimate

  Scenario: I enter my full address
    Given I go to the shipping address page
    When I submit a valid address
    Then I see a shipping estimate on the shopping cart page

  Scenario: I am not charged shipping when I do not have items in my cart
    Given an empty cart
    When I submit a valid address
    Then the shipping estimate is 0

  Scenario: The shipping estimate uses my shipping (not billing) address
    Given a valid shipping address in Boston
    And a valid billing address in Shreveport
    When I add 1 item
    Then the shipping estimate is the cost to ship one item to Boston

  # Cucumber is not the right tool for this test
  Scenario: Estimation takes less than 1 second at least 95% of the time

  # Cucumber is not the right tool for this test
  Scenario: My credentials are handled securely

  Scenario: I cancel out of the shipping address form
    Given I go to the shipping address page
    When I press "Cancel"
    Then I do not see an estimate on the shopping cart page
    
  Scenario: I leave out my street address
    Given I go to the shipping address page
    When I submit an address that is missing the street address
    Then I am prompted for my street address

  Scenario: I leave out my city/town
    Given I go to the shipping address page
    When I submit an address that is missing the city/town
    Then I am prompted for my city/town

  Scenario: I leave out my state
    Given I go to the shipping address page
    When I submit an address that is missing the state
    Then I am prompted for my state

  Scenario: I leave out my zipcode
    Given I go to the shipping address page
    When I submit an address that is missing the zipcode
    Then I am prompted for my zipcode

  Scenario: I enter a zipcode that doesn't match the city/town and state
    Given I go to the shipping address page
    When I submit a shipping address in Boston with zipcode 60030
    Then I see the "invalid address" page

  Scenario: I enter an address that doesn't exist
    Given I go to the shipping address page
    When I submit a non-existant shipping address
    Then I see the "invalid address" page
