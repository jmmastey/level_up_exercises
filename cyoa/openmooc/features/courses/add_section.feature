Feature: As a user I would like to add
  sections to a course

  Scenario:
    Given I am on the edit sections page
    When I click "Add lesson"
    And I enter new section information
    And I click "Update Course"
    Then I should see a new section on the course page
