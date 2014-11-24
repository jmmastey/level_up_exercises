Feature: As a user I would like at add content pages
  to the lesson.

  Scenario:
    Given I am on an activity page
    When I click "Edit pages"
    And I click "Add material"
    And I enter new lesson activity content
    And I click "Create page"
    And I click "Edit pages"
    Then I should see one more lesson page
