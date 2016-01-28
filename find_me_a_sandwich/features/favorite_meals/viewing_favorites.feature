Feature: Viewing favorite meals
  As a user
  I want to see what meals I have favorited
  In order to decide what to eat

  Background:
    Given I have a valid account
    And I am logged in

  Scenario: Viewing favorite meals with items saved to favorites
    When I visit my favorite meals list
    And there are favorited meals in my favorites list
    Then I see meals I have added to the list
    And I do not see meals I have not added to the list

  Scenario: Viewing favorites page with no items saved to favorites
    When I visit my favorite meals list
    And there are no favorited meals in my favorites list
    Then I see a message telling me to add some favorites