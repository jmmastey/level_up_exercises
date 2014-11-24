Feature: As a user I would like to edit
  page content of a lesson activity.

  Scenario:
    Given I am on a lesson activity page
    When I click "Edit page"
    And I enter edited lesson activity content
    And I click "Update page"
    Then I should see the edited lesson activity content
