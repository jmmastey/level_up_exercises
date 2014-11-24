Feature: As a user I like to be able
  change question to any type

  Scenario:
    Given I am on a fill in the blank question page
    When I click "Edit page"
    And I select multiple choice question
    Then I should see blank multiple choice question content

  Scenario:
    Given I am on a fill in the blank question page
    When I click "Edit page"
    And I select multiple choice question
    And I select fill in the blank question
    Then I should see fill in the blank question content
