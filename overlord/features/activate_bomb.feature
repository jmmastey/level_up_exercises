Feature: Activating the bomb

  Background: Activate bomb
    Given The bomb is Armed

  Scenario: I should be able to activate the bomb
    Then I should be able to enter the activation code

  Scenario: Attempt to activate with incorrect code
    When I enter an incorrect "activation_code"
    Then the bomb doesn't activate

  Scenario: Activate with the correct code
    When I enter the correct activation_code
    Then the bomb is activated
    
