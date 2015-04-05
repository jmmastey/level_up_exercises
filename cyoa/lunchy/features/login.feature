Feature: Login to user account
  As a user
  I want to login to the Lunchy site
  So I can use the Lunchy service

  Scenario: Invalid login email from home page
    Given I am on the home page
    When I enter an email for a non-existent user
    And I attempt to login
    Then I should be on the login page
    And I should see an error flash box

  Scenario: Invalid login password from home page
    Given A valid user exists
    And I am on the home page
    When I enter the user's correct email
    And I enter an invalid password
    And I attempt to login
    Then I should be on the login page
    And I should see an error flash box

  Scenario: Invalid login email from login page
    Given I am on the login page
    When I enter an email for a non-existent user
    And I attempt to login
    Then I should be on the login page
    And I should see an error flash box

  Scenario: Invalid login password from login page
    Given A valid user exists
    And I am on the login page
    When I enter the user's correct email
    And I enter an invalid password
    And I attempt to login
    Then I should be on the login page
    And I should see an error flash box

  Scenario: Successful login from home page
    Given A valid user exists
    And I am on the home page
    When I enter the user's correct email and password
    And I attempt to login
    Then I should see the user account page

  Scenario: Successful login from login page
    Given A valid user exists
    And I am on the login page
    When I enter the user's correct email and password
    And I attempt to login
    Then I should see the user account page
