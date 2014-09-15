Feature: Activation
  As a super-villain
  I want to activate a bomb
  In order to blow stuff up

  Background: A bomb has been booted
    Given I have booted a bomb with the default codes

  Scenario: Entering activation code and receiving prompt
    Given the bomb is not active
    When I enter activation code 1234
    Then I should see the confirmation message

  Scenario: Confirming activation
    Given the bomb is not active
    When I enter activation code 1234
    And I confirm the code
    Then the bomb should be activated
    And the number of remaining disarm attempts should be set to 3

  Scenario: Entering an incorrect activation code
    Given the bomb is not active
    When I enter activation code 5678
    Then I should see an "Invalid Activation Code" error

  Scenario: Entering activation code while bomb is active
    Given the bomb not active
    
