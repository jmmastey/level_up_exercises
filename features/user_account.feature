Feature: User Accounts
  As a user
  I want to create an account on the site
  In order to use the site

  Scenario: User signs up
    Given I am on the homepage
    When I signup as a user
    Then I should be on my user page
    And I should see a message confirming the user was created

  Scenario: User signs in with invalid info
    Given I am on the homepage
    When I signup as a user with invalid data
    Then I should see user validation errors

  Scenario: View the index of users
    Given I have 2 users
    And I am on the users page
    Then I should see all the users
