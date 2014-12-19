Feature: Viewing the Deeds
  As an end-user
  I want to view good deeds
  So that I gain (some) respect for congress

  Background:
    Given there are no "deeds"
    And I am on the "home" page

  @bad
  Scenario:
    When I am on the "home" page
    Then I should see a message "There are no good deeds to show"

  @happy
  Scenario:
    And I create a deed about "Voting"
    When I follow "Voting"
    Then I should see a message "Voting"
