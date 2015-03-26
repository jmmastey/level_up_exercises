Feature: bomb initialization
  In order to initialize the bomb
  As an evil overlord
  I want to be able to enter two numbers for the activation and deactivation code

  Scenario: initializing bomb
    Given there is currently no bomb
    When I enter a number in the activation field
    And I enter a number in the deactivation field
    And I click on the initialize button
    Then I should be redirected to a page with an inactive bomb
