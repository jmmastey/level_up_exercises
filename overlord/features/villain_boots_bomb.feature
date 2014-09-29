Feature: villain boots bomb

  As a villain
  I want to create a new bomb
  So that I can take over the world

  Scenario: open the home page
    Given I am not yet playing
    When I go to the home page
    Then I should see "Take over the world"

  Scenario: start the game
    Given I am on the home page
    When I follow "Take over the world"
    Then I should be on the inactivated page
    And I should see "Enter your activation code"

  Scenario: start a new game
    Given the bomb has already exploded
    When I press "Let's make a new bomb"
    Then I should be on the inactivated page
    And I should see "Enter your activation code"
