Feature: Home Page
  # view and paginate bills, show voting results at a glance

  Scenario: View bills on initial visit
    Given I am on the home page
    Then I should see some bills

  Scenario: Paginate bills on home page
    Given I am on the home page
    When I click the next page button
    Then I should see different bills

  Scenario: show voting results
    Given I am on the home page
    Then bills should include voting results
