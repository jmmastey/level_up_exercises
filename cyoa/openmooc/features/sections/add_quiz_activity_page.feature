Feature: As a user I would like to add
  page content to an activity.

  Scenario:
    Given I am on a course sections page
    When I click "Click to add one"
    And I click "Add quiz"
    And I select fill in the blank question
    And I enter new fill in the blank question content
    And I click "Create question"
    Then I should see a new quiz page
