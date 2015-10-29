Feature: Create MyCTApp Account
  As a user
  I want to create a MyCTApp account
  So that I can access more features of the app

  Scenario: Registration
    Given I am on the sign up page
    When I fill out my correct information
    And hit submit
    Then I should be signed in and on my profile
