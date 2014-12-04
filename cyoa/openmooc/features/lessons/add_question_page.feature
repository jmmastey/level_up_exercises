Feature: As a user I would like to add
  page content to an activity.

  Scenario:
    Given I am on a course lesson page
    When I click "Click to add one"
    And I click "Add Question"
    And I select fill in the blank question
    And I enter new fill in the blank question content
    And I click "Create Question"
    Then I should see a new quiz page
