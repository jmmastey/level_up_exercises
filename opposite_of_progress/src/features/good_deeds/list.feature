Feature: Good Deeds listing
  In order to get a general idea about what's happening in the congress
  As a user
  I want to see a listing of recent good deeds

  Scenario: See as listing of recent good deeds
    Given there are some good deeds
    When I visit good deeds page
    Then I should see a list of good deeds

  Scenario: See a paginated list when the page size is exeeded
    Given there are some good deeds to exceed the page size
    When I visit good deeds page
    Then I should see a paginated list of good deeds
    When I click on pagination next
    Then I should see previously hidden good deeds
