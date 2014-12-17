Feature: Viewing the Bill list
  As an end-user
  I want to view the list of bills
  So that I can see their names (and then view bill details)

  Background:
    Given I am on the "home" page

  @happy
  Scenario:
    When I follow "All Bills"
    Then I should see a title for "All Bills"

  @bad
  Scenario: There are no bills
    Given there are no bills
    When I follow "All Bills"
    Then I should not see any bills
    And I should see a message "Sorry, there are no bills"
