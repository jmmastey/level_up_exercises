Feature: As a user I would like to edit a
  section on a course

  Scenario:
    Given a course with one section
    And I am on the edit sections page
    When I click "Edit"
    And I enter new section name
    And I click "Update Lesson"
    Then I should see a new section name on the course page
