Feature: As a user I like to be
  able to edit the question of a quiz

  Scenario:
    Given I am on a fill in the blank question page
    When I click "Edit Page"
    And I change the fill in the blank question data
    And I click "Update Question"
    And I click "Edit Page"
    Then I should see the fill in the blank question changes
