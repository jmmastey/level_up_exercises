Feature: As a user I like to be able
  change question to any type

  Scenario:
    Given I am on a fill in the blank question page
    When I click "Edit page"
    When I enter alias term
    And I click "Find answers"
    And I select the alias term
    And I click "Update Question"
    Then I should see the alias term for the question
