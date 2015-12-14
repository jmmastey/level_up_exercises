Feature: Home Page
  # view and paginate bills, show voting results at a glance

  Scenario: View bills on initial visit
    Given some more bills 
    And I am on the home page
    Then I should see some bills
    And I should see a next page button
    And I should not see a previous page button

  Scenario: Paginate bills on home page
    Given some more bills
    And I am on the home page
    When I click the next page button
    Then I should see different bills
    And I should see a next page button
    And I should see a previous page button

  Scenario: show voting results
    Given some more bills
    And I am on the home page
    Then bills should include voting results
