Feature: Character selection
  As a user
  I want to specify a WoW character
  So that I can plan where to play with that character

  Scenario: The realm selection list should be complete
    Given I am on the character selection page
    Then the realm selector should contain all of the realms

  Scenario: A user should see information about an existing character
    Given I am on the character selection page
    When I submit a valid character name and a valid realm
    Then I should be on the character page for that character

  Scenario: Character name should not be case-sensitive
    Given I am on the character selection page
    When I submit a valid but lowercase character name and a valid realm
    Then I should be on the character page for that character
    
  Scenario: A user should get an error when requesting a non-existant character
    Given I am on the character selection page
    When I submit an invalid combination of name and realm
    Then I should see "does not exist"

  Scenario: A user should get an error when blizzard API is unavailable
    Given the blizzard API is unavailable
    Then I should see "is currently unavailable"
