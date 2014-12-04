Feature: As a user I would like to add
  lessons to a course

  Scenario:
    Given I am on the edit lessons page
    When I click "Add Lesson"
    And I enter new lesson information
    And I click "Create Lesson"
    Then I should see a new lesson on the course page
