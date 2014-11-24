Feature: As a user I would like to add
  page content to an activity.

  Scenario:
    Given I am on a course sections page
    When I click "Click to add one"
    And I click "Add material"
    And I enter new lesson activity content
    And I click "Create page"
    Then I should see new content on the sections page
