Feature: Viewing the Legislator list
  As an end-user
  I want to view the list of legislators
  So that I can see their names (and then view legislator details)

  Background:
    Given I am on the "home" page

  @happy
  Scenario:
    When I follow "All Legislators"
    Then I should see "All Legislators" within "h3"

  @bad
  Scenario:
    When I do nothing
    Then I should not see "All Legislators" within "h3"
