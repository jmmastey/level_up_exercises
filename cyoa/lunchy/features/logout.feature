Feature: Logout of user account
  As a user
  I want to logout of the Lunchy site
  So I can use the Lunchy service

  Scenario: Invalid login email from home page
    Given I am on the home page
    When I enter an invalid email
    And I enter a valid password
    Then I should be on the login page
