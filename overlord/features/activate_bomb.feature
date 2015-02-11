Feature: Activating a bomb
  Background: Bomb has already been started
    Given I start the app
    And I fill in "Activation Code" with "5678"
    And I fill in "Deactivation Code" with "1111"
    And I click "Submit"
    
  Scenario: Valid activation code but no countdown time
    When I fill in "Activation Code" with "5678"
    And I click "Submit"
    Then I should see "00:00:30"

  Scenario: Valid activation code and countdown time
    When I fill in "Activation Code" with "5678"
    And I fill in "Countdown" with "60"
    And I click "Submit"
    Then I should see "00:01:00"

  Scenario: Incorrect activation code
    When I fill in "Activation Code" with "1234"
    And I click "Submit"
    Then I should see "Wrong activation code"

  Scenario: Invalid countdown
    When I fill in "Activation Code" with "5678"
    And I fill in "Countdown" with "abcd"
    And I click "Submit"
    Then I should see "Invalid countdown code"