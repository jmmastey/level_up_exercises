Feature: Viewing other users favorite meals
  As a user
  I want to see what meals other people have favorited
  In order to see what they like to eat

  Background:
    Given I have a valid account
    And I am logged in
    And a user that isn't me has meals saved to favorites

  Scenario: Viewing other peoples favorite meals
    When I visit a users populated favorite meals list
    Then I see meals they have added to the list
    And I do not see meals they have not added to the list
