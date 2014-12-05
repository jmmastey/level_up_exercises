Feature: As a user I would like to edit a
  lesson on a course

  Scenario:
    Given a course with one lesson
    And I am on the edit lessons page
    When I click "Edit"
    And I enter new lesson name
    And I click "Update Lesson"
    Then I should see a new lesson name on the course page
