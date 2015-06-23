Feature: login to my user account

  In order to use the features on the website
  As the library user
  I should login to my account

  Scenario: successfully navigate to login page
    Given I am on the home page
    When I click on Login
    Then I am redirected to the login page

  Scenario: successfully create and account
    Given I am on the login page
    When I click to create an account
    And I enter my new account credentials
    Then I see that I have successfully created an account

  Scenario: successfully login
    Given I have created an account
    And I am on the login page
    When I enter my credentials
    Then I see that I have successfully logged in

  Scenario: see that login attempt is unsuccessful with incorrect password
    Given I have created an account
    Given I am on the login page
    When I enter incorrect user credentials
    Then I see that I did not successfully login
