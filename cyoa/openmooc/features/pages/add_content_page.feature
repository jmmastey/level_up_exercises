Feature: As a user I would like at add content pages
  to the lesson.

  Scenario:
    Given I am on an content page
    When I click "Edit Pages"
    And I click "Add Material"
    And I enter new content page content
    And I click "Create Content"
    And I click "Edit Pages"
    Then I should see one more lesson page
