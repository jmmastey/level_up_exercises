Feature: View venue listing
  As a user
  I want to view a venue listing
  So I can see what restaurant are nearby

  Scenario: View single venue listing
    Given I am logged into my account
    And a venue exists
    When I visit the venues page
    Then I should see a venue entry

  Scenario: View multiple venue listing
    Given I am logged into my account
    And 5 venues exist
    When I visit the venues page
    Then I should see 5 venue entries
