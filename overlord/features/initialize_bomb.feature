Feature: bomb initialization
  In order to initialize the bomb
  As an evil overlord
  I want to be able to enter two numbers for the activation and deactivation code

  Background:
    Given there is currently no bomb

  Scenario: initializing bomb
    When I enter an activation code in the activation field
    And I enter a deactivation code in the deactivation field
    And I click on the initialize button
    Then I should be redirected to a page with an inactive bomb

  Scenario: initializing bomb with invalid codes
    When I enter an activation code that isn't in the proper format
    And I enter a deactivation code that isn't in the proper format
    And I click on the initialize button
    Then I should be redirected to a page indicating that I have default codes
