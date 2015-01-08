Feature: Legislator Index
  In order to search and browse current legislators
  As a user
  I want to use legislator index

  Background:
    Given there are few legislators

  Scenario: List of legislators
    Given I am on legislators page
    Then I should see the legislator list

  Scenario: List of legislators get paged
    Given there are additional legislators to exceed the page size
      And I am on legislators page
    Then I should see paginated legislator list
      And When I click on the next pagination link
      And I should see previously hidden legislators

  Scenario: Clicks a link in the listing to get that legislators page
    Given I am on legislators page
    When I click on legsilator's name
    Then I should see that legislator's page


