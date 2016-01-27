Feature: Viewing favorite meals
  As a user
  I want to see what meals I have favorited
  In order to decide what to eat

  Background:
    Given I have a valid account
    And I am logged in
    And there are favorited meals in my favorites list

  Scenario: Viewing favorite meals
    When I visit my favorite meals list
    Then I see meals I have added to the list
    And I do not see meals I have not added to the list