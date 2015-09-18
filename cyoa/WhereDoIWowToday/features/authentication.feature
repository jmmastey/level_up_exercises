Feature: Authentication
  As a user
  I want my account to be password-protected
  So that I have I have control of my own data
     
  Scenario: A user should be able to log in with his/her password
    Given the account "x@example.com" with password "xkcd327!" exists
    When I login with email "x@example.com", password "xkcd327!"
    Then I should be logged in as "x@example.com"

  Scenario: Unrecognized users should not be able to log in
    Given the account "x@example.com" does not exist
    When I login with email "x@example.com"
    Then I should see "Invalid email or password."
    And I should not be logged in

  Scenario: A user should not be able to log in with a bad password
    Given the account "x@example.com" with password "xkcd327!" exists
    When I login with email "x@example.com", password "!723dckx"
    Then I should see "Invalid email or password."
    And I should not be logged in
    
  Scenario: A user should be able to log out
    Given I am logged in as a normal user
    When I logout
    Then I should not be logged in
