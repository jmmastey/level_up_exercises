Feature: Game Over Screen
  In order to signify the user has failed to defuse the bomb
  As a bomb defuser
  I want to see a game over screen that allows me to restart

  Scenario: the game over screen appears after the bomb has exploded
    Given the bomb has exploded
    Then I should see the game over screen

  Scenario: Being able to resart the game from the game over screen
    Given the bomb has exploded
    When I click the try again button
    Then the bomb state should be activation
    And I should not see the game over screen