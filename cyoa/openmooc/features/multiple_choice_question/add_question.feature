Feature: As a user I would like to add a multiple choice
  question in a quiz activity.

  Scenario:
    Given I am on a course lesson page
    When I click "Click to add one"
    And I click "Add Question"
    And I select multiple choice question
    And I enter new multiple choice question content
    And I click "Create Question"
    Then I should see new multiple choice quiz content
