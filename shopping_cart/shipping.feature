Feature: Get shipping estimate

  Background:
    Given I am at the checkout page
    And the cart is not empty
    And I am not logged in

  Scenario: with valid address
    Given I enter a valid address
    And I click 'estimate shipping'
    Then I see the 'shipping estimate'

  Scenario: with invalid city
    Given I enter an invalid city name
    And I enter a valid state
    Then I see 'Error: Invalid City'

  Scenario: with invalid state
    Given I enter an invalid state
    Then I see 'Error: Invalid State'

  Scenario: with invalid zipcode
    Given I enter an invalid zipcode
    Then I see 'Error: Invalid Zipcode'

  Scenario: saved location with login
    Given I am logged in
    And I have a saved location in my account
    When I click 'estimate shipping'
    Then I see the 'shipping estimate'