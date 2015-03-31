Feature: Login to user account
  As a user
  I want to login to the Lunchy site
  So I can use the Lunchy service

  Scenario: Invalid login email from home page
    Given I am on the home page
    When I enter an invalid email
    And I enter a valid password
    Then I should be on the login page
    And I should see an error message

  Scenario: Invalid login password from home page
    Given I am on the home page
    When I enter a valid email
    And I enter an invalid password
    Then I should be on the login page
    And I should see an error message

  Scenario: Invalid login email from login page
    Given I am on the login page
    When I enter an invalid email
    And I enter a valid password
    Then I should be on the login page
    And I should see an error message

  Scenario: Invalid login password from login page
    Given I am on the login page
    When I enter a valid email
    And I enter an invalid password
    Then I should be on the login page
    And I should see an error message

  Scenario: Successful login from home page
    Given I am on the home page
    When I enter a valid email and password
    Then I should redirected to the user account page

  Scenario: Successful login from login page
    Given I am on the login  page
    When I enter a valid email and password
    Then I should redirected to the user account page
