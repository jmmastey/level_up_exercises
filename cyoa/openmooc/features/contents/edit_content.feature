Feature: As a user I would like to edit
  page content of a lesson activity.

  Scenario:
    Given I am on a lesson content page
    When I click "Edit Page"
    And I enter edited content page content
    And I click "Update Content"
    Then I should see the edited content page content
