Feature: villain boots bomb

  As a villain
  I want to create a new bomb
  So that I can take over the world

  Scenario: start bomb
    Given I am not yet playing
    When I go to the home page
    Then I should see "Please configure the bomb"
