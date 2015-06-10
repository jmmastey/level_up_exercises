Feature: Login
  In order to keep my bomb secure
  As a villain
  I should only allow known users to enter the site

  Scenario: Redirect to Login
    Given I am not logged in
    When I go to the bomb page
    Then I should be redirected to the home page

  Scenario Outline: Login Redirects
    Given I am not logged in
    When I login as <username>
    Then I should be redirected to the bomb page
    And I should be logged in as <user>

    Examples:
      | username | user    |
      | villain  | villian |
      | dev      | dev     |
      | generic  | generic |

  Scenario: Logout
    Given I am logged in as "generic"
    When I click the logout link
    Then I should be redirected to the home page
    And I should not be logged in
