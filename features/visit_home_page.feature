Feature: Visiting Home Page
  As a user
  I want to visit the homepage
  In order to sign up, login and view the list of artists

  Scenario: User visits homepage
    Given I am on the homepage
    Then I should see a link to the Artists page
    And a Login button
    And a Signup button

  Scenario: User visits signup page
    Given I am on the homepage
    When I click on Signup
    Then I should be on the Sign up page

  Scenario: User visits artists page
    Given I am on the homepage
    When I click on Artists
    Then I should be on the artists index

  Scenario: User visits login page
    Given I am on the homepage
    When I click on Login
    Then I should be on the Log in page
