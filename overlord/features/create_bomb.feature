Feature: Create a bomb

  Scenario: Create a bomb with valid attributes
    Given I start the app
    When I enter valid attributes
    Then the app should be redirected to bomb page

  Scenario: Create a bomb with invalid attributes
    Given I start the app
    When I enter invalid attributes
    Then the app should not be redirected to bomb page