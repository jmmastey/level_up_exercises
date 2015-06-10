Feature: Login
  In order to keep my bomb secure
  As a villain
  I should only allow known users to enter the site
  In order to 

  Scenario: Redirect to Login
    Given I am not logged in
    When I am not on the home page
    Then I should be redirected to the "home" page
      And I should not be logged in

  Scenario Outline: Login Redirects
    Given I am not logged in
    When I login as <username>
    Then I should be redirected to the <redirect> page
      And I should be logged in as <user>

    Examples:
      | username | redirect | user    |
      | villain  | bomb     | villian |
      | dev      | bomb     | dev     |
      | generic  | bomb     | generic |

  Scenario: Logout
    Given I am logged in as "generic"
    When I click the logout link
    Then I should be redirected to the "home" page
      And I should not be logged in
