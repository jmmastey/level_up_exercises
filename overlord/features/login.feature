Feature: Login
  In order to keep my bomb secure
  As a villain
  I should only allow known users to enter the site

  Scenario: Redirect to Login
    When I visit the bomb page
    Then I should be redirected to the login page

  Scenario Outline: Login redirects to bomb
    When I login as <username>
    Then I should be redirected to the <redirect_page> page
    And I should be logged in as <user>

    Examples:
      | username | redirect_page | user     |
      | villain  | bomb          | villian  |
      | dev      | bomb          | dev      |
      | civilian | bomb          | civilian |

  Scenario: Logged in users are redirected to the bomb page
    Given I am logged in
    When I visit the login page
    Then I should be redirected to the bomb page

  Scenario: Logout redirects to home
    Given I am logged in
    When I click the logout link
    Then I should be redirected to the login page
    And I should not be logged in
