Feature: Creating Users
  In order to create MTG decks
  As a MTG player
  I should be able to create user profiles

  Scenario: Create new user
    Given I visit the sign up page
    When I enter valid information
    And I sign up
    Then a new user should be saved

  Scenario: Edit user
    Given I created a user
    And I log in
    When I update my email to be 'edit@email.com'
    And I update my username to be 'EditTestUser'
    Then my email should be 'edit@email.com'
    And  my username should be 'EditTestUser'
