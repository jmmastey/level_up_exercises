Feature: login to my user account

  In order to use the features on the website
  As the library user
  I should login to my account

  Scenario: successfully navigate to login page
    Given I am on the home page
    When I click on Login
    Then I am redirected to the login page

    Given I am on the login page
    When I enter my user credentials
    Then I see that I have successfully logged in
 
    Given I am on the login page
    When I enter incorrect user credentials
    Then I see I did not successfully login
    And I am again presented with the login page

   Given I am on the login page
   When I click on Create User Account
   Then I am directed to the Account Creation Page

   Given I am on the Account Creation Page
   When I enter valid account information
   And I click Create Account
   Then I see that I successfully made a user account
