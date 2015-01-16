Feature: bills listing
  In order to get a general idea recent legislations
  As a user
  I want to see a listing of recent bills

  Scenario: See as listing of recent bills
    Given there are some bills
    When I visit bills page
    Then I should see a list of bills

  Scenario: See a paginated list when the page size is exeeded
    Given there are some bills to exceed the page size
    When I visit bills page
    Then I should see a paginated list of bills
    When I click on pagination next
    Then I should see previously hidden bills

  Scenario: Clicks the bill link to get to the bill's page
    Given there are some bills
      And I am on bills page
    When I click on bill's name
    Then I should see that bill's page
