Feature: As a user I would like to update a
  course at anytime

  Scenario:
    Given I am on an edit course page
    When I enter new course information
    And I click "Save"
    Then I should see the new course information

  Scenario:
    Given I am on the courses page
    When I click "Add course"
    And I enter new course information
    And I click "Save"
    Then I should see the new course information
