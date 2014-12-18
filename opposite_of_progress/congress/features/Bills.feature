Feature: Viewing the Bill list
  As an end-user
  I want to view the list of bills
  So that I can see their names (and then view bill details)

  Background:
    Given there are no "bills"
    And I am on the "home" page

  @happy
  Scenario:
    When I follow "All Bills"
    Then I should see a title for "All Bills"

  @bad
  Scenario: There are no bills
    When I follow "All Bills"
    Then I should see a message "There are no bills to show"

  @happy
  Scenario:
    And I create a bill titled "Taxes"
    And I follow "All Bills"
    When I follow "Taxes"
    Then I should see a message "Taxes"
