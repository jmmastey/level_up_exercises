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
    When I click on pagination next
    Then I should see previously hidden legislators

  Scenario: Clicks a link in the listing to get that legislators page
    Given I am on legislators page
    When I click on legislator's name
    Then I should see that legislator's page

  @javascript
  Scenario: Select legislators from a state
    Given I have a legislator from the state of Illinois
      And I have a legislator from the state of Indiana
      And I am on legislators page
    When I select Illinois as state
    Then I should see legislator from Illinois
    But I should not see legislator from Indiana

  Scenario: Guest does not see favorite button in legislators page
    Given I am not logged in
      And I am on legislators page
    Then I should not see favorite buttons

  # Scenario: Logged in user see favorite button in legislators page
  #   Given I am logged in
  #     And I am on legislators page
  #   Then I should see favorite buttons

  # Scenario: User favorites a legislator from legislators page
  #   Given I am logged in
  #     And I am on legislators page
  #   When I favorite a legislator
  #   Then I should see that legislator favorited

  # Scenario: User unfavorites a legislator from legislators page
  #   Given I am logged in
  #     And I have favorited the legislator
  #     And I am on legislators page
  #   When I unfavorite one of legislator
  #   Then I should see that legislator unfavorited
