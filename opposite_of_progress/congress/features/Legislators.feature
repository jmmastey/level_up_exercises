Feature: Viewing the Legislator list
  As an end-user
  I want to view the list of legislators
  So that I can see their names (and then view legislator details)

  Background:
    Given there are no "legislators"
    And I am on the "home" page

  @happy
  Scenario:
    When I follow "All Legislators"
    Then I should see a title for "All Legislators"

  @bad
  Scenario: There are no legislators
    When I follow "All Legislators"
    Then I should see a message "There are no legislators to show"

  @happy
  Scenario:
    And I create a legislator named "Johnson"
    And I follow "All Legislators"
    When I follow "Johnson"
    Then I should see a message "Johnson"
