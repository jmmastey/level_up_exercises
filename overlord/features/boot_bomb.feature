Feature: Booting the Bomb

 Background:
    Given I am on the home page

  Scenario: I Visit the home page
    Then I should see a set activation code entry box with default value
    And I should see a set deactivation code entry box with default value
    And I should see a "Boot" button

  Scenario: I boot the bomb with custom codes
    When I set the activation and deactivation codes
    Then the bomb should be deactivated state

  Scenario: I boot the bomb with default codes
    When I click the "Boot" button
    Then I should be on the bomb interface
    And the bomb should be deactivated state
