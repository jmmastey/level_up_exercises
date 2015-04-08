Feature: viewing user details
  In order to view users' details
  As a curious whatpulser
  I want to be able to see user details next to the charts

  Background:
    Given I am on the page
    And I click go

  @javascript
  Scenario: viewing detailed information
    Then I should see both country flags
    And I should see both team names
    And I should see both team key counts
    And I should see both team click counts
    And I should see both team download counts
    And I should see both team upload counts
    And I should see both team uptime counts
