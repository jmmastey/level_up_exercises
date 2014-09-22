Feature: Activation
  As a super-villain
  I want to activate a bomb
  In order to blow stuff up

  Background: A bomb has been booted
    Given I have booted a bomb with the default codes

  @javascript
  Scenario: Entering activation code and receiving prompt
    When I enter the code 1234
    Then I should see the time prompt

  @javascript
  Scenario: Setting the timer
    When I enter the code 1234
    And I enter the time 0400
    Then the bomb should be activated

  @javascript
  Scenario: Cancelling the activation
    When I enter the code 1234
    And I enter a blank time
    Then the bomb should be deactivated

  @javascript
  Scenario: Entering activation code while bomb is active
    Given the code 1234 was entered
    When I enter the code 1234
    Then I should see the message "INVALID CODE"
