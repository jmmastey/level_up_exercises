Feature: Activate
  As a villain
  I want to be able to activate the bomb
  In order to intensify extortion

  Scenario: Activate Bomb
    Given I am logged in as a villain
    And the bomb is inactive
    When I activate the bomb
    Then I should see an active bomb

  Scenario: Cannot activate a bomb with the wrong code
    Given I am logged in as a villain
    And the bomb is inactive
    When I use the wrong activation code
    Then I should see an inactive bomb

  Scenario: Cannot activate bombs that have not been booted
    Given I am logged in as a villain
    And the bomb has not been booted
    When I activate the bomb
    Then I should see a message about the bomb not being booted

  @Validation
  Scenario: Incorrect activation code
    Given I am logged in as a villain
    And the bomb is inactive
    When I use the wrong activation code
    Then I should see a notification that I have used the wrong activation code

  Scenario: Activation code rules
    Given I am logged in as a villain
    And the bomb is inactive
    When I use an invalid activation code
    Then I should see a notification with the rules for valid activation codes

  @Confirmation_Button
  Scenario: Bailing on confirmation should not activate the bomb
    Given I am logged in as a villain
    And the bomb is inactive
    When I use the activation code
    And I cancel the activation sequence
    Then I should see an inactive bomb
