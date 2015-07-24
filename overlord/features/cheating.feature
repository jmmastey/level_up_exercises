Feature: Cheating
  In order to save the world
  As a hero
  I should not be able to cheat

  Scenario: I should not be able to jump to the "saves the world" page
    Given I am on the hero page
    Then I should be on the home page

  Scenario: I should not be able to jump to the "boom" page
    Given I am on the blowup page
    Then I should be on the home page