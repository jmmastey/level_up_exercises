Feature: User arm the bomb
  In order to set of the bomb
  As a user
  I want to be able to arm the bomb

  Background: Home page
    Given I am on the home page

  Scenario: View home page
    Then I should be able to enter the activation_code
    And I should be able to confirm the activation_code
    And I should be able to enter the deactivation_code

  Scenario: I boot the bomb with no code
    When I click "Arm"
    Then I am taken to the activation page

  Scenario: I boot the bomb with codes
    When I set the activation and deactivation code
    And I click "Arm"
    Then I am taken to the activation page
