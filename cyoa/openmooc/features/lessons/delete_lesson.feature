Feature: As a user I would like to add
  lessons to a course

  Scenario:
    Given a course with one lesson
    And I am on the edit lessons page
    When I click "Delete"
    Then I should be on the edit lessons page
    And I should not see new lesson info
