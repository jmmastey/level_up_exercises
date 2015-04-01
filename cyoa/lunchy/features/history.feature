Feature: Add recommendation to history
  As a user
  I want to mark a recommendation as visited
  So I can save and view my lunch history

  Scenario: Save a recommendation
    Given I am logged into my account
    And a venue exists
    When I click the Get Recommendation button
    And I click the I'm going button
    Then I should see a success alert box

  Scenario: View history
    Given I am logged into my account
    And I have saved a recommendation
    When I visit the history page
    Then I should see a venue entry
