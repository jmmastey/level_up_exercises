Feature: Viewing favorite meals
  As an anonymous user
  I want to be prompted to login
  In order to save favorite meals to my favorites list

  Scenario: Viewing favorite meals when logged out displays a message
    When I visit the favorite meals list
    Then I see a message prompting me to log in or create an account