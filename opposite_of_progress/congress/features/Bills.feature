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
  Scenario:
    When I do nothing
    Then I should not see "All Bills" within "h3"
