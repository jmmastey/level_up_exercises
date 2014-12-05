Feature: As a user I would like to add
  page content to an activity.

  Scenario:
    Given I am on a course lesson page
    When I click "Click to add one"
    And I click "Add Material"
    And I enter new content page content
    And I click "Create Content"
    Then I should see new content on the lesson page
