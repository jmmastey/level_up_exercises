Feature: Create user account
  As a user
  I want to create a Lunchy account
  So I can use the Lunchy service

  Scenario: Access Sign Up page
    Given I am on the home page
    When I click the signup button
    Then I should be on the signup page

  Scenario: Attempt to create account with no name
    Given I am on the signup page
    When I leave the signup fields empty
    And I attempt to create an account
    Then I should see an error message
    And the name field should be highlighted

  Scenario: Attempt to create account with no name
    Given I am on the signup page
    When I enter valid values in the signup fields
    And I do not enter a name
    And I attempt to create an account
    Then I should see an error message
    And the name field should be highlighted

  Scenario: Attempt to create account with no email 
    Given I am on the signup page
    When I enter valid values in the signup fields
    And I do not enter an email 
    And I attempt to create an account
    Then I should see an error message
    And the email field should be highlighted

  Scenario: Attempt to create account with no password 
    Given I am on the signup page
    When I enter valid values in the signup fields
    And I do not enter a password 
    And I attempt to create an account
    Then I should see an error message
    And the password field should be highlighted

  Scenario: Attempt to create account with no password confirmation
    Given I am on the signup page
    When I enter valid values in the signup fields
    And I do not enter a password confirmation
    And I attempt to create an account
    Then I should see an error message
    And the confirm password field should be highlighted

  Scenario: Create an account
    Given I am on the signup page
    When I enter valid values in the signup fields
    And I attempt to create an account
    Then I should see the user account page
